package com.example.cinema.telegrambot.model.handler;

import com.example.cinema.account.model.User;
import com.example.cinema.account.service.UserService;
import com.example.cinema.admin.repository.MovieRepository;
import com.example.cinema.cinema.model.Cinema;
import com.example.cinema.cinema.model.City;
import com.example.cinema.cinema.model.Seance;
import com.example.cinema.cinema.model.Ticket;
import com.example.cinema.cinema.repository.CinemaRepository;
import com.example.cinema.cinema.repository.SeanceRepository;
import com.example.cinema.cinema.repository.TicketRepository;
import com.example.cinema.telegrambot.cash.BotStateCash;
import com.example.cinema.telegrambot.cash.LoginCash;
import com.example.cinema.telegrambot.cash.SearchCash;
import com.example.cinema.telegrambot.dto.Emojis;
import com.example.cinema.telegrambot.dto.LoginDto;
import com.example.cinema.telegrambot.dto.SearchDto;
import com.example.cinema.telegrambot.model.BotState;
import com.example.cinema.telegrambot.model.TelegramBot;
import com.example.cinema.telegrambot.service.MenuService;
import org.apache.commons.lang3.time.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;
import org.telegram.telegrambots.meta.api.methods.BotApiMethod;
import org.telegram.telegrambots.meta.api.methods.send.SendMessage;
import org.telegram.telegrambots.meta.api.objects.Message;
import org.telegram.telegrambots.meta.api.objects.replykeyboard.InlineKeyboardMarkup;
import org.telegram.telegrambots.meta.api.objects.replykeyboard.buttons.InlineKeyboardButton;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

@Component
public class EventHandler {
    @Autowired
    @Lazy
    private TelegramBot telegramBot;

    @Autowired
    private UserService userService;
    @Autowired
    private TicketRepository ticketRepository;
    @Autowired
    private CinemaRepository cinemaRepository;
    @Autowired
    private SeanceRepository seanceRepository;
    @Autowired
    private MovieRepository movieRepository;
    @Autowired
    private MenuService menuService;

    @Autowired
    private BotStateCash botStateCash;
    @Autowired
    private LoginCash loginCash;
    @Autowired
    private SearchCash searchCash;

    public BotApiMethod<?> enterUsernameHandler(Message message, long userId) {
        SendMessage sendMessage = new SendMessage();
        sendMessage.setChatId(String.valueOf(message.getChatId()));
        String username = message.getText();

        if (userService.findByEmailOrUsername(username) == null) {
            sendMessage.setText(Emojis.MARK_FAILED + "Account with this username/email not found");
            return sendMessage;
        }
        botStateCash.saveBotState(userId, BotState.ENTER_PASSWORD);

        LoginDto loginDto = loginCash.getLoginMap().get(userId);
        loginDto.setUsername(username);
        loginCash.saveLoginCash(userId, loginDto);
        sendMessage.setText(Emojis.PASSWORD + "Enter the password for your account");
        return sendMessage;
    }

    public BotApiMethod<?> enterPasswordHandler(Message message, long userId) {
        SendMessage sendMessage = new SendMessage();
        sendMessage.setChatId(String.valueOf(message.getChatId()));
        String password = message.getText();

        LoginDto loginDto = loginCash.getLoginMap().get(userId);
        loginDto.setPassword(password);
        try {
            String username = userService.setUserTelegramId(loginDto, userId);
            sendMessage.setText(Emojis.SUCCESS_MARK +  " Welcome, " + username +
                    ". You successfully connect to A.Movie account");
            return sendMessage;
        }
        catch (Exception ex){
            sendMessage.setText(Emojis.MARK_FAILED + ex.getMessage());
            return sendMessage;
        }
    }

    public BotApiMethod<?> myTicketHandler(Message message, long userId){
        SendMessage sendMessage = new SendMessage();
        sendMessage.setChatId(String.valueOf(message.getChatId()));

        User user = userService.findByTelegramId(userId);
        if(user == null){
            sendMessage.setText(Emojis.MARK_FAILED + "Login to your A.Movie account to see your tickets");
            return sendMessage;
        }

        var tickets = ticketRepository.findByUser(user);
        return ticketListBuilder(userId, tickets);
    }

    public BotApiMethod<?> ticketListBuilder(long userId, List<Ticket> tickets) {
        SendMessage replyMessage = new SendMessage();
        replyMessage.setChatId(String.valueOf(userId));
        if (tickets.isEmpty()) {
            replyMessage.setText(Emojis.INFO_MARK + "You don't have any tickets");
            return replyMessage;
        }
        for (Ticket ticket : tickets) {
            SendMessage sendMessage = new SendMessage();
            sendMessage.setChatId(String.valueOf(userId));
            sendMessage.setText(buildTicket(ticket));
            telegramBot.sendMessage(sendMessage);
        }

        replyMessage.setText(Emojis.SUCCESS_MARK + " Tickets was successfully found");
        return replyMessage;
    }

    private String buildTicket(Ticket ticket) {
        StringBuilder builder = new StringBuilder();
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("dd.MM.yyyy HH:mm");
        Date date = ticket.getDate();
        String dateFormat = simpleDateFormat.format(date);

        builder.append(Emojis.TICKET ).append(" ").append(ticket.getNumber()).append("\n")
                .append(Emojis.CINEMA).append(" ").append(ticket.getHall().getCinema().getName()).append(", ")
                .append("Hall: ").append(ticket.getHall().getName()).append("\n")
                .append(Emojis.MOVIE).append(" ").append(ticket.getMovie().getTitle()).append("\n")
                .append(Emojis.DATE).append(" ").append(dateFormat).append("\n")
                .append(Emojis.SEAT).append(" ").append(ticket.getSeats()).append("\n")
                .append(Emojis.PRICE).append(" ").append("₴").append(ticket.getPrice());
        return builder.toString();
    }

    public BotApiMethod<?> sendCityList(long chatId) {
        SendMessage sendMessage = new SendMessage();
        sendMessage.setChatId(String.valueOf(chatId));

        var cities = Arrays.asList(City.values());

        sendMessage.setText(Emojis.CITY + " Choose city:");
        sendMessage.setReplyMarkup(menuService.getInlineMessageButtonsForCity(cities));
        return sendMessage;
    }

    public BotApiMethod<?> cityHandler(long chatId, long userId, String cityStr) {
        SendMessage sendMessage = new SendMessage();
        sendMessage.setChatId(String.valueOf(chatId));

        try {
            City city = City.valueOf(cityStr);
            var cinemas = cinemaRepository.findByCity(city);

            if(cinemas.isEmpty()){
                sendMessage.setText(Emojis.MARK_FAILED + "There are no cinemas in this city");
                botStateCash.saveBotState(userId, BotState.START);
                return sendMessage;
            }

            sendMessage.setText(Emojis.CINEMA + " Choose cinema:");
            sendMessage.setReplyMarkup(menuService.getInlineMessageButtonsForCinemas(cinemas));
        }
        catch (Exception ex){
            sendMessage.setText(Emojis.MARK_FAILED + "Can't find city with this name");
        }

        return sendMessage;
    }

    public BotApiMethod<?> cinemaHandler(long chatId, long userId, String cinemaId) {
        SendMessage sendMessage = new SendMessage();
        sendMessage.setChatId(String.valueOf(chatId));

        Cinema cinema = cinemaRepository.findActiveById(Long.parseLong(cinemaId)).orElse(null);

        if(cinema == null){
            sendMessage.setText(Emojis.MARK_FAILED + "Cinema not found");
            botStateCash.saveBotState(userId, BotState.START);
            return sendMessage;
        }

        var movies = seanceRepository.getAdminMoviesByCinema(cinema);

        if(movies.isEmpty()){
            sendMessage.setText(Emojis.MARK_FAILED + "No available movies in this cinema");
            botStateCash.saveBotState(userId, BotState.START);
            return sendMessage;
        }

        SearchDto searchDto = searchCash.getSearchMap().get(userId);
        searchDto.setCinema(cinema);
        searchCash.saveSearchCash(userId, searchDto);

        sendMessage.setText(Emojis.MOVIE + " Chose movie from the list");
        sendMessage.setReplyMarkup(menuService.getInlineMessageButtonsForMovies(movies));
        return sendMessage;
    }

    public BotApiMethod<?> movieHandler(long chatId, long userId, String movieId) {
        SendMessage sendMessage = new SendMessage();
        sendMessage.setChatId(String.valueOf(chatId));

        SearchDto searchDto = searchCash.getSearchMap().get(userId);
        Cinema cinema = searchDto.getCinema();

        if(cinema == null){
            botStateCash.saveBotState(userId, BotState.START);
            return sendCityList(chatId);
        }

        var movie = movieRepository.findAdminMovie(Long.parseLong(movieId)).orElse(null);

        if(movie == null){
            sendMessage.setText(Emojis.MARK_FAILED + "Movie not found");
            botStateCash.saveBotState(userId, BotState.START);
            return sendMessage;
        }

        var movies = seanceRepository.getAdminMoviesByCinema(cinema);

        if(movies.stream().noneMatch(m -> m.getId().equals(movie.getId()))){
            sendMessage.setText(Emojis.MARK_FAILED +
                    "Screenings for this movie were not found in " + cinema.getName() + " cinema"
            );
            return sendMessage;
        }

        sendMessage.setText(Emojis.DATE + " Enter date in format dd.mm.yyyy");
        searchDto.setMovie(movie);

        searchCash.saveSearchCash(userId, searchDto);
        botStateCash.saveBotState(userId, BotState.ENTER_DATE);
        return sendMessage;
    }

    public BotApiMethod<?> enterDateHandler(Message message, long userId) {
        SendMessage sendMessage = new SendMessage();
        sendMessage.setChatId(String.valueOf(message.getChatId()));

        SearchDto searchDto = searchCash.getSearchMap().get(userId);

        Date date;
        try {
            date = parseDate(message.getText());
        } catch (ParseException e) {
            sendMessage.setText(Emojis.MARK_FAILED + "The specified date and time cannot be recognized, please try again");
            return sendMessage;
        }

        Date now = new Date();
        if(now.after(date) && !DateUtils.isSameDay(now, date)){
            sendMessage.setText(Emojis.MARK_FAILED + "Enter a date equal or later than today");
            return sendMessage;
        }

        Date newDate = DateUtils.addMonths(new Date(), 2);
        if(date.after(newDate)){
            sendMessage.setText(Emojis.MARK_FAILED + "Enter a date less than a two months from today");
            return sendMessage;
        }

        var seances = seanceRepository.findByCinemaAndDateAndMovie(
                searchDto.getCinema(), searchDto.getMovie().getId(), date
        );

        return seanceListBuilder(userId, seances);
    }

    public BotApiMethod<?> seanceListBuilder(long userId, List<Seance> seances) {
        SendMessage replyMessage = new SendMessage();
        replyMessage.setChatId(String.valueOf(userId));

        if(seances.isEmpty()){
            replyMessage.setText(Emojis.MARK_FAILED + " There are any seance in this date");
            botStateCash.saveBotState(userId, BotState.START);
            return replyMessage;
        }

        String baseUrl = ServletUriComponentsBuilder.fromCurrentContextPath().build().toUriString();
        InlineKeyboardMarkup inlineKeyboardMarkup = new InlineKeyboardMarkup();
        InlineKeyboardButton keyboardButton = new InlineKeyboardButton();
        keyboardButton.setText("View on the site");

        for (Seance seance : seances) {
            SendMessage sendMessage = new SendMessage();
            sendMessage.setChatId(String.valueOf(userId));
            sendMessage.setText(buildSeance(seance));

            keyboardButton.setUrl(baseUrl + "/seance/" + seance.getId());
            List<InlineKeyboardButton> keyboardButtonsRow1 = new ArrayList<>();
            keyboardButtonsRow1.add(keyboardButton);
            List<List<InlineKeyboardButton>> rowList = new ArrayList<>();
            rowList.add(keyboardButtonsRow1);
            inlineKeyboardMarkup.setKeyboard(rowList);
            sendMessage.setReplyMarkup(inlineKeyboardMarkup);

            telegramBot.sendMessage(sendMessage);
        }

        replyMessage.setText(Emojis.SUCCESS_MARK + " Seances was successfully found");
        return replyMessage;
    }

    private String buildSeance(Seance seance) {
        StringBuilder builder = new StringBuilder();
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("dd.MM.yyyy");
        SimpleDateFormat simpleTimeFormat = new SimpleDateFormat("HH:mm");
        String date = simpleDateFormat.format(seance.getDate());
        String startTime = simpleTimeFormat.format(seance.getStartTime());
        String endTime = simpleTimeFormat.format(seance.getEndTime());

        Integer available = seance.countAvailableSeats();
        Integer amount = seance.getHall().getNumSeats();

        builder.append(Emojis.CINEMA).append(" ").append(seance.getHall().getCinema().getName()).append(", ")
                .append("Hall: ").append(seance.getHall().getName()).append("\n")
                .append(Emojis.MOVIE).append(" ").append(seance.getMovie().getTitle()).append("\n")
                .append(Emojis.DATE).append(" ").append(date).append("\n")
                .append(Emojis.TIME).append(" ").append(startTime).append("-").append(endTime).append("\n")
                .append(Emojis.PRICE).append(" ").append("Min price: ₴").append(seance.getPrice()).append("\n")
                .append("Available: ").append(available).append("/").append(amount);
        return builder.toString();
    }

    private Date parseDate(String s) throws ParseException {
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("dd.MM.yyyy");
        return simpleDateFormat.parse(s);
    }
}

package com.example.cinema.cinema.service;

import com.example.cinema.account.model.User;
import com.example.cinema.account.service.MailSenderService;
import com.example.cinema.cinema.dto.CheckoutDto;
import com.example.cinema.cinema.model.Reservation;
import com.example.cinema.cinema.model.Ticket;
import com.example.cinema.cinema.repository.ReservationRepository;
import com.example.cinema.cinema.repository.TicketRepository;
import com.example.cinema.telegrambot.dto.Emojis;
import com.example.cinema.telegrambot.model.TelegramBot;
import org.apache.commons.lang3.RandomStringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.telegram.telegrambots.meta.api.methods.send.SendMessage;

import java.text.SimpleDateFormat;
import java.util.*;

@Service
public class TicketService {
    @Autowired
    private TicketRepository ticketRepository;
    @Autowired
    @Lazy
    private TelegramBot telegramBot;

    @Autowired
    private ReservationRepository reservationRepository;

    public List<Ticket> ticketList(){
        return ticketRepository.findAll();
    }

    public Page<Ticket> findAll(int pageNum, String search){
        Pageable pageable = PageRequest.of(pageNum, 50, Sort.by(Sort.Direction.DESC, "createdAt"));
        if(search != null && !search.equals(""))
            return ticketRepository.search(search.toLowerCase(), pageable);

        return ticketRepository.findAll(pageable);
    }

    public Page<Ticket> ticketsByUserAdmin(User user, int pageNum){
        Pageable pageable = PageRequest.of(pageNum, 50);
        return ticketRepository.findByUser(user, pageable);
    }

    public Page<Ticket> ticketsByUser(User user, int pageNum){
        Pageable pageable = PageRequest.of(pageNum - 1, 50);
        return ticketRepository.findByUser(user, pageable);
    }

    public List<Ticket> ticketsByDate(Date date){
        return ticketRepository.findByDate(date);
    }

    public Ticket getByNumber(String number){
        Optional<Ticket> ticketOptional =  ticketRepository.findByNumber(number);
        return ticketOptional.orElse(null);
    }

    public Ticket createTicket(CheckoutDto checkoutDto, User user, Reservation reservation){
        String number = generateNumber();

        while(getByNumber(number) != null)
            number = generateNumber();

        Ticket ticket = new Ticket();
        ticket.setNumber(number);
        ticket.setEmail(checkoutDto.getEmail());
        ticket.setFirstName(checkoutDto.getFirstName());
        ticket.setLastName(checkoutDto.getLastName());
        ticket.setPhone(checkoutDto.getPhone());

        ticket.setHall(reservation.getSeance().getHall());
        ticket.setMovie(reservation.getSeance().getMovie());
        ticket.setDate(dateTime(reservation.getSeance().getDate(), reservation.getSeance().getStartTime()));

        ticket.setReservationId(reservation.getId());
        ticket.setUser(user);

        List<String> seats = new ArrayList<>();
        for(var seat : reservation.getSeats()){
            seats.add(seat.getSeat().getRow().getName() + seat.getSeat().getNumber());
        }

        ticket.setPrice(reservation.totalPrice());
        ticket.setSeats(String.join(",", seats));

        ticketRepository.save(ticket);
        sendInTelegram(ticket);

        reservation.setExpired(dateTime(reservation.getSeance().getDate(), reservation.getSeance().getEndTime()));
        reservation.setActive(false);
        reservationRepository.save(reservation);

        return ticket;
    }

    public void removeTicket(Ticket ticket){
        if(ticket.getReservationId() != null){
            try {
                reservationRepository.deleteById(ticket.getReservationId());
            }
            catch (Exception ignored){}
        }
        ticketRepository.delete(ticket);
    }


    private String generateNumber(){
        return RandomStringUtils.randomAlphanumeric(10).toUpperCase();
    }

    private Date dateTime(Date date, Date time) {
        Calendar aDate = Calendar.getInstance();
        aDate.setTime(date);

        Calendar aTime = Calendar.getInstance();
        aTime.setTime(time);

        Calendar aDateTime = Calendar.getInstance();
        aDateTime.set(Calendar.DAY_OF_MONTH, aDate.get(Calendar.DAY_OF_MONTH));
        aDateTime.set(Calendar.MONTH, aDate.get(Calendar.MONTH));
        aDateTime.set(Calendar.YEAR, aDate.get(Calendar.YEAR));
        aDateTime.set(Calendar.HOUR, aTime.get(Calendar.HOUR));
        aDateTime.set(Calendar.MINUTE, aTime.get(Calendar.MINUTE));
        aDateTime.set(Calendar.SECOND, aTime.get(Calendar.SECOND));

        return aDateTime.getTime();
    }

    private void sendInTelegram(Ticket ticket){
        if(ticket.getUser() != null) {
            Long tgId = ticket.getUser().getTelegramId();
            if (tgId != null) {
                SendMessage sendMessage = new SendMessage();
                sendMessage.setChatId(String.valueOf(tgId));
                sendMessage.setText(Emojis.INFO_MARK + " Hello," + ticket.getUser().getUsername() +
                        ". You just bought a ticket, here are the details");
                telegramBot.sendMessage(sendMessage);

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

                sendMessage.setText(builder.toString());
                telegramBot.sendMessage(sendMessage);
            }
        }
    }
}

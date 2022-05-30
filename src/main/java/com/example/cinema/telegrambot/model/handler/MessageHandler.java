package com.example.cinema.telegrambot.model.handler;

import com.example.cinema.telegrambot.cash.BotStateCash;
import com.example.cinema.telegrambot.cash.LoginCash;
import com.example.cinema.telegrambot.cash.SearchCash;
import com.example.cinema.telegrambot.dto.Emojis;
import com.example.cinema.telegrambot.dto.LoginDto;
import com.example.cinema.telegrambot.dto.SearchDto;
import com.example.cinema.telegrambot.model.BotState;
import com.example.cinema.telegrambot.service.MenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.telegram.telegrambots.meta.api.methods.BotApiMethod;
import org.telegram.telegrambots.meta.api.methods.send.SendMessage;
import org.telegram.telegrambots.meta.api.objects.Message;

@Component
public class MessageHandler {
    @Autowired
    private MenuService menuService;
    @Autowired
    private EventHandler eventHandler;

    @Autowired
    private BotStateCash botStateCash;
    @Autowired
    private LoginCash loginCash;
    @Autowired
    private SearchCash searchCash;


    public BotApiMethod<?> handle(Message message, BotState botState) {
        long userId = message.getFrom().getId();
        long chatId = message.getChatId();
        SendMessage sendMessage = new SendMessage();
        sendMessage.setChatId(String.valueOf(chatId));

        botStateCash.saveBotState(userId, botState);

        switch (botState.name()) {
            case ("START"):
                return menuService.getMainMenuMessage(message.getChatId(),
                        "Use main menu", userId);
            case ("LOGIN"):
                botStateCash.saveBotState(userId, BotState.ENTER_USERNAME);
                loginCash.saveLoginCash(userId, new LoginDto());
                sendMessage.setText(Emojis.EMAIL + "Enter your A.Movie account username/email");
                return sendMessage;
            case ("ENTER_USERNAME"):
                return eventHandler.enterUsernameHandler(message, userId);
            case ("ENTER_PASSWORD"):
                return eventHandler.enterPasswordHandler(message, userId);
            case ("MY_TICKETS"):
                return eventHandler.myTicketHandler(message, userId);
            case ("FIND_SEANCE"):
                searchCash.saveSearchCash(userId, new SearchDto());
                return eventHandler.sendCityList(message.getChatId());
            case ("ENTER_DATE"):
                return eventHandler.enterDateHandler(message, userId);
            default:
                throw new IllegalStateException("Unexpected value: " + botState);
        }
    }
}

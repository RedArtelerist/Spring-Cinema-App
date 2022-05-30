package com.example.cinema.telegrambot.model;

import com.example.cinema.telegrambot.cash.BotStateCash;
import com.example.cinema.telegrambot.model.handler.CallbackQueryHandler;
import com.example.cinema.telegrambot.model.handler.MessageHandler;
import lombok.AccessLevel;
import lombok.experimental.FieldDefaults;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.telegram.telegrambots.meta.api.methods.BotApiMethod;
import org.telegram.telegrambots.meta.api.objects.CallbackQuery;
import org.telegram.telegrambots.meta.api.objects.Message;
import org.telegram.telegrambots.meta.api.objects.Update;

@Component
@FieldDefaults(level = AccessLevel.PRIVATE)
public class TelegramFacade {
    @Autowired
    private MessageHandler messageHandler;
    @Autowired
    private CallbackQueryHandler callbackQueryHandler;
    @Autowired
    private BotStateCash botStateCash;

    public BotApiMethod<?> handleUpdate(Update update) {
        if (update.hasCallbackQuery()) {
            CallbackQuery callbackQuery = update.getCallbackQuery();
            return callbackQueryHandler.processCallbackQuery(callbackQuery);

        } else {
            Message message = update.getMessage();
            if (message != null && message.hasText()) {
                return handleInputMessage(message);
            }
        }
        return null;
    }

    private BotApiMethod<?> handleInputMessage(Message message) {
        BotState botState;
        String inputMsg = message.getText();
        botState = switch (inputMsg) {
            case "/start" -> BotState.START;
            case "My tickets" -> BotState.MY_TICKETS;
            case "Login with A.Movie account" -> BotState.LOGIN;
            case "Find seances" -> BotState.FIND_SEANCE;
            default -> botStateCash.getBotStateMap().get(message.getFrom().getId()) == null ?
                    BotState.START : botStateCash.getBotStateMap().get(message.getFrom().getId());
        };

        return messageHandler.handle(message, botState);
    }

}

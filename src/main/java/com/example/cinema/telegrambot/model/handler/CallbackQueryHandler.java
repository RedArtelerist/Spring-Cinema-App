package com.example.cinema.telegrambot.model.handler;

import com.example.cinema.account.model.User;
import com.example.cinema.account.service.UserService;
import com.example.cinema.telegrambot.cash.BotStateCash;
import com.example.cinema.telegrambot.cash.SearchCash;
import com.example.cinema.telegrambot.dto.Emojis;
import com.example.cinema.telegrambot.model.BotState;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.telegram.telegrambots.meta.api.methods.BotApiMethod;
import org.telegram.telegrambots.meta.api.methods.send.SendMessage;
import org.telegram.telegrambots.meta.api.objects.CallbackQuery;

@Component
public class CallbackQueryHandler {
    @Autowired
    private BotStateCash botStateCash;
    @Autowired
    private EventHandler eventHandler;
    @Autowired
    private UserService userService;

    public BotApiMethod<?> processCallbackQuery(CallbackQuery buttonQuery) {
        final long chatId = buttonQuery.getMessage().getChatId();
        final long userId = buttonQuery.getFrom().getId();
        BotApiMethod<?> callBackAnswer = null;

        User user = userService.findByTelegramId(userId);
        if(user == null) {
            callBackAnswer = new SendMessage(String.valueOf(chatId), Emojis.MARK_FAILED + "Login");
            botStateCash.saveBotState(userId, BotState.START);
            return callBackAnswer;
        }

        String[] data = buttonQuery.getData().split(":");

        switch (data[0]) {
            case "city" -> {
                callBackAnswer = eventHandler.cityHandler(chatId, userId, data[1]);
                botStateCash.saveBotState(userId, BotState.START);
            }
            case ("cinema") -> {
                callBackAnswer = eventHandler.cinemaHandler(chatId, userId, data[1]);
                botStateCash.saveBotState(userId, BotState.START);
            }
            case ("movie") -> {
                callBackAnswer = eventHandler.movieHandler(chatId, userId, data[1]);
            }
        }
        return callBackAnswer;
    }
}

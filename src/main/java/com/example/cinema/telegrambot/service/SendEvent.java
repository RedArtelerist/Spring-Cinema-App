package com.example.cinema.telegrambot.service;

import com.example.cinema.telegrambot.config.ApplicationContextProvider;
import com.example.cinema.telegrambot.model.TelegramBot;
import lombok.Setter;
import lombok.SneakyThrows;
import org.telegram.telegrambots.meta.api.methods.send.SendMessage;

@Setter
public class SendEvent extends Thread {
    private long notificationCashId;
    private SendMessage sendMessage;

    public SendEvent() {
    }

    @SneakyThrows
    @Override
    public void run() {
        TelegramBot telegramBot = ApplicationContextProvider.getApplicationContext().getBean(TelegramBot.class);
        NotificationCashService service = ApplicationContextProvider.getApplicationContext().getBean(NotificationCashService.class);
        telegramBot.execute(sendMessage);
        //if event it worked, need to remove it from the database of unresolved events
        service.delete(notificationCashId);
    }
}

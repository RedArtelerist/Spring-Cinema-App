package com.example.cinema.telegrambot.service;

import com.example.cinema.telegrambot.entity.NotificationCash;
import lombok.SneakyThrows;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.telegram.telegrambots.meta.api.methods.send.SendMessage;

import javax.annotation.PostConstruct;
import java.util.List;
import java.util.Timer;

@Component
public class SendNotificationFromCash {
    @Autowired
    private NotificationCashService notificationService;

    @PostConstruct
    @SneakyThrows
    private void afterStart() {
        List<NotificationCash> list = notificationService.findAll();

        if (!list.isEmpty()) {
            for (NotificationCash notification : list) {
                SendEvent sendEvent = new SendEvent();
                sendEvent.setSendMessage(new SendMessage(String.valueOf(notification.getUserId()), notification.getDescription()));
                sendEvent.setNotificationCashId(notification.getId());

                new Timer().schedule(new SimpleTask(sendEvent), notification.getDate());
            }
        }
    }
}

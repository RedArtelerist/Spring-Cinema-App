package com.example.cinema.telegrambot.entity;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import java.util.Date;

@Entity
@Getter
@Setter
public class NotificationCash {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private Date date;

    private String description;

    private Long userId;

    public NotificationCash() {
    }

    public static NotificationCash notificationTo(Date date, String description, Long userId) {
        NotificationCash eventCashEntity = new NotificationCash();
        eventCashEntity.setDate(date);
        eventCashEntity.setDescription(description);
        eventCashEntity.setUserId(userId);
        return eventCashEntity;
    }
}

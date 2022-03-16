package com.example.cinema.telegrambot.service;

import com.example.cinema.telegrambot.entity.NotificationCash;
import com.example.cinema.telegrambot.repository.NotificationCashRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class NotificationCashService {
    @Autowired
    private NotificationCashRepository notificationRepository;

    public List<NotificationCash> findAll() {
        return notificationRepository.findAll();
    }

    public void save(NotificationCash eventCashEntity) {
        notificationRepository.save(eventCashEntity);
    }

    public void delete(Long id) {
        notificationRepository.deleteById(id);
    }
}

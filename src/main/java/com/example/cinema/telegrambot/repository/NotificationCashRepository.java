package com.example.cinema.telegrambot.repository;

import com.example.cinema.telegrambot.entity.NotificationCash;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface NotificationCashRepository extends JpaRepository<NotificationCash, Long> {
    Optional<NotificationCash> findById(Long id);
}

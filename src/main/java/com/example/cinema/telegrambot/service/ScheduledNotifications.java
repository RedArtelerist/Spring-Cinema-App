package com.example.cinema.telegrambot.service;

import com.example.cinema.cinema.model.Ticket;
import com.example.cinema.cinema.repository.TicketRepository;
import com.example.cinema.telegrambot.dto.Emojis;
import com.example.cinema.telegrambot.entity.NotificationCash;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.telegram.telegrambots.meta.api.methods.send.SendMessage;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Timer;

@EnableScheduling
@Service
public class ScheduledNotifications {
    @Autowired
    private TicketRepository ticketRepository;

    @Autowired
    private NotificationCashService notificationService;

    @Scheduled(cron = "0 0 0 * * *")
    private void notifyTickets() {
        Date now = new Date();
        List<Ticket> tickets = ticketRepository.findWithTelegramUsers(now);

        for (Ticket ticket : tickets) {
            Calendar calendar = Calendar.getInstance();
            calendar.setTime(ticket.getDate());
            calendar.add(Calendar.HOUR, -2);
            var time = calendar.getTime();

            String description = getDescription(ticket);
            String userId = String.valueOf(ticket.getUser().getTelegramId());

            NotificationCash notificationCash = NotificationCash.notificationTo(
                    time, description, ticket.getUser().getTelegramId()
            );
            notificationService.save(notificationCash);

            SendEvent sendEvent = new SendEvent();
            sendEvent.setSendMessage(new SendMessage(userId, description));
            sendEvent.setNotificationCashId(notificationCash.getId());

            new Timer().schedule(new SimpleTask(sendEvent), time);
        }
    }

    private String getDescription(Ticket ticket){
        SimpleDateFormat simpleTimeFormat = new SimpleDateFormat("HH:mm");
        String time = simpleTimeFormat.format(ticket.getDate());

        return "We remind, today you have a movie ticket:\n" +
                Emojis.MOVIE + " " + ticket.getMovie().getTitle() + "\n" +
                Emojis.TIME + " " + time + " \n" +
                Emojis.CINEMA + " " + ticket.getHall().getCinema().getName() +
                "\nDon't forget";
    }
}

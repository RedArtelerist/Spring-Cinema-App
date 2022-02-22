package com.example.cinema.component;

import com.example.cinema.account.model.PasswordResetToken;
import com.example.cinema.account.service.PasswordResetTokenService;
import com.example.cinema.cinema.model.Reservation;
import com.example.cinema.cinema.model.Seance;
import com.example.cinema.cinema.repository.SeanceRepository;
import com.example.cinema.cinema.service.ReservationService;
import org.apache.commons.lang3.time.DateUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.util.Date;
import java.util.List;

@Component
public class ScheduledTasks {
    private static final Logger log = LoggerFactory.getLogger(ScheduledTasks.class);
    private static final SimpleDateFormat dateFormat = new SimpleDateFormat("HH:mm:ss");

    @Autowired
    private PasswordResetTokenService resetTokenService;

    @Autowired
    private SeanceRepository seanceRepository;

    @Autowired
    private ReservationService reservationService;

    @Scheduled(fixedRate = 300000)
    public void clearAllTokens() {
        List<PasswordResetToken> tokens = resetTokenService.findAllExpiredTokens(LocalDateTime.now());

        for(var token : tokens){
            resetTokenService.deletePasswordResetToken(token.getId());
        }
    }

    @Scheduled(fixedRate = 10000)
    public void clearAllSeances() {
        Date now = new Date();
        Date date = DateUtils.addMinutes(now, 2);

        List<Seance> seances = seanceRepository.findExpiredSeances(date, date);

        for(Seance seance : seances){
            seance.setAvailable(false);
            seanceRepository.save(seance);
        }
    }

    @Scheduled(fixedRate = 10000)
    public void deleteEndedSeances() {
        Date now = new Date();
        List<Seance> seances = seanceRepository.findEndedSeances(now, now);

        for(Seance seance : seances)
            seanceRepository.delete(seance);
    }

    @Scheduled(fixedRate = 10000)
    public void clearAllReservations() {
        log.info("The time is now {}", dateFormat.format(new Date()));

        List<Reservation> reservations = reservationService.findExpiredReservations();
        for(Reservation reservation : reservations){
            reservationService.removeReservation(reservation);
        }
    }
}
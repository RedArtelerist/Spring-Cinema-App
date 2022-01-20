package com.example.cinema.component;

import com.example.cinema.account.model.PasswordResetToken;
import com.example.cinema.account.service.PasswordResetTokenService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.util.List;

@Component
public class ScheduledTasks {
    private static final Logger log = LoggerFactory.getLogger(ScheduledTasks.class);
    private static final SimpleDateFormat dateFormat = new SimpleDateFormat("HH:mm:ss");

    @Autowired
    private PasswordResetTokenService resetTokenService;

    @Scheduled(fixedRate = 300000)
    public void clearAllTokens() {
        List<PasswordResetToken> tokens = resetTokenService.findAllExpiredTokens(LocalDateTime.now());

        for(var token : tokens){
            resetTokenService.deletePasswordResetToken(token.getId());
        }
    }
}
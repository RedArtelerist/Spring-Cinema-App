package com.example.cinema.account.service;

import com.example.cinema.account.model.PasswordResetToken;
import com.example.cinema.account.model.User;
import com.example.cinema.account.repository.PasswordResetTokenRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Optional;

@Service
public class PasswordResetTokenService {
    @Autowired
    private PasswordResetTokenRepository resetTokenRepository;

    public List<PasswordResetToken> findAllExpiredTokens(LocalDateTime date){
        return resetTokenRepository.findExpiredTokens(date);
    }

    public List<PasswordResetToken> findByUser(User user){
        return resetTokenRepository.findByUser(user);
    }

    public void savePasswordResetToken(PasswordResetToken passwordResetToken) {
        resetTokenRepository.save(passwordResetToken);
    }

    public void deletePasswordResetToken(Long id){
        resetTokenRepository.deleteById(id);
    }

    public Optional<PasswordResetToken> findPasswordResetTokenByToken(String token) {
        return resetTokenRepository.findByResetToken(token);
    }

    public String validatePasswordResetToken(String token) {
        Optional<PasswordResetToken> passToken = resetTokenRepository.findByResetToken(token);

        return !isTokenFound(passToken) ? "invalidToken"
                : isTokenExpired(passToken.get()) ? "expired"
                : null;
    }

    private boolean isTokenFound(Optional<PasswordResetToken> passToken) {
        return passToken.isPresent();
    }

    private boolean isTokenExpired(PasswordResetToken passToken) {
        final Calendar cal = Calendar.getInstance();
        Date expiryDate = Date.from(passToken.getExpiredDate().atZone(ZoneId.systemDefault()).toInstant());
        return expiryDate.before(cal.getTime());
    }
}

package com.example.cinema.account.repository;

import com.example.cinema.account.model.ConfirmationToken;
import com.example.cinema.account.model.PasswordResetToken;
import com.example.cinema.account.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.Date;
import java.util.List;
import java.util.Optional;

@Repository
public interface PasswordResetTokenRepository extends JpaRepository<PasswordResetToken, Long> {
    Optional<PasswordResetToken> findByResetToken(String token);

    @Query("select p from PasswordResetToken p where p.expiredDate < :now")
    List<PasswordResetToken> findExpiredTokens(@Param("now") LocalDateTime now);

    List<PasswordResetToken> findByUser(User user);

}

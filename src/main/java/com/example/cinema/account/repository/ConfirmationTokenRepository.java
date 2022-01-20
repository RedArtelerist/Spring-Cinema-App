package com.example.cinema.account.repository;

import com.example.cinema.account.model.ConfirmationToken;
import com.example.cinema.account.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface ConfirmationTokenRepository extends JpaRepository<ConfirmationToken, Long> {
    Optional<ConfirmationToken> findConfirmationTokenByConfirmationToken(String token);

    List<ConfirmationToken> findByUser(User user);
}

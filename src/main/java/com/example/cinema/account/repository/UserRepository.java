package com.example.cinema.account.repository;

import com.example.cinema.account.model.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {
    Page<User> findAll(Pageable pageable);

    Optional<User> findByUsernameIgnoreCase(String username);

    Optional<User> findByEmail(String email);

    @Query("select u from User u where u.telegramId = :id and u.active = true and u.locked = false")
    Optional<User> findByTelegramId(@Param("id") Long id);

    @Query("SELECT u FROM User u WHERE lower(u.username) LIKE %?1%"
            + " OR lower(u.firstName) LIKE %?1%"
            + " OR lower(u.lastName) LIKE %?1%"
            + " OR lower(u.email) LIKE %?1%")
    Page<User> search(@Param("key") String keyword, Pageable pageable);
}

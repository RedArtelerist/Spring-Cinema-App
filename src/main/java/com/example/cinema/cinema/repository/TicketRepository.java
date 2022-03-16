package com.example.cinema.cinema.repository;

import com.example.cinema.account.model.User;
import com.example.cinema.cinema.model.Ticket;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.Date;
import java.util.List;
import java.util.Optional;

@Repository
public interface TicketRepository extends JpaRepository<Ticket, Long> {
    Optional<Ticket> findByNumber(String number);

    @Query("SELECT t FROM Ticket t WHERE lower(t.firstName) LIKE %?1%"
            + " OR lower(t.lastName) LIKE %?1%"
            + " OR lower(t.phone) LIKE %?1%"
            + " OR lower(t.email) LIKE %?1%"
            + " OR lower(t.movie.title) LIKE %?1%")
    Page<Ticket> search(@Param("key") String keyword, Pageable pageable);

    @Query("select t from Ticket t where t.user = :user order by t.createdAt desc")
    Page<Ticket> findByUser(@Param("user") User user, Pageable pageable);

    @Query("select t from Ticket t where t.user = :user order by t.createdAt asc")
    List<Ticket> findByUser(@Param("user") User user);

    @Query("select t from Ticket t where t.reservationId = :id")
    List<Ticket> findByReservationId(Long id);

    @Query("select t from Ticket t where date(t.createdAt) = date(:d) order by t.createdAt desc")
    List<Ticket> findByDate(@Param("d") Date date);

    @Query("select t from Ticket t where date(t.date) = date(:d) and t.user.telegramId is not null")
    List<Ticket> findWithTelegramUsers(@Param("d") Date date);
}

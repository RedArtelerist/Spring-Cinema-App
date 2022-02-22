package com.example.cinema.cinema.repository;

import com.example.cinema.account.model.User;
import com.example.cinema.cinema.model.Reservation;
import com.example.cinema.cinema.model.Seance;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.Date;
import java.util.List;
import java.util.Optional;

@Repository
public interface ReservationRepository extends JpaRepository<Reservation, Long> {
    @Query("select r from Reservation r where r.id = :id and r.active = true ")
    Optional<Reservation> getActiveById(@Param("id") Long id);

    List<Reservation> findBySeance(Seance seance, Sort sort);

    @Query("select r from Reservation r where r.user = :user and r.active = true")
    List<Reservation> findByUser(@Param("user") User user);

    @Query("select r from Reservation r where r.user = :user")
    List<Reservation> findAllByUser(@Param("user") User user);

    @Query("select r from Reservation r where r.session = :session and r.active = true")
    List<Reservation> findBySession(@Param("session") String session);

    @Query("select r from Reservation r where r.expired < :now")
    List<Reservation> findExpiredReservations(@Param("now") Date now);
}

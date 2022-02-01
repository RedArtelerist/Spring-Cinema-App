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

@Repository
public interface ReservationRepository extends JpaRepository<Reservation, Long> {
    List<Reservation> findBySeance(Seance seance, Sort sort);

    List<Reservation> findByUser(User user);

    List<Reservation> findBySession(String session);

    @Query("select r from Reservation r where r.expired < :now")
    List<Reservation> findExpiredReservations(@Param("now") Date now);
}

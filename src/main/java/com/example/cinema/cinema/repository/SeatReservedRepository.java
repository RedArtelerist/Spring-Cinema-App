package com.example.cinema.cinema.repository;

import com.example.cinema.cinema.model.Reservation;
import com.example.cinema.cinema.model.Seance;
import com.example.cinema.cinema.model.Seat;
import com.example.cinema.cinema.model.SeatReserved;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface SeatReservedRepository extends JpaRepository<SeatReserved, Long> {
    @Query("select s from SeatReserved s where s.reservation.seance = :seance and s.seat = :seat")
    List<SeatReserved> findBySeanceAndSeat(Seance seance, Seat seat);

    List<SeatReserved> findByReservation(Reservation reservation);
}

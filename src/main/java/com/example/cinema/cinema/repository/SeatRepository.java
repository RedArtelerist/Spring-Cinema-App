package com.example.cinema.cinema.repository;

import com.example.cinema.cinema.model.Row;
import com.example.cinema.cinema.model.Seat;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface SeatRepository extends JpaRepository<Seat, Long> {
    List<Seat> findByRow(Row row);

}

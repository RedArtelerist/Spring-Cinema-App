package com.example.cinema.cinema.repository;

import com.example.cinema.cinema.model.Hall;
import com.example.cinema.cinema.model.Row;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface RowRepository extends JpaRepository<Row, Long> {
    List<Row> findByHall(Hall hall, Sort sort);

    Row findByHallAndName(Hall hall, String name);
}

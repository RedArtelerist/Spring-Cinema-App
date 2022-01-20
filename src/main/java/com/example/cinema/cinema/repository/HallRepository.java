package com.example.cinema.cinema.repository;

import com.example.cinema.cinema.model.Cinema;
import com.example.cinema.cinema.model.Hall;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface HallRepository extends JpaRepository<Hall, Long> {
    List<Hall> findAll(Sort sort);

    @Query("select c from Hall c where c.id = :id and c.active = true")
    Optional<Hall> findActiveById(@Param("id") Long id);

    List<Hall> findByCinema(Cinema cinema, Sort sort);

}

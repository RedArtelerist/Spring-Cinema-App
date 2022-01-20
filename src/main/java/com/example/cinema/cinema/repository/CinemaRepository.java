package com.example.cinema.cinema.repository;

import com.example.cinema.cinema.model.Cinema;
import com.example.cinema.cinema.model.City;
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
public interface CinemaRepository extends JpaRepository<Cinema, Long> {
    @Query("select c from Cinema c where lower(c.name) LIKE %?1% or lower(c.city) LIKE %?1%")
    Page<Cinema> findCinemasForAdmin(String search, Pageable pageable);

    @Query("select c from Cinema c where c.id = :id and c.active = true")
    Optional<Cinema> findActiveById(@Param("id") Long id);

    @Query("select c from Cinema c where c.city = :city and c.active = true")
    List<Cinema> findByCity(@Param("city") City city, Sort sort);
}

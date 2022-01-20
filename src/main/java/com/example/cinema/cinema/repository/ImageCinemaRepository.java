package com.example.cinema.cinema.repository;

import com.example.cinema.cinema.model.ImageCinema;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ImageCinemaRepository extends JpaRepository<ImageCinema, Long> {
}

package com.example.cinema.admin.repository;

import com.example.cinema.admin.model.ImageMovie;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ImageMovieRepository extends JpaRepository<ImageMovie, Long> {
}

package com.example.cinema.admin.repository;

import com.example.cinema.account.model.User;
import com.example.cinema.admin.model.Movie;
import com.example.cinema.admin.model.Star;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface StarRepository extends JpaRepository<Star, Long> {
    Page<Star> findAll(Pageable pageable);

    @Query("SELECT s from Star s where s.id = :id and s.status = true")
    Optional<Star> findActiveById(@Param("id") Long id);

    @Query("SELECT s FROM Star s WHERE lower(s.firstName) LIKE %?1%"
            + " OR lower(s.firstName) LIKE %?1%"
            + " OR lower(s.lastName) LIKE %?1%"
            + " OR lower(s.birthPlace) LIKE %?1%"
    )
    Page<Star> search(String search, Pageable pageable);
}

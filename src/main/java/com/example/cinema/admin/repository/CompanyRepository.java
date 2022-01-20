package com.example.cinema.admin.repository;

import com.example.cinema.admin.model.Company;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface CompanyRepository extends JpaRepository<Company, Long> {
    @Query("SELECT c FROM Company c WHERE lower(c.name) LIKE %?1%")
    Page<Company> findAll(String search, Pageable pageable);

    Optional<Company> findByName(String name);
}

package com.example.cinema.main.repository;

import com.example.cinema.main.model.ContactUsMessage;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ContactUsRepository extends JpaRepository<ContactUsMessage, Long> {
    Page<ContactUsMessage> findAll(Pageable pageable);
}

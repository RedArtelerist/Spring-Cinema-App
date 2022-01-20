package com.example.cinema.cinema.service;

import com.example.cinema.cinema.model.Cinema;
import com.example.cinema.cinema.model.Hall;
import com.example.cinema.cinema.repository.HallRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class HallService {
    @Autowired
    private HallRepository hallRepository;

    public List<Hall> findAll() {
        return hallRepository.findAll(Sort.by(Sort.Direction.ASC, "name"));
    }

    public List<Hall> findByCinema(Cinema cinema){
        return hallRepository.findByCinema(cinema, Sort.by(Sort.Direction.ASC, "name"));
    }

    public Hall getById(Long id){
        Optional<Hall> hallOptional = hallRepository.findById(id);
        return hallOptional.orElse(null);
    }

    public Hall findById(Long id){
        Optional<Hall> hallOptional = hallRepository.findActiveById(id);
        return hallOptional.orElse(null);
    }

    public void saveHall(Hall hall){
        hallRepository.save(hall);
    }

    public void updateHall(Hall currentHall, Hall hall){
        currentHall.setName(hall.getName());
        currentHall.setCinema(hall.getCinema());
        currentHall.setActive(hall.isActive());

        hallRepository.save(currentHall);
    }

    public void delete(Hall hall) {
        hallRepository.delete(hall);
    }
}

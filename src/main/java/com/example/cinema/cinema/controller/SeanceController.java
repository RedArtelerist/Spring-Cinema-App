package com.example.cinema.cinema.controller;

import com.example.cinema.account.model.User;
import com.example.cinema.cinema.model.Hall;
import com.example.cinema.cinema.model.Seance;
import com.example.cinema.cinema.model.Seat;
import com.example.cinema.cinema.repository.SeatRepository;
import com.example.cinema.cinema.service.HallService;
import com.example.cinema.cinema.service.ReservationService;
import com.example.cinema.cinema.service.RowService;
import com.example.cinema.cinema.service.SeanceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.context.request.RequestContextHolder;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Controller
public class SeanceController {
    @Autowired
    private SeanceService seanceService;

    @Autowired
    private HallService hallService;

    @Autowired
    private RowService rowService;

    @Autowired
    private SeatRepository seatRepository;

    @Autowired
    private ReservationService reservationService;

    @GetMapping("/seance/{id}")
    public String seanceDetail(@PathVariable Long id, Model model){
        Seance seance = seanceService.findById(id);

        if(seance == null)
            throw new RuntimeException("Seance not found");

        model.addAttribute("seance", seance);
        model.addAttribute("hall", hallService.getById(seance.getHall().getId()));
        model.addAttribute("rows", rowService.findByHall(seance.getHall()));

        return "main/cinema/seance";
    }

    @PostMapping("/seance/{seanceId}/reserve")
    public ResponseEntity<?> createReservation(
            @AuthenticationPrincipal User user, @PathVariable Long seanceId, @RequestBody List<Long> seatsIds
    ){
        String session = null;
        Seance seance = seanceService.findById(seanceId);

        if(seance == null)
            return new ResponseEntity<>(new Error("Seance not found"), HttpStatus.BAD_REQUEST);

        if(user == null) {
            session = RequestContextHolder.currentRequestAttributes().getSessionId();
            if(reservationService.findBySession(session).size() >= 3)
                return new ResponseEntity<>(new Error(
                        "You have made too many reservations. Finish the rest of the reservation or cancel them."),
                        HttpStatus.BAD_REQUEST
                );
        } else {
            if(reservationService.findByUser(user).size() >= 3)
                return new ResponseEntity<>(new Error(
                        "You have made too many reservations. Finish the rest of the reservation or cancel them."),
                        HttpStatus.BAD_REQUEST
                );
        }

        List<Seat> seats = new ArrayList<>();
        for(Long id : seatsIds){
            Optional<Seat> seat = seatRepository.findById(id);
            if(seat.isEmpty())
                return new ResponseEntity<>(new Error("Seats are not exist"), HttpStatus.BAD_REQUEST);
            else
                seats.add(seat.get());
        }

        if(!checkIfSeatsInSeance(seance, seats))
            return new ResponseEntity<>(new Error("Something went wrong"), HttpStatus.BAD_REQUEST);

        try {
            Long id = reservationService.createReservation(seance, seats, user, session);
            return new ResponseEntity<>(id, HttpStatus.OK);
        }
        catch (Exception ex){
            return new ResponseEntity<>(new Error(ex.getMessage()), HttpStatus.BAD_REQUEST);
        }
    }

    private boolean checkIfSeatsInSeance(Seance seance, List<Seat> seats){
        Hall hall = seance.getHall();

        for(Seat seat : seats){
            if(seat.getRow().getHall() != hall)
                return false;
        }
        return true;
    }
}

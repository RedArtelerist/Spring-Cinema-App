package com.example.cinema.cinema.controller;

import com.example.cinema.account.model.User;
import com.example.cinema.cinema.model.Reservation;
import com.example.cinema.cinema.model.SeatReserved;
import com.example.cinema.cinema.model.Type;
import com.example.cinema.cinema.service.ReservationService;
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

import java.util.List;

@Controller
public class ReservationController {
    @Autowired
    private ReservationService reservationService;

    @GetMapping("/reservation/{id}")
    public String checkout(@AuthenticationPrincipal User user, @PathVariable Long id, Model model){
        var reservation = reservationService.findById(id);
        if(reservation == null)
            throw new RuntimeException("Reservation not found");

        String session = RequestContextHolder.currentRequestAttributes().getSessionId();

        setItems(reservation.getSeats(), model);
        if(user != null){
            if(reservation.getUser().equals(user)) {
                model.addAttribute("reservation", reservation);
                return "main/cinema/checkout";
            }
        } else {
            if(session.equals(reservation.getSession())) {
                model.addAttribute("reservation", reservation);
                return "main/cinema/checkout";
            }
        }
        throw new RuntimeException("Reservation not found");
    }

    @PostMapping("/reservation/{id}/cancel")
    public ResponseEntity<?> createReservation(@PathVariable Long id){
        var reservation = reservationService.findById(id);

        if(reservation == null)
            return new ResponseEntity<>(new Error("Reservation not found"), HttpStatus.BAD_REQUEST);

        Long seanceId = reservation.getSeance().getId();
        reservationService.removeReservation(reservation);

        return new ResponseEntity<>(seanceId, HttpStatus.OK);
    }

    private void setItems(List<SeatReserved> seats, Model model){
        int standard = 0, vip = 0, premium = 0;
        int standardPrice = 0, vipPrice = 0, premiumPrice = 0;
        for(var seat : seats){
            if(seat.getSeat().getType() == Type.Standard) {
                standard += 1;
                standardPrice = seat.getPrice();
            }
            if(seat.getSeat().getType() == Type.Vip) {
                vip += 1;
                vipPrice = seat.getPrice();
            }
            if(seat.getSeat().getType() == Type.Premium) {
                premium += 1;
                premiumPrice = seat.getPrice();
            }
        }
        model.addAttribute("standardCount", standard);
        model.addAttribute("vipCount", vip);
        model.addAttribute("premiumCount", premium);

        model.addAttribute("standardPrice", standardPrice);
        model.addAttribute("vipPrice", vipPrice);
        model.addAttribute("premiumPrice", premiumPrice);
    }
}

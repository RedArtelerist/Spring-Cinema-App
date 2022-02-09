package com.example.cinema.cinema.controller;

import com.example.cinema.account.model.User;
import com.example.cinema.account.service.MailSenderService;
import com.example.cinema.cinema.dto.ChargeRequest;
import com.example.cinema.cinema.dto.CheckoutDto;
import com.example.cinema.cinema.model.SeatReserved;
import com.example.cinema.cinema.model.Ticket;
import com.example.cinema.cinema.model.Type;
import com.example.cinema.cinema.service.ReservationService;
import com.example.cinema.cinema.service.StripeService;
import com.example.cinema.cinema.service.TicketService;
import com.stripe.exception.StripeException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.validation.Valid;
import java.util.List;

@Controller
public class ReservationController {
    @Value("${STRIPE_PUBLIC_KEY}")
    private String stripePublicKey;

    @Autowired
    private ReservationService reservationService;

    @Autowired
    private TicketService ticketService;

    @Autowired
    private MailSenderService mailSenderService;

    @Autowired
    private StripeService stripeService;

    private static final Logger log = LoggerFactory.getLogger(ReservationController.class);

    @GetMapping("/reservation/{id}")
    public String checkout(@AuthenticationPrincipal User user, @PathVariable Long id, Model model){
        var reservation = reservationService.findById(id);
        if(reservation == null)
            throw new RuntimeException("Reservation not found");

        String session = RequestContextHolder.currentRequestAttributes().getSessionId();
        setItems(reservation.getSeats(), model);

        Double amount = (reservation.totalPrice() / 28.0d) * 100;
        model.addAttribute("amount", amount.intValue()); // in cents
        model.addAttribute("stripePublicKey", stripePublicKey);
        model.addAttribute("currency", "USD");

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

    @PostMapping("/reservation/{id}")
    public String checkout(
            @AuthenticationPrincipal User user, @PathVariable Long id, @Valid CheckoutDto checkoutDto,
            ChargeRequest chargeRequest, BindingResult bindingResult, Model model, RedirectAttributes redirect
    ) {
        var reservation = reservationService.findById(id);

        if(reservation == null)
            throw new RuntimeException("Reservation not found");

        if(bindingResult.hasErrors()) {
            redirect.addFlashAttribute("error", "Something went wrong, try again");
            return "redirect:/reservation/" + reservation.getId();
        }
        try {
            stripeService.charge(chargeRequest);
        } catch (StripeException ex){
            redirect.addFlashAttribute("error", ex.getUserMessage());
            return "redirect:/reservation/" + reservation.getId();
        }

        Ticket ticket = ticketService.createTicket(checkoutDto, user, reservation);
        model.addAttribute("ticket", ticket);
        try {
            mailSenderService.sendTicket(ticket);
        } catch (Exception ex){
            log.info("Error: {}", ex.getMessage());
            return "redirect:/reservation/" + reservation.getId();
        }

        return "main/cinema/ticket";
    }


    @PostMapping("/reservation/{id}/cancel")
    public ResponseEntity<?> cancelReservation(@PathVariable Long id){
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

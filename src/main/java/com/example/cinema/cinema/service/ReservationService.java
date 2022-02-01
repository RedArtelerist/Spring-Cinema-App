package com.example.cinema.cinema.service;

import com.example.cinema.account.model.User;
import com.example.cinema.cinema.model.*;
import com.example.cinema.cinema.repository.ReservationRepository;
import com.example.cinema.cinema.repository.SeatReservedRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;
import java.util.Optional;

@Service
public class ReservationService {
    @Autowired
    private ReservationRepository reservationRepository;

    @Autowired
    private SeatReservedRepository seatReservedRepository;

    public List<Reservation> findBySeance(Seance seance){
        return reservationRepository.findBySeance(seance, Sort.by(Sort.Direction.ASC, "created"));
    }

    public Reservation findById(Long reservationId){
        Optional<Reservation> reservationOptional = reservationRepository.findById(reservationId);
        return reservationOptional.orElse(null);
    }

    public List<Reservation> findExpiredReservations(){
        Date now = new Date();
        return reservationRepository.findExpiredReservations(now);
    }

    public List<Reservation> findByUser(User user){
        return reservationRepository.findByUser(user);
    }

    public List<Reservation> findBySession(String session){
        return reservationRepository.findBySession(session);
    }

    public Long createReservation(Seance seance, List<Seat> seats, User user, String session) throws Exception {
        if(!checkIfReserved(seance, seats))
            throw new Exception("Seats already reserved");

        Reservation reservation = new Reservation();
        reservation.setSeance(seance);

        long curTimeInMs = System.currentTimeMillis();
        Date created = new Date(curTimeInMs);
        Date expired = new Date(curTimeInMs + (7 * 60000));

        reservation.setCreated(created);
        reservation.setExpired(expired);

        if(user != null)
            reservation.setUser(user);
        if(session != null)
            reservation.setSession(session);

        for(Seat seat : seats){
            SeatReserved seatReserved = new SeatReserved();
            seatReserved.setSeat(seat);

            Integer price = seance.getPrice();

            if(seat.getType() == Type.Vip)
                price = (int) (price * 1.5);

            if(seat.getType() == Type.Premium)
                price *= 2;

            seatReserved.setPrice(price);
            seatReserved.setReservation(reservation);
            reservation.getSeats().add(seatReserved);
        }

        return reservationRepository.save(reservation).getId();
    }

    public void removeReservation(Reservation reservation) {
        reservationRepository.delete(reservation);
    }

    private boolean checkIfReserved(Seance seance, List<Seat> seats){
        for(Seat seat : seats){
            List<SeatReserved> seatReserves = seatReservedRepository.findBySeanceAndSeat(seance, seat);
            if(seatReserves.size() > 0)
                return false;
        }
        return true;
    }
}

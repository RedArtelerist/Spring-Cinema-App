package com.example.cinema.cinema.model;

import com.example.cinema.admin.model.Movie;
import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import org.hibernate.validator.constraints.Range;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Entity
public class Seance {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "hall_id")
    @JsonBackReference
    private Hall hall;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "movie_id")
    @JsonBackReference
    private Movie movie;

    @NotNull(message = "Seance date must not be empty")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @Temporal(TemporalType.DATE)
    private Date date;

    @NotNull(message = "Seance start time must not be empty")
    @DateTimeFormat(pattern = "HH:mm")
    @Temporal(TemporalType.TIME)
    private Date startTime;

    @NotNull(message = "Seance end time must not be empty")
    @DateTimeFormat(pattern = "HH:mm")
    @Temporal(TemporalType.TIME)
    private Date endTime;

    @NotNull(message = "Seance price must not be empty")
    @Range(min = 50, max = 10000, message = "Seance price must between 50 and 10000")
    private Integer price;

    @ElementCollection(targetClass = Technology.class, fetch = FetchType.EAGER)
    @CollectionTable(name = "seance_technologies", joinColumns = @JoinColumn(name = "seance_id"))
    @Enumerated(EnumType.STRING)
    private List<Technology> technologies = new ArrayList<>();

    private boolean available;

    @OneToMany(mappedBy = "seance", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    @JsonManagedReference
    private List<Reservation> reservations = new ArrayList<>();

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Hall getHall() {
        return hall;
    }

    public void setHall(Hall hall) {
        this.hall = hall;
    }

    public Movie getMovie() {
        return movie;
    }

    public void setMovie(Movie movie) {
        this.movie = movie;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public Date getStartTime() {
        return startTime;
    }

    public void setStartTime(Date startTime) {
        this.startTime = startTime;
    }

    public Date getEndTime() {
        return endTime;
    }

    public void setEndTime(Date endTime) {
        this.endTime = endTime;
    }

    public Integer getPrice() {
        return price;
    }

    public void setPrice(Integer price) {
        this.price = price;
    }

    public List<Technology> getTechnologies() {
        return technologies;
    }

    public void setTechnologies(List<Technology> technologies) {
        this.technologies = technologies;
    }

    public boolean isAvailable() {
        return available;
    }

    public void setAvailable(boolean available) {
        this.available = available;
    }

    public List<Reservation> getReservations() {
        return reservations;
    }

    public void setReservations(List<Reservation> reservations) {
        this.reservations = reservations;
    }

    public boolean seatReserved(Seat seat){
        for(Reservation reservation : reservations){
            for(SeatReserved seatReserved : reservation.getSeats())
                if(seatReserved.getSeat().equals(seat))
                    return true;
        }
        return false;
    }

    public int countAvailableSeats(){
        int count = 0;
        for(var reservation : reservations)
            count += reservation.getSeats().size();
        return hall.getNumSeats() - count;
    }
}

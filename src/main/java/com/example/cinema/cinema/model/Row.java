package com.example.cinema.cinema.model;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import org.hibernate.validator.constraints.Range;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import java.util.ArrayList;
import java.util.List;

@Entity
public class Row {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Pattern(regexp="^[A-Z]{1,2}", message="Row name must be 1 or 2 upper case letters")
    private String name;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "hall_id")
    @JsonBackReference
    private Hall hall;

    @Enumerated(EnumType.STRING)
    private Type type;

    @Column(name = "num_seats", nullable = false)
    @NotNull(message = "NumSeats must not be empty")
    @Range(min = 5, max = 20, message = "NumSeats must between 5 and 20")
    private Integer numSeats;

    @OneToMany(mappedBy = "row", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    @JsonManagedReference
    private List<Seat> seats = new ArrayList<>();

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Hall getHall() {
        return hall;
    }

    public void setHall(Hall hall) {
        this.hall = hall;
    }

    public Type getType() {
        return type;
    }

    public void setType(Type type) {
        this.type = type;
    }

    public Integer getNumSeats() {
        return numSeats;
    }

    public void setNumSeats(Integer numSeats) {
        this.numSeats = numSeats;
    }

    public List<Seat> getSeats() {
        return seats;
    }

    public void setSeats(List<Seat> seats) {
        this.seats = seats;
    }
}

package com.example.cinema.cinema.model;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import org.hibernate.validator.constraints.Range;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;

@Entity
public class Hall {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Pattern(regexp="^[a-zA-Z0-9\\s\\-№#]{1,20}", message="Title must contain only letters and nums and must be between 1 and 20 characters")
    private String name;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "cinema_id")
    @JsonBackReference
    private Cinema cinema;

    @Column(name = "num_seats", nullable = false)
    @NotNull(message = "NumSeats must not be empty")
    @Range(min = 50, max = 500, message = "NumSeats must between 50 and 500")
    private Integer numSeats;

    private boolean active;

    @OneToMany(mappedBy = "hall", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    @JsonManagedReference
    private List<Row> rows = new LinkedList<>();

    @OneToMany(mappedBy = "hall", fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    @JsonManagedReference
    private List<Seance> seances = new ArrayList<>();

    @OneToMany(mappedBy = "hall", fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    @JsonIgnore
    private List<Ticket> tickets = new ArrayList<>();

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
        this.name = name.trim();
    }

    public Cinema getCinema() {
        return cinema;
    }

    public void setCinema(Cinema cinema) {
        this.cinema = cinema;
    }

    public Integer getNumSeats() {
        return numSeats;
    }

    public void setNumSeats(Integer numSeats) {
        this.numSeats = numSeats;
    }

    public boolean isActive() {
        return active;
    }

    public void setActive(boolean active) {
        this.active = active;
    }

    public List<Row> getRows() {
        return rows;
    }

    public void setRows(List<Row> rows) {
        this.rows = rows;
    }

    public List<Seance> getSeances() {
        return seances;
    }

    public void setSeances(List<Seance> seances) {
        this.seances = seances;
    }

    public List<Ticket> getTickets() {
        return tickets;
    }

    public void setTickets(List<Ticket> tickets) {
        this.tickets = tickets;
    }

    public Integer countSeats(){
        Integer count = 0;
        for(Row row : rows)
            count += row.getSeats().size();

        return count;
    }
}

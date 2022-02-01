package com.example.cinema.cinema.model;

import com.fasterxml.jackson.annotation.JsonBackReference;
import org.hibernate.validator.constraints.Range;

import javax.persistence.*;
import javax.validation.constraints.NotNull;

@Entity
public class Seat {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotNull(message = "Number must not be empty")
    @Range(min = 1, max = 20, message = "NumSeats must between 1 and 20")
    private Integer number;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "row_id")
    @JsonBackReference
    private Row row;

    @Enumerated(EnumType.STRING)
    private Type type;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Integer getNumber() {
        return number;
    }

    public void setNumber(Integer number) {
        this.number = number;
    }

    public Row getRow() {
        return row;
    }

    public void setRow(Row row) {
        this.row = row;
    }

    public Type getType() {
        return type;
    }

    public void setType(Type type) {
        this.type = type;
    }
}

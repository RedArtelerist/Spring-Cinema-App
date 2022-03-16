package com.example.cinema.telegrambot.dto;

import com.example.cinema.admin.dto.AdminMovieDto;
import com.example.cinema.admin.model.Movie;
import com.example.cinema.cinema.model.Cinema;
import com.example.cinema.cinema.model.City;
import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Getter
@Setter
public class SearchDto {
    private City city;
    private Cinema cinema;
    private AdminMovieDto movie;
    private Date date;

    public SearchDto() {}
}

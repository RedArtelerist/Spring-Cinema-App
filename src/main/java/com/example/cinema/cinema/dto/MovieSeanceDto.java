package com.example.cinema.cinema.dto;

import com.example.cinema.cinema.model.Seance;
import com.example.cinema.main.dto.MovieDto;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class MovieSeanceDto {
    private MovieDto movie;
    private List<Seance> seances;

    public MovieSeanceDto(){}

    public MovieSeanceDto(MovieDto movie, List<Seance> seances){
        this.movie = movie;
        this.seances = seances;
    }
}

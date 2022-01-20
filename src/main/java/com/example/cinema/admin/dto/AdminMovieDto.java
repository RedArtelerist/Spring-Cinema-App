package com.example.cinema.admin.dto;

import com.example.cinema.admin.model.*;
import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Getter
@Setter
public class AdminMovieDto {
    private Long id;
    private String title;
    private Integer year;
    private Date release;
    private String posterUrl;
    private boolean status;
    private Category category;
    private Double rating;
    private Integer numVotes;
    private Integer numComments;

    public AdminMovieDto(Movie movie, Double rating){
        this.id = movie.getId();
        this.title = movie.getTitle();
        this.year = movie.getYear();
        this.release = movie.getRelease();
        this.posterUrl = movie.getPosterUrl();
        this.status = movie.isStatus();
        this.category = movie.getCategory();
        this.rating = rating;
        this.numVotes = movie.getRatings().size();
        this.numComments = movie.getComments().size();
    }
}

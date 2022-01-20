package com.example.cinema.main.dto;

import com.example.cinema.admin.model.*;
import lombok.Getter;
import lombok.Setter;

import java.util.Date;
import java.util.List;
import java.util.Set;

@Getter
@Setter
public class MovieDto {
    private Long id;
    private String title;
    private Set<Country> countries;
    private String description;
    private Integer year;
    private Integer budget;
    private Integer boxOffice;
    private Date release;
    private String time;
    private String posterUrl;
    private String trailer;
    private boolean status;
    private MPAA mpaa;
    private Category category;
    private Set<Genre> genres;
    private List<Company> companies;
    private List<Star> directors;
    private List<Star> cast;
    private List<ImageMovie> gallery;
    private Double rating;
    private Integer numVotes;
    private Integer numComments;
    private Integer numFavourites;
    private Integer numWatchLists;

    private Integer myRate;
    private boolean inWatchlist;

    public MovieDto(Movie movie, Double rating, Long myRate, boolean inWatchlist){
        this.id = movie.getId();
        this.title = movie.getTitle();
        this.countries = movie.getCountries();
        this.description = movie.getDescription();
        this.year = movie.getYear();
        this.budget = movie.getBudget();
        this.boxOffice = movie.getBoxOffice();
        this.release = movie.getRelease();
        this.time = movie.getTime();
        this.posterUrl = movie.getPosterUrl();
        this.trailer = movie.getTrailer();
        this.status = movie.isStatus();
        this.mpaa = movie.getMpaa();
        this.category = movie.getCategory();
        this.genres = movie.getGenres();
        this.companies = movie.getCompanies();
        this.directors = movie.getDirectors();
        this.cast = movie.getCast();
        this.gallery = movie.getGallery();
        this.rating = rating;
        this.numVotes = movie.getRatings().size();
        this.numComments = movie.getComments().size();
        this.numFavourites = movie.getFavourites().size();
        this.numWatchLists = movie.getWatchList().size();

        if(numWatchLists != 0)
            this.myRate = Math.toIntExact(myRate) / numWatchLists;
        else
            this.myRate = Math.toIntExact(myRate);

        this.inWatchlist = inWatchlist;
    }
}

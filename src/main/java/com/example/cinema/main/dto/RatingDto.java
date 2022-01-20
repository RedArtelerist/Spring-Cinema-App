package com.example.cinema.main.dto;

import com.example.cinema.main.model.Rating;
import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Getter
@Setter
public class RatingDto {
    private Long id;
    private Integer value;
    private MovieDto item;
    private Date createdAt;
    private Date updatedAt;

    public RatingDto(){}

    public RatingDto(Rating rate, Double rating, Long myRate, boolean inWatchlist){
        this.id = rate.getId();
        this.value = rate.getValue();
        this.item = new MovieDto(rate.getMovie(), rating, myRate, inWatchlist);
        this.createdAt = rate.getCreatedAt();
        this.updatedAt = rate.getUpdatedAt();
    }
}

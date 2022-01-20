package com.example.cinema.main.dto;

import com.example.cinema.main.model.Favourite;
import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Getter
@Setter
public class FavouriteDto {
    private Long id;
    private Long hisRate;
    private MovieDto item;
    private Date createdAt;

    public FavouriteDto(){}

    public FavouriteDto(Favourite favourite, Double rating, Long hisRate, Long myRate, boolean inWatchlist){
        this.id = favourite.getId();
        this.hisRate = hisRate;
        this.createdAt = favourite.getCreatedAt();
        this.item = new MovieDto(favourite.getMovie(), rating, myRate, inWatchlist);
        if(item.getNumWatchLists() != 0)
            this.hisRate = hisRate / item.getNumWatchLists();
        else
            this.hisRate = hisRate;
    }
}

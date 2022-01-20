package com.example.cinema.main.dto;

import com.example.cinema.main.model.WatchList;
import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Getter
@Setter
public class WatchListDto {
    private Long id;
    private Long hisRate;
    private MovieDto item;
    private Date createdAt;

    public WatchListDto(){}

    public WatchListDto(WatchList watchList, Double rating, Long hisRate, Long myRate, boolean inWatchlist){
        this.id = watchList.getId();
        this.hisRate = hisRate;
        this.createdAt = watchList.getCreatedAt();
        this.item = new MovieDto(watchList.getMovie(), rating, myRate, inWatchlist);
        if(item.getNumWatchLists() != 0)
            this.hisRate = hisRate / item.getNumWatchLists();
        else
            this.hisRate = hisRate;
    }
}

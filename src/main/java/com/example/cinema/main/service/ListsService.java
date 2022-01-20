package com.example.cinema.main.service;

import com.example.cinema.account.model.User;
import com.example.cinema.admin.model.Movie;
import com.example.cinema.main.dto.FavouriteDto;
import com.example.cinema.main.dto.WatchListDto;
import com.example.cinema.main.model.Favourite;
import com.example.cinema.main.model.WatchList;
import com.example.cinema.main.repository.FavouriteRepository;
import com.example.cinema.main.repository.WatchListRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import javax.persistence.EntityManager;
import java.util.Date;
import java.util.List;

@Service
public class ListsService {
    @Autowired
    private WatchListRepository watchListRepository;

    @Autowired
    private FavouriteRepository favouriteRepository;

    public WatchList getWatchList(User user, Long itemId){
        return watchListRepository.findByUserAndMovie(user, itemId);
    }

    public Favourite getFavourite(User user, Long itemId){
        return favouriteRepository.findByUserAndMovie(user, itemId);
    }

    public Page<WatchListDto> getUserWatchList(User owner, User user, int pageNum){
        Pageable pageable = PageRequest.of(pageNum - 1, 30);
        var watchlist = watchListRepository.findByUser(owner, user);

        final int start = (int)pageable.getOffset();
        final int end = Math.min((start + pageable.getPageSize()), watchlist.size());

        return new PageImpl<>(watchlist.subList(start, end), pageable, watchlist.size());
    }

    public Page<FavouriteDto> getUserFavourites(User owner, User user, int pageNum){
        Pageable pageable = PageRequest.of(pageNum - 1, 30);
        var favourites = favouriteRepository.findByUser(owner, user);

        final int start = (int)pageable.getOffset();
        final int end = Math.min((start + pageable.getPageSize()), favourites.size());

        return new PageImpl<>(favourites.subList(start, end), pageable, favourites.size());
    }

    public Integer setWatchList(User user, Movie item){
        var watchList = getWatchList(user, item.getId());

        if(watchList == null){
            watchList = new WatchList();
            watchList.setMovie(item);
            watchList.setUser(user);
            watchList.setCreatedAt(new Date());
            watchListRepository.save(watchList);
            return 1;
        }
        else {
            deleteWatchList(watchList);
            return 0;
        }
    }

    public void deleteWatchList(WatchList watchList){
        watchListRepository.delete(watchList);
    }

    public Integer setFavourite(User user, Movie item){
        var favourite = getFavourite(user, item.getId());

        if(favourite == null){
            favourite = new Favourite();
            favourite.setMovie(item);
            favourite.setUser(user);
            favourite.setCreatedAt(new Date());
            favouriteRepository.save(favourite);
            return 1;
        }
        else {
            deleteFavourite(favourite);
            return 0;
        }
    }

    public void deleteFavourite(Favourite favourite){
        favouriteRepository.delete(favourite);
    }
}

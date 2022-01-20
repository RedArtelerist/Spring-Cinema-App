package com.example.cinema.main.controller;

import com.example.cinema.account.model.User;
import com.example.cinema.admin.model.Movie;
import com.example.cinema.admin.service.MovieService;
import com.example.cinema.main.service.ListsService;
import com.example.cinema.main.service.RatingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

import java.util.Date;
import java.util.Map;

@Controller
public class RatingController {
    @Autowired
    private MovieService movieService;

    @Autowired
    private RatingService ratingService;

    @Autowired
    private ListsService listsService;

    @PreAuthorize("isAuthenticated()")
    @PostMapping("/rate")
    public ResponseEntity<?> rate(@AuthenticationPrincipal User user, @RequestBody Map<String, Long> body){
        try {
            Long movieId = body.get("item");
            Integer value = body.get("value").intValue();
            Movie item = movieService.getById(movieId);

            if(item == null)
                return new ResponseEntity<Object>(new Error("Can't find item"), HttpStatus.BAD_REQUEST);

            if(item.getRelease().after(new Date()))
                return new ResponseEntity<Object>(new Error("Item has not yet been released"), HttpStatus.BAD_REQUEST);

            ratingService.setRating(user, item, value);
            return new ResponseEntity<Object>("Rating was successfully saved", HttpStatus.OK);
        }
        catch (Exception ex){
            System.out.print(ex.getMessage());
            return new ResponseEntity<Object>(new Error(ex.getMessage()), HttpStatus.BAD_REQUEST);
        }
    }

    @PreAuthorize("isAuthenticated()")
    @PostMapping("/rate/delete")
    public ResponseEntity<?> deleteRate(@AuthenticationPrincipal User user, @RequestBody Long id){
        try {
            Movie item = movieService.getById(id);

            if(item == null)
                return new ResponseEntity<Object>(new Error("Can't find item"), HttpStatus.BAD_REQUEST);

            var rating = ratingService.getRating(user, id);
            ratingService.delete(rating);

            return new ResponseEntity<Object>("Rating was successfully deleted", HttpStatus.OK);
        }
        catch (Exception ex){
            System.out.print(ex.getMessage());
            return new ResponseEntity<Object>(new Error(ex.getMessage()), HttpStatus.BAD_REQUEST);
        }
    }

    @PreAuthorize("isAuthenticated()")
    @PostMapping("/watchlist")
    public ResponseEntity<?> watchList(@AuthenticationPrincipal User user, @RequestBody Long id){
        try {
            Movie item = movieService.getById(id);

            if(item == null)
                return new ResponseEntity<Object>(new Error("Can't find item"), HttpStatus.BAD_REQUEST);

            Integer type = listsService.setWatchList(user, item);
            return new ResponseEntity<Object>(type, HttpStatus.OK);
        }
        catch (Exception ex){
            System.out.print(ex.getMessage());
            return new ResponseEntity<Object>(new Error(ex.getMessage()), HttpStatus.BAD_REQUEST);
        }
    }

    @PreAuthorize("isAuthenticated()")
    @PostMapping("/favourite")
    public ResponseEntity<?> favourite(@AuthenticationPrincipal User user, @RequestBody Long id){
        try {
            Movie item = movieService.getById(id);

            if(item == null)
                return new ResponseEntity<Object>(new Error("Can't find item"), HttpStatus.BAD_REQUEST);

            if(item.getRelease().after(new Date()))
                return new ResponseEntity<Object>(new Error("Item has not yet been released"), HttpStatus.BAD_REQUEST);

            Integer type = listsService.setFavourite(user, item);
            return new ResponseEntity<Object>(type, HttpStatus.OK);
        }
        catch (Exception ex){
            System.out.print(ex.getMessage());
            return new ResponseEntity<Object>(new Error(ex.getMessage()), HttpStatus.BAD_REQUEST);
        }
    }
}

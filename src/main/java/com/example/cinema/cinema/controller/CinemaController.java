package com.example.cinema.cinema.controller;

import com.example.cinema.account.model.User;
import com.example.cinema.cinema.dto.MovieSeanceDto;
import com.example.cinema.cinema.model.Cinema;
import com.example.cinema.cinema.model.City;
import com.example.cinema.cinema.service.CinemaService;
import com.example.cinema.cinema.service.SeanceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Controller
public class CinemaController {
    @Autowired
    private CinemaService cinemaService;

    @Autowired
    private SeanceService seanceService;

    @GetMapping("/cinemas")
    public String cinemaList(
            @RequestParam(required = false, defaultValue = "") String sort, Model model,
            @RequestParam(required = false, defaultValue = "all") String city,
            @RequestParam(required = false, defaultValue = "") String search
    ){
        model.addAttribute("cities", City.values());
        model.addAttribute("cinemas", cinemaService.getCinemas(sort, search.toLowerCase(), city));
        model.addAttribute("sort", sort);
        model.addAttribute("city", city);

        return "main/cinema/list";
    }

    @GetMapping("/cinema/{id}")
    public String cinemaList(@AuthenticationPrincipal User user, @PathVariable("id") Long id,
                             @RequestParam(required = false, defaultValue = "") String date, Model model){
        Cinema cinema = cinemaService.getById(id);

        if(cinema == null)
            throw new RuntimeException("Cinema not found");

        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        Date d;
        try {
            d = formatter.parse(date);
        }
        catch (Exception ex){
            d = null;
        }

        var dates = seanceService.getCinemaSeancesDates(cinema);
        List<MovieSeanceDto> movie_seances = new ArrayList<>();

        if(dates.size() > 0) {
            if (d != null && dates.contains(d)) {
                movie_seances = seanceService.findSeancesByCinemaAndDate(cinema, d, user);
                model.addAttribute("date", d);
            } else
                movie_seances = seanceService.findSeancesByCinemaAndDate(cinema, dates.get(0), user);
        }

        model.addAttribute("cinema", cinema);
        model.addAttribute("dates", dates);
        model.addAttribute("movie_seances", movie_seances);

        return "main/cinema/detail";
    }
}

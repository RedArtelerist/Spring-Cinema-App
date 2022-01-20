package com.example.cinema.cinema.controller;

import com.example.cinema.cinema.model.Cinema;
import com.example.cinema.cinema.model.City;
import com.example.cinema.cinema.service.CinemaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class CinemaController {
    @Autowired
    private CinemaService cinemaService;

    @GetMapping("/cinemas")
    public String cinemaList(@RequestParam(required = false, defaultValue = "") String sort,
                             @RequestParam(required = false, defaultValue = "Kiev") String city, Model model){
        model.addAttribute("cities", City.values());
        model.addAttribute("cinemas", cinemaService.getCinemas(sort, city));
        model.addAttribute("sort", sort);
        model.addAttribute("city", city);

        return "main/cinema/list";
    }

    @GetMapping("/cinema/{id}")
    public String cinemaList(@PathVariable("id") Long id, Model model){
        Cinema cinema = cinemaService.getById(id);

        if(cinema == null)
            throw new RuntimeException("Cinema not found");

        model.addAttribute("cinema", cinema);

        return "main/cinema/detail";
    }
}

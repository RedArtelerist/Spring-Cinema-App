package com.example.cinema.main.controller;

import com.example.cinema.account.model.User;
import com.example.cinema.admin.model.Genre;
import com.example.cinema.admin.service.MovieService;
import com.example.cinema.cinema.model.City;
import com.example.cinema.cinema.service.CinemaService;
import com.example.cinema.cinema.service.SeanceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.stream.Collectors;

@Controller
public class MainController {
    @Autowired
    private MovieService movieService;

    @Autowired
    private SeanceService seanceService;

    @Autowired
    private CinemaService cinemaService;

    @GetMapping("/")
    public String home(@AuthenticationPrincipal User user, Model model){
        var cinemas = cinemaService.cinemaList().stream().limit(5).collect(Collectors.toList());

        model.addAttribute("cities", City.values());
        model.addAttribute("genres", Genre.values());
        model.addAttribute("cinemas", cinemas);
        model.addAttribute("top", seanceService.findTopMovies(user));
        model.addAttribute("movies", seanceService.findMovies(user));

        return "main/home";
    }

    @GetMapping("/search")
    public String search(
            @RequestParam(required = false, defaultValue = "") String search,
            @RequestParam(required = false, defaultValue = "title") String type, RedirectAttributes redirect
    ){
        switch (type) {
            case "location" -> {
                redirect.addAttribute("city", search);
                return "redirect:/cinemas";
            }
            case "cinema" -> {
                redirect.addAttribute("search", search);
                return "redirect:/cinemas";
            }
            case "film-category" -> {
                redirect.addAttribute("genre", search);
                return "redirect:/navigator";
            }
            case "actors" -> {
                redirect.addAttribute("search", search);
                return "redirect:/stars";
            }
            case "country" -> {
                redirect.addAttribute("country", search);
                return "redirect:/navigator";
            }
            default -> {
                redirect.addAttribute("search", search);
                return "redirect:/navigator";
            }
        }
    }
}

package com.example.cinema.main.controller;

import com.example.cinema.account.model.User;
import com.example.cinema.admin.model.Star;
import com.example.cinema.admin.service.StarService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

@Controller
public class StarController {
    @Autowired
    private StarService starService;

    @GetMapping("/star/{id}")
    public String detail(@AuthenticationPrincipal User user, @PathVariable("id") Long id, Model model){
        Star star = starService.findById(id);

        if(star == null)
            throw new RuntimeException("Star not found");

        model.addAttribute("star", star);
        model.addAttribute("movies_actor", starService.getMoviesByActor(star, user));
        model.addAttribute("movies_director", starService.getMoviesByDirector(star, user));
        model.addAttribute("best_movies", starService.getBestMovies(star));

        return "main/star/detail";
    }
}

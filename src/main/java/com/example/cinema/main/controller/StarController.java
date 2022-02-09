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
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class StarController {
    @Autowired
    private StarService starService;

    @GetMapping("/stars")
    public String list(
            @RequestParam(required = false, defaultValue = "1") int page,
            @RequestParam(required = false, defaultValue = "") String sort,
            @RequestParam(required = false, defaultValue = "") String search, Model model
    ){
        if(page < 1)
            return "redirect:/stars";

        var stars = starService.starList(sort, search, page);

        if(page > stars.getTotalPages())
            return "redirect:/stars";

        model.addAttribute("page", stars);
        model.addAttribute("url", "/stars");
        model.addAttribute("sort", sort);
        model.addAttribute("search", search);

        return "main/star/list";
    }

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

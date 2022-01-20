package com.example.cinema.main.controller;

import com.example.cinema.admin.service.MovieService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MainController {
    @Autowired
    private MovieService movieService;


    @GetMapping("/")
    public String home(Model model){
        return "main/home";
    }
}

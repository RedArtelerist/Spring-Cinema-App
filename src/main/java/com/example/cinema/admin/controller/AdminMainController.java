package com.example.cinema.admin.controller;

import com.example.cinema.account.service.UserService;
import com.example.cinema.admin.service.MovieService;
import com.example.cinema.main.service.CommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.stream.Collectors;

@RequestMapping("/admin")
@Controller
public class AdminMainController {
    @Autowired
    private UserService userService;

    @Autowired
    private MovieService movieService;

    @Autowired
    private CommentService commentService;

    @GetMapping()
    public String dashboard(Model model){
        var users = userService.findAll("created-desc", null, 0);
        var latestUsers = users.getContent().stream().limit(5).collect(Collectors.toList());

        var items = movieService.findItemsForAdmin("rating", "", 0);
        var topItems = items.getContent().stream().limit(5).collect(Collectors.toList());

        items = movieService.findItemsForAdmin("created", "", 0);
        var latestItems = items.getContent().stream().limit(5).collect(Collectors.toList());

        var comments = commentService.findAll("", "", 0);
        var latestComments = comments.getContent().stream().limit(5).collect(Collectors.toList());


        model.addAttribute("title", "dashboard");
        model.addAttribute("latestUsers", latestUsers);
        model.addAttribute("topItems", topItems);
        model.addAttribute("latestItems", latestItems);
        model.addAttribute("comments", latestComments);
        model.addAttribute("usersCount", userService.userList().size());
        model.addAttribute("itemsCount", movieService.movieList().size());
        model.addAttribute("commentsCount", commentService.commentList().size());

        return "admin/dashboard";
    }
}

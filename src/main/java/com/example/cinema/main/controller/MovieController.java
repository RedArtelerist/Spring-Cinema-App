package com.example.cinema.main.controller;

import com.example.cinema.account.model.User;
import com.example.cinema.admin.model.Category;
import com.example.cinema.admin.model.Country;
import com.example.cinema.admin.model.Genre;
import com.example.cinema.admin.model.Movie;
import com.example.cinema.admin.service.CompanyService;
import com.example.cinema.admin.service.MovieService;
import com.example.cinema.main.dto.MovieDto;
import com.example.cinema.main.model.Comment;
import com.example.cinema.main.model.Favourite;
import com.example.cinema.main.service.CommentService;
import com.example.cinema.main.service.ListsService;
import com.example.cinema.main.service.RatingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Controller
public class MovieController {
    @Autowired
    private MovieService movieService;

    @Autowired
    private ListsService listsService;

    @Autowired
    private CommentService commentService;

    @GetMapping("/item/{id}")
    public String detail(@AuthenticationPrincipal User user, @PathVariable Long id, Model model){
        MovieDto item = movieService.getById(id, user);

        if(item == null)
            throw new RuntimeException("Item not found");

        if(user != null){
            Favourite favourite = listsService.getFavourite(user, id);

            if(favourite != null)
                model.addAttribute("favourite", true);
            else
                model.addAttribute("favourite", false);
        }

        model.addAttribute("item", item);
        model.addAttribute("comments", commentService.movieComments(id));
        return "main/movie/detail";
    }

    @GetMapping("/navigator")
    public String list(@AuthenticationPrincipal User user, Model model,
                       @RequestParam(required = false, defaultValue = "1") int page,
                       @RequestParam(required = false, defaultValue = "") String sort,
                       @RequestParam(required = false, defaultValue = "") String category,
                       @RequestParam(required = false, defaultValue = "0") String company,
                       @RequestParam(required = false, defaultValue = "") String genre,
                       @RequestParam(required = false, defaultValue = "") String country,
                       @RequestParam(required = false, defaultValue = "") String from_year,
                       @RequestParam(required = false, defaultValue = "") String to_year){
        if(page < 1)
            return "redirect:/navigator";

        var years = movieService.getMinMaxMovieYear();

        model.addAttribute("categories",  Category.values());
        model.addAttribute("companies", movieService.getMostPopularCompanies());
        model.addAttribute("genres",  Genre.values());
        model.addAttribute("countries", movieService.getCountries());
        model.addAttribute("min_year", years.get(0));
        model.addAttribute("max_year", years.get(1));

        var params = processFilterParams(
                sort, category, company, genre,
                country, from_year, to_year, years
        );

        try {
            var items = movieService.findItems(user, page, params);
            model.addAttribute("page", items);
            model.addAttribute("url", "/navigator");
            model.addAttribute("sort", sort);
            model.addAttribute("category", category);
            model.addAttribute("company", (long) params.get("company"));
            model.addAttribute("genre", genre);
            model.addAttribute("country", country);
            model.addAttribute("from_year", (Integer) params.get("from_year"));
            model.addAttribute("to_year", (Integer) params.get("to_year"));

            return "main/movie/list";
        }
        catch (Exception ex){
            return "redirect:/navigator";
        }
    }

    @PreAuthorize("isAuthenticated()")
    @PostMapping("/comment/create")
    public String addComment(@AuthenticationPrincipal User user, @Valid Comment comment, BindingResult bindingResult){
        comment.setUser(user);
        if(bindingResult.hasErrors())
            return "redirect:/item/" + comment.getMovie().getId();

        commentService.addComment(comment);
        return "redirect:/item/" + comment.getMovie().getId();
    }

    @PreAuthorize("isAuthenticated()")
    @PostMapping("item/{movieId}/comment/{commentId}/delete")
    public String deleteComment(@AuthenticationPrincipal User user, @PathVariable Long movieId,
                             @PathVariable Long commentId, Model model){
        Movie item = movieService.getById(movieId);

        if(item == null)
            throw new RuntimeException("Movie not found");

        Comment comment = commentService.getById(commentId);

        if (comment != null) {
            if (comment.getUser().getId().equals(user.getId())) {
                commentService.deleteComment(comment);
            }
        }

        return "redirect:/item/" + item.getId();
    }

    private Map<String, Object> processFilterParams(String sort, String category, String company,
                                                    String genre, String country, String from_year,
                                                    String to_year, List<Integer> years){
        Integer from, to;
        try {
            from = Integer.parseInt(from_year);
            to = Integer.parseInt(to_year);

            if(from > to){
                var temp = from;
                from = to;
                to = temp;
            }
            if(from < years.get(0))
                from = years.get(0);
            if(to > years.get(1))
                to = years.get(1);
        }
        catch (Exception ex){
            from = years.get(0);
            to = years.get(1);
        }

        long companyId;
        try {
            companyId = Long.parseLong(company);
        }
        catch (Exception ex){
            companyId = 0L;
        }

        var params = new HashMap<String, Object>();
        params.put("sort", sort);
        params.put("category", category);
        params.put("company", companyId);
        params.put("genre", genre);
        params.put("country", country);
        params.put("from_year", from);
        params.put("to_year", to);

        return params;
    }
}

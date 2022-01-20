package com.example.cinema.account.controller;

import com.example.cinema.account.model.User;
import com.example.cinema.account.service.UserService;
import com.example.cinema.admin.model.Category;
import com.example.cinema.admin.model.Genre;
import com.example.cinema.main.service.CommentService;
import com.example.cinema.main.service.ListsService;
import com.example.cinema.main.service.RatingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Controller
public class UserController {
    @Autowired
    private UserService userService;

    @Autowired
    private RatingService ratingService;

    @Autowired
    private ListsService listsService;

    @Autowired
    private CommentService commentService;

    @GetMapping("/user/{id}")
    public String userProfile(@AuthenticationPrincipal User currentUser, @PathVariable("id") Long userId, Model model){
        User user = userService.getUserById(userId);

        if(user == null)
            throw new RuntimeException("User not found");

        model.addAttribute("isSubscriber", user.getSubscribers().contains(currentUser));
        model.addAttribute("owner", user);

        return "main/user/detail";
    }

    @GetMapping("/user/{id}/scores")
    public String userScores(@AuthenticationPrincipal User user, @PathVariable("id") Long userId, Model model,
                            @RequestParam(required = false, defaultValue = "1") int page,
                            @RequestParam(required = false, defaultValue = "") String sort,
                            @RequestParam(required = false, defaultValue = "") String category,
                            @RequestParam(required = false, defaultValue = "") String genre,
                            @RequestParam(required = false, defaultValue = "") String from_year,
                            @RequestParam(required = false, defaultValue = "") String to_year){
        User owner = userService.getUserById(userId);

        if(owner == null)
            throw new RuntimeException("User not found");

        var years = ratingService.getMinMaxYear(owner);

        var params = processFilterParams(
                sort, category, genre,
                from_year, to_year, years
        );

        model.addAttribute("categories", Category.values());
        model.addAttribute("genres" , Genre.values());
        model.addAttribute("min_year", years.get(0));
        model.addAttribute("max_year", years.get(1));

        try {
            var votes = ratingService.getUserRatings(owner, user, page, params);
            model.addAttribute("userId", owner.getId());
            model.addAttribute("username", owner.getUsername());
            model.addAttribute("url", "/user/" + userId + "/scores");
            model.addAttribute("page", votes);
            model.addAttribute("sort", sort);
            model.addAttribute("category", category);
            model.addAttribute("genre", genre);
            model.addAttribute("from_year", (Integer) params.get("from_year"));
            model.addAttribute("to_year", (Integer) params.get("to_year"));

            return "main/user/scores";
        }
        catch (Exception ex){
            return "redirect:/user/" + userId + "/scores";
        }
    }

    @PreAuthorize("isAuthenticated()")
    @PostMapping("/score/{id}/delete")
    public String scoresDelete(@AuthenticationPrincipal User user, @PathVariable("id") Long id){
        var vote = ratingService.getById(id);

        if(vote == null)
            return "redirect:/user/" + user.getId() + "/scores";
        if(!vote.getUser().getId().equals(user.getId()))
            return "redirect:/user/" + user.getId() + "/scores";

        ratingService.delete(vote);

        return "redirect:/user/" + user.getId() + "/scores";
    }

    @GetMapping("/user/{id}/watchlist")
    public String userWatchList(@AuthenticationPrincipal User user, @PathVariable("id") Long userId, Model model,
                            @RequestParam(required = false, defaultValue = "1") int page){
        User owner = userService.getUserById(userId);

        if(owner == null)
            throw new RuntimeException("User not found");

        try {
            var watchlist = listsService.getUserWatchList(owner, user, page);
            model.addAttribute("userId", owner.getId());
            model.addAttribute("username", owner.getUsername());
            model.addAttribute("url", "/user/" + userId + "/watchlist");
            model.addAttribute("page", watchlist);

            return "main/user/watchlist";
        }
        catch (Exception ex) {
            return "redirect:/user/" + userId + "/watchlist";
        }
    }

    @GetMapping("/user/{id}/favourites")
    public String userFavourites(@AuthenticationPrincipal User user, @PathVariable("id") Long userId, Model model,
                                @RequestParam(required = false, defaultValue = "1") int page){
        User owner = userService.getUserById(userId);

        if(owner == null)
            throw new RuntimeException("User not found");

        try {
            var watchlist = listsService.getUserFavourites(owner, user, page);
            model.addAttribute("userId", owner.getId());
            model.addAttribute("username", owner.getUsername());
            model.addAttribute("url", "/user/" + userId + "/favourites");
            model.addAttribute("page", watchlist);

            return "main/user/favourites";
        }
        catch (Exception ex) {
            return "redirect:/user/" + userId + "/favourites";
        }
    }

    @GetMapping("/user/{id}/comments")
    public String userComments(@AuthenticationPrincipal User user, @PathVariable("id") Long userId, Model model,
                               @RequestParam(required = false, defaultValue = "1") int page,
                               @RequestParam(required = false, defaultValue = "") String sort){
        User owner = userService.getUserById(userId);

        if(owner == null)
            throw new RuntimeException("User not found");

        try {
            var comments = commentService.userComments(owner, sort, page);
            model.addAttribute("userId", owner.getId());
            model.addAttribute("username", owner.getUsername());
            model.addAttribute("url", "/user/" + userId + "/comments");
            model.addAttribute("page", comments);
            model.addAttribute("sort", sort);

            return "main/user/comments";
        }
        catch (Exception ex) {
            return "redirect:/user/" + userId + "/comments";
        }
    }

    @PreAuthorize("isAuthenticated()")
    @PostMapping("/comment/{id}/delete")
    public String userComments(@AuthenticationPrincipal User user, @PathVariable("id") Long id, Model model){
        var comment = commentService.getById(id);

        if(comment == null)
            return "redirect:/user/" + user.getId() + "/comments";

        if(!comment.getUser().getId().equals(user.getId()))
            return "redirect:/user/" + user.getId() + "/comments";

        commentService.deleteComment(comment);

        return "redirect:/user/" + user.getId() + "/comments";
    }

    @GetMapping("/user/{id}/{type}")
    public String userList(Model model, @PathVariable Long id, @PathVariable String type){
        User user = userService.getUserById(id);

        if(user == null)
            throw new RuntimeException("User not found");

        model.addAttribute("userChannel", user);
        model.addAttribute("type", type);

        if (type.equals("subscriptions")) {
            model.addAttribute("users",
                    user.getSubscriptions().stream().sorted(
                            Comparator.comparing(User::getUsername, String.CASE_INSENSITIVE_ORDER)
                    ).collect(Collectors.toList())
            );
            model.addAttribute("title", "subscriptions");
        } else if(type.equals("subscribers")) {
            model.addAttribute("users",
                    user.getSubscribers().stream().sorted(
                            Comparator.comparing(User::getUsername, String.CASE_INSENSITIVE_ORDER)
                    ).collect(Collectors.toList())
            );
            model.addAttribute("title", "subscribers");
        } else
            throw new RuntimeException("Not found");

        return "main/user/subscriptions";
    }

    private Map<String, Object> processFilterParams(
            String sort, String category, String genre,
            String from_year, String to_year, List<Integer> years) {
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

        var params = new HashMap<String, Object>();
        params.put("sort", sort);
        params.put("category", category);
        params.put("genre", genre);
        params.put("from_year", from);
        params.put("to_year", to);

        return params;
    }
}

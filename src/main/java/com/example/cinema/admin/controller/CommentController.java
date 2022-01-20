package com.example.cinema.admin.controller;

import com.example.cinema.account.model.User;
import com.example.cinema.main.model.Comment;
import com.example.cinema.main.service.CommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

import java.util.HashMap;
import java.util.Map;
import java.util.Set;

@Controller
public class CommentController {
    @Autowired
    private CommentService commentService;

    @GetMapping("/admin/comments")
    public String comments(Model model, @RequestParam(required = false, defaultValue = "") String search,
                           @RequestParam(required = false, defaultValue = "") String sort,
                           @RequestParam(required = false, defaultValue = "0") int page){
        if(page < 0)
            return "redirect:/admin/comments";

        var comments = commentService.findAll(sort, search, page);

        if(page > comments.getTotalPages())
            return "redirect:/admin/comments";

        model.addAttribute("title", "comments");
        model.addAttribute("url", "/admin/comments");
        model.addAttribute("page", comments);
        model.addAttribute("total", commentService.commentList().size());

        if(!sort.equals(""))
            model.addAttribute("sort", sort);

        if (!search.equals("")) {
            model.addAttribute("search", search);
        }

        return "admin/comment/list";
    }

    @PostMapping("/admin/comment/{id}/delete")
    public String deleteComment(@PathVariable  Long id, RedirectAttributes redirect){
        Comment comment = commentService.getById(id);

        if(comment == null){
            redirect.addFlashAttribute("messageType", "error");
            redirect.addFlashAttribute("message", "Comment not found");
            return "redirect:/admin/comments";
        }

        commentService.deleteComment(comment);
        redirect.addFlashAttribute("messageType", "success");
        redirect.addFlashAttribute("message", "Comment was successfully delete");

        return "redirect:/admin/comments";
    }

    @PreAuthorize("isAuthenticated()")
    @PostMapping("/comment/{id}/{type}")
    public ResponseEntity<?> like_dislike(@AuthenticationPrincipal User currentUser,
                                          @PathVariable Long id, @PathVariable String type) {
        Comment comment = commentService.getById(id);

        if(comment == null)
            return new ResponseEntity<Object>(new Error("Can't find comment"), HttpStatus.BAD_REQUEST);

        Set<User> likes = comment.getLikes();
        Set<User> dislikes = comment.getDislikes();

        boolean result;
        if(type.equals("like")) {
            if (likes.contains(currentUser)) {
                likes.remove(currentUser);
                result = false;
            } else {
                dislikes.remove(currentUser);
                likes.add(currentUser);
                result = true;
            }
        } else {
            if (dislikes.contains(currentUser)) {
                dislikes.remove(currentUser);
                result = false;
            } else {
                likes.remove(currentUser);
                dislikes.add(currentUser);
                result = true;
            }
        }

        Map<String, Object> json = new HashMap<>();
        json.put("result", result);
        json.put("likes_count", likes.size());
        json.put("dislikes_count", dislikes.size());

        return new ResponseEntity<Object>(json, HttpStatus.OK);
    }
}

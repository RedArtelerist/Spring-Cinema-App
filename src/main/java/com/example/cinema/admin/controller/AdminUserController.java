package com.example.cinema.admin.controller;

import com.example.cinema.account.model.Gender;
import com.example.cinema.account.model.Role;
import com.example.cinema.account.model.User;
import com.example.cinema.account.service.UserService;
import com.example.cinema.admin.dto.UserUpdateDto;
import com.example.cinema.main.service.CommentService;
import com.example.cinema.utils.ControllerUtils;
import org.dom4j.rule.Mode;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.validation.Valid;
import java.util.Collections;
import java.util.Map;

@RequestMapping("/admin")
@Controller
public class AdminUserController {
    @Autowired
    private UserService userService;

    @Autowired
    private CommentService commentService;

    @GetMapping("/users")
    public String userList(Model model, @RequestParam(required = false, defaultValue = "") String search,
                           @RequestParam(required = false, defaultValue = "") String sort,
                           @RequestParam(required = false, defaultValue = "0") int page){
        if(page < 0)
            return "redirect:/admin/users";

        var users = userService.findAll(sort, search, page);

        if(page > users.getTotalPages())
            return "redirect:/admin/users";

        model.addAttribute("title", "users");
        model.addAttribute("url", "/admin/users");
        model.addAttribute("page", users);
        model.addAttribute("total", userService.userList().size());

        if(!sort.equals(""))
            model.addAttribute("sort", sort);

        if (!search.equals("")) {
            model.addAttribute("search", search);
        }

        return "admin/user/list";
    }

    @PostMapping("/user/{id}/ban")
    public String banUser(@AuthenticationPrincipal User currentUser, @PathVariable("id") Long userId,
                          Model model, RedirectAttributes redirect){

        User user = userService.getUserById(userId);

        if(user == null){
            redirect.addFlashAttribute("messageType", "error");
            redirect.addFlashAttribute("message", "User not found");
            return "redirect:/admin/users";
        }

        if(currentUser.getId().equals(user.getId())) {
            redirect.addFlashAttribute("messageType", "error");
            redirect.addFlashAttribute("message", "Error ban user");
            return "redirect:/admin/users";
        }

        if(currentUser.isAdmin() && (user.getRoles().contains(Role.ADMIN) || user.getRoles().contains(Role.OWNER))) {
            redirect.addFlashAttribute("messageType", "error");
            redirect.addFlashAttribute("message", "Error ban user");
            return "redirect:/admin/users";
        }

        userService.banUser(user);
        redirect.addFlashAttribute("messageType", "success");
        if(user.getLocked())
            redirect.addFlashAttribute("message", "User was successfully banned");
        else
            redirect.addFlashAttribute("message", "User was successfully unbanned");

        return "redirect:/admin/users";
    }

    @PostMapping("/user/{id}/delete")
    public String deleteUser(@AuthenticationPrincipal User currentUser, @PathVariable("id") Long userId,
                             Model model, RedirectAttributes redirect){
        User user = userService.getUserById(userId);

        if(user == null){
            redirect.addFlashAttribute("messageType", "error");
            redirect.addFlashAttribute("message", "User not found");
            return "redirect:/admin/users";
        }

        if(currentUser.getId().equals(user.getId())) {
            redirect.addFlashAttribute("messageType", "error");
            redirect.addFlashAttribute("message", "Error delete user");
            return "redirect:/admin/users";
        }

        if(currentUser.isAdmin() && (user.getRoles().contains(Role.ADMIN) || user.getRoles().contains(Role.OWNER))) {
            redirect.addFlashAttribute("messageType", "error");
            redirect.addFlashAttribute("message", "Error delete user");
            return "redirect:/admin/users";
        }

        userService.deleteUser(user);
        redirect.addFlashAttribute("messageType", "success");
        redirect.addFlashAttribute("message", "User was successfully delete");

        return "redirect:/admin/users";
    }

    @PostMapping("/user/{id}/delete_img")
    public String deleteUserImage(@AuthenticationPrincipal User currentUser, @PathVariable("id") Long userId,
                             Model model, RedirectAttributes redirect){
        User user = userService.getUserById(userId);

        if(user == null){
            redirect.addFlashAttribute("messageType", "error");
            redirect.addFlashAttribute("message", "User not found");
            return "redirect:/admin/users";
        }

        try {
            userService.deleteUserImage(user);
        }
        catch (Exception ex){
            redirect.addFlashAttribute("messageType", "error");
            redirect.addFlashAttribute("message", Collections.singletonList(ex.getMessage()));
            return "redirect:/admin/user/" + userId ;
        }

        return "redirect:/admin/user/" + userId;
    }

    @GetMapping("/user/{id}")
    public String editUser(@PathVariable("id") Long userId, Model model) {
        User user = userService.getUserById(userId);

        if(user == null)
            return "redirect:/admin/users";

        model.addAttribute("title", "users");
        model.addAttribute("title_user", "profile");
        model.addAttribute("uuser", user);
        model.addAttribute("genders", Gender.values());
        model.addAttribute("roles", Role.values());

        return "admin/user/detail";
    }

    @PostMapping("/user/{id}/edit")
    public String editUser(@PathVariable("id") Long userId, @Valid UserUpdateDto user,
                           BindingResult bindingResult, Model model, RedirectAttributes redirect) {
        User user_to_edit = userService.getUserById(userId);

        if(user_to_edit == null)
            return "redirect:/admin/users";

        if (bindingResult.hasErrors()) {
            Map<String, String> errors = ControllerUtils.getErrors(bindingResult);
            redirect.addFlashAttribute("messageType", "error");
            redirect.addFlashAttribute("errors", errors.values().toArray());

            return "redirect:/admin/user/" + userId;
        }

        try {
            userService.updateUser(user, user_to_edit);
        }
        catch (Exception ex){
            String[] err = ex.getMessage().split(":");

            redirect.addFlashAttribute("messageType", "error");
            redirect.addFlashAttribute("errors", Collections.singletonList(err[1]));

            return "redirect:/admin/user/" + userId;
        }

        return "redirect:/admin/user/" + userId;
    }

    @GetMapping("/user/{id}/comments")
    public String userComments(@PathVariable Long id, Model model, RedirectAttributes redirect,
                               @RequestParam(required = false, defaultValue = "0") int page){
        User user = userService.getUserById(id);

        if(user == null){
            redirect.addFlashAttribute("messageType", "error");
            redirect.addFlashAttribute("message", "User not found");
            return "redirect:/admin/users";
        }

        if(page < 0)
            return "redirect:/admin/user/" + id + "/comments";

        var comments = commentService.userAdminComments(user,  page);

        if(page >= comments.getTotalPages())
            return "redirect:/admin/user/" + id + "/comments";

        model.addAttribute("title", "users");
        model.addAttribute("title_user", "comments");
        model.addAttribute("uuser", user);
        model.addAttribute("url", "/admin/user/" + id + "/comments");
        model.addAttribute("page", comments);


        return "admin/user/comments";
    }

}

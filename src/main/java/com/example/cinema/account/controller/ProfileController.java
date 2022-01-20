package com.example.cinema.account.controller;

import com.example.cinema.account.dto.PassResetDto;
import com.example.cinema.account.dto.ProfileDto;
import com.example.cinema.account.model.Gender;
import com.example.cinema.account.model.User;
import com.example.cinema.account.service.ProfileService;
import com.example.cinema.account.service.UserService;
import com.example.cinema.utils.ControllerUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;
import java.util.Map;

@Controller
public class ProfileController {
    @Autowired
    private ProfileService profileService;

    @Autowired
    private UserService userService;

    @PreAuthorize("isAuthenticated()")
    @GetMapping("/profile")
    public String profile(@AuthenticationPrincipal User user, Model model){
        model.addAttribute("title", "profile");
        model.addAttribute("userId", user.getId());
        model.addAttribute("user", user);
        model.addAttribute("genders", Gender.values());

        return "main/user/profile";
    }

    @PreAuthorize("isAuthenticated()")
    @PostMapping("/profile")
    public String editProfile(@AuthenticationPrincipal User user, @Valid ProfileDto profile,
                              BindingResult bindingResult, @RequestParam("image") MultipartFile image,
                              Model model, RedirectAttributes redirect,
                              HttpServletRequest request, HttpServletResponse response){
        profile.setImgUrl(user.getImgUrl());

        if (bindingResult.hasErrors()) {
            Map<String, String> errors = ControllerUtils.getErrors(bindingResult);
            model.mergeAttributes(errors);
            model.addAttribute("user", profile);
            model.addAttribute("genders", Gender.values());
            model.addAttribute("userId", user.getId());

            return "main/user/profile";
        }

        try {
            String oldUsername = user.getUsername();
            String oldEmail = user.getEmail();

            profileService.updateProfile(user, profile, image);

            if(!profile.getUsername().equals(oldUsername) || !profile.getEmail().equals(oldEmail)){
                Authentication auth = SecurityContextHolder.getContext().getAuthentication();
                if (auth != null){
                    new SecurityContextLogoutHandler().logout(request, response, auth);
                }
                SecurityContextHolder.getContext().setAuthentication(null);
            }

            if(!user.getEmail().equals(oldEmail)) {
                redirect.addFlashAttribute("messageType", "success");
                redirect.addFlashAttribute("message", "Activate your new email");
                return "redirect:/login";
            }

            if(!user.getUsername().equals(oldUsername)){
                redirect.addFlashAttribute("messageType", "success");
                redirect.addFlashAttribute("message", "Relogin please after update");
                return "redirect:/login";
            }
        }
        catch (Exception ex){
            String[] err = ex.getMessage().split(":");
            if(err[0].equals("username"))
                model.addAttribute("usernameError", err[1]);
            else
                model.addAttribute("emailError", err[1]);

            model.addAttribute("user", profile);
            model.addAttribute("genders", Gender.values());

            return "main/user/profile";
        }

        redirect.addFlashAttribute("messageType", "success");
        redirect.addFlashAttribute("message", "Profile was successfully updated");
        return "redirect:/profile";
    }

    @PreAuthorize("isAuthenticated()")
    @PostMapping("/change_password")
    public String changePassword(@AuthenticationPrincipal User user, @Valid PassResetDto passChangeDto,
                                 BindingResult bindingResult, RedirectAttributes redirect, Model model){
        String password = passChangeDto.getPassword();
        String passwordConfirm = passChangeDto.getPassword2();

        boolean isConfirmEmpty = StringUtils.isEmpty(passwordConfirm);

        if(isConfirmEmpty) {
            redirect.addFlashAttribute("password2Error", "Password confirmation cannot be empty");
        }

        if (password != null && !password.equals(passwordConfirm)) {
            redirect.addFlashAttribute("passwordError", "Passwords are different!");
            return "redirect:/profile";
        }

        if (isConfirmEmpty || bindingResult.hasErrors()) {
            Map<String, String> errors = ControllerUtils.getErrors(bindingResult);
            redirect.addFlashAttribute("passwordError", errors.get("passwordError"));
            return "redirect:/profile";
        }

        profileService.changePassword(user, passChangeDto.getPassword());

        redirect.addFlashAttribute("messageType", "success");
        redirect.addFlashAttribute("message", "Password was successfully changed");
        return "redirect:/profile";
    }

    @PreAuthorize("isAuthenticated()")
    @GetMapping("/subscribe/{id}")
    public String subscribe(@AuthenticationPrincipal User currentUser, @PathVariable Long id) {
        var user = userService.getUserById(id);

        if(user == null)
            return "redirect:/user/" + currentUser.getId();

        if(user.getId().equals(currentUser.getId()))
            return "redirect:/user/" + currentUser.getId();

        profileService.subscribe(currentUser, user);
        return "redirect:/user/" + user.getId();
    }

    @PreAuthorize("isAuthenticated()")
    @GetMapping("/unsubscribe/{id}")
    public String unsubscribe(@AuthenticationPrincipal User currentUser, @PathVariable Long id) {
        var user = userService.getUserById(id);

        if(user == null)
            return "redirect:/user/" + currentUser.getId();

        if(user.getId().equals(currentUser.getId()))
            return "redirect:/user/" + currentUser.getId();

        profileService.unsubscribe(currentUser, user);
        return "redirect:/user/" + user.getId();
    }
}

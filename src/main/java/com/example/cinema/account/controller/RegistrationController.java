package com.example.cinema.account.controller;

import com.example.cinema.account.model.ConfirmationToken;
import com.example.cinema.account.model.User;
import com.example.cinema.account.service.ConfirmationTokenService;
import com.example.cinema.account.service.UserService;
import com.example.cinema.utils.ControllerUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.validation.Valid;
import java.util.Map;
import java.util.Optional;

@Controller
public class RegistrationController {
    @Autowired
    private UserService userService;

    @Autowired
    private ConfirmationTokenService confirmationTokenService;

    @GetMapping("/login")
    public String login(Model model) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth.getPrincipal() instanceof UserDetails) {
            return "redirect:/";
        } else return "login";
    }

    @GetMapping("/registration")
    public String registration(Model model) {
        return "registration";
    }

    @PostMapping("/registration")
    public String registration(@RequestParam("password2") String passwordConfirm,
                               @Valid User user, BindingResult bindingResult,
                               Model model, RedirectAttributes redirect
    ) {
        boolean isConfirmEmpty = StringUtils.isEmpty(passwordConfirm);
        if(isConfirmEmpty)
            model.addAttribute("password2Error", "Password confirmation cannot be empty");

        if (user.getPassword() != null && !user.getPassword().equals(passwordConfirm)) {
            model.addAttribute("passwordError", "Passwords are different!");
            return "registration";
        }

        if (isConfirmEmpty || bindingResult.hasErrors()) {
            Map<String, String> errors = ControllerUtils.getErrors(bindingResult);
            model.mergeAttributes(errors);

            return "registration";
        }

        try {
            userService.signUpUser(user);

            redirect.addFlashAttribute("messageType", "success");
            redirect.addFlashAttribute("message", "Check your mail to activate account");
            return "redirect:/login";
        }
        catch (Exception ex){
            String[] err = ex.getMessage().split(":");
            if(err[0].equals("username"))
                model.addAttribute("usernameError", err[1]);
            else
                model.addAttribute("emailError", err[1]);
            return "registration";
        }
    }

    @GetMapping("/confirm/{token}")
    public String activate(Model model, @PathVariable String token, RedirectAttributes redirect) {
        Optional<ConfirmationToken> tokenOptional = confirmationTokenService.findConfirmationTokenByToken(token);
        if (tokenOptional.isPresent()) {
            userService.confirmUser(tokenOptional.get());
            redirect.addFlashAttribute("messageType", "success");
            redirect.addFlashAttribute("message", "User successfully activated");
        } else {
            redirect.addFlashAttribute("messageType", "danger");
            redirect.addFlashAttribute("message", "Activation code is not found!");
        }

        return "redirect:/login";
    }
}

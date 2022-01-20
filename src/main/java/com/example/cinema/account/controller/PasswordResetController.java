package com.example.cinema.account.controller;

import com.example.cinema.account.dto.PassResetDto;
import com.example.cinema.account.model.PasswordResetToken;
import com.example.cinema.account.model.User;
import com.example.cinema.account.service.PasswordResetTokenService;
import com.example.cinema.account.service.UserService;
import com.example.cinema.utils.ControllerUtils;
import org.springframework.beans.factory.annotation.Autowired;
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
public class PasswordResetController {
    @Autowired
    private UserService userService;

    @Autowired
    private PasswordResetTokenService resetTokenService;

    @GetMapping("/forgot-password")
    public String forgotPassword(Model model){
        return "password-reset/forgot-password";
    }

    @PostMapping("/forgot-password")
    public String forgotPassword(@RequestParam("email") String email, Model model, RedirectAttributes redirect){
        try {
            User user = userService.findUserByEmail(email);
            userService.forgotPassword(user);

            redirect.addFlashAttribute("messageType", "success");
            redirect.addFlashAttribute("message", "Check your mail to reset password");
            return "redirect:/login";
        }
        catch (Exception ex){
            model.addAttribute("messageType", "danger");
            model.addAttribute("message", ex.getMessage());
        }
        return "password-reset/forgot-password";
    }

    @GetMapping("/reset-password/{token}")
    public String resetPassword(@PathVariable String token, Model model, RedirectAttributes redirect){
        String result = resetTokenService.validatePasswordResetToken(token);
        if(result != null) {
            redirect.addFlashAttribute("messageType", "danger");

            if(result.equals("invalidToken"))
                redirect.addFlashAttribute("message", "Invalid password reset token");
            else {
                Optional<PasswordResetToken> resetToken = resetTokenService.findPasswordResetTokenByToken(token);
                resetTokenService.deletePasswordResetToken(resetToken.get().getId());
                redirect.addFlashAttribute("message", "Reset form is expired");
            }
            return "redirect:/forgot-password";
        } else {
            return "password-reset/reset-password";
        }
    }

    @PostMapping("/reset-password/{token}")
    public String resetPassword(@PathVariable String token, @Valid PassResetDto passResetDto,
                                BindingResult bindingResult, Model model, RedirectAttributes redirect){

        String password = passResetDto.getPassword();
        String passwordConfirm = passResetDto.getPassword2();

        boolean isConfirmEmpty = StringUtils.isEmpty(passwordConfirm);

        if(isConfirmEmpty)
            model.addAttribute("password2Error", "Password confirmation cannot be empty");

        if (password != null && !password.equals(passwordConfirm)) {
            model.addAttribute("passwordError", "Passwords are different!");
            return "password-reset/reset-password";
        }

        if (isConfirmEmpty || bindingResult.hasErrors()) {
            Map<String, String> errors = ControllerUtils.getErrors(bindingResult);
            model.mergeAttributes(errors);

            return "password-reset/reset-password";
        }

        Optional<PasswordResetToken> tokenOptional = resetTokenService.findPasswordResetTokenByToken(token);
        if(tokenOptional.isPresent()){
            userService.resetPassword(tokenOptional.get(), password);
            redirect.addFlashAttribute("messageType", "success");
            redirect.addFlashAttribute("message", "Password successfully reset");
            return "redirect:/login";
        }
        else {
            redirect.addFlashAttribute("messageType", "danger");
            redirect.addFlashAttribute("message", "Invalid password reset token");
            return "redirect:/forgot-password";
        }

    }
}

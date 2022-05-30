package com.example.cinema.admin.controller;

import com.example.cinema.account.service.MailSenderService;
import com.example.cinema.main.model.ContactUsMessage;
import com.example.cinema.main.service.ContactUsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

@RequestMapping("/admin")
@Controller
public class ContactUsController {
    @Autowired
    private ContactUsService contactUsService;

    @Autowired
    private MailSenderService mailSenderService;

    @GetMapping("/messages")
    public String comments(Model model, @RequestParam(required = false, defaultValue = "0") int page){
        if(page < 0)
            return "redirect:/admin/messages";

        var messages = contactUsService.findAll(page);

        if(page > messages.getTotalPages())
            return "redirect:/admin/messages";

        model.addAttribute("title", "messages");
        model.addAttribute("url", "/admin/messages");
        model.addAttribute("page", messages);
        model.addAttribute("total", contactUsService.messageList().size());

        return "admin/contact-us/list";
    }

    @PostMapping("/message/{id}/delete")
    public String deleteMessage(@PathVariable Long id, RedirectAttributes redirect){
        ContactUsMessage message = contactUsService.getById(id);

        if(message == null){
            redirect.addFlashAttribute("messageType", "error");
            redirect.addFlashAttribute("message", "Message not found");
            return "redirect:/admin/messages";
        }

        contactUsService.deleteMessage(message);
        redirect.addFlashAttribute("messageType", "success");
        redirect.addFlashAttribute("message", "Message was successfully delete");

        return "redirect:/admin/messages";
    }

    @PostMapping("/message/{id}/answer")
    public String answerOnMessage(@PathVariable Long id, @RequestParam String text, RedirectAttributes redirect){
        ContactUsMessage message = contactUsService.getById(id);

        if(message == null){
            redirect.addFlashAttribute("messageType", "error");
            redirect.addFlashAttribute("message", "Message not found");
            return "redirect:/admin/messages";
        }

        if(text.trim().length() < 10 || text.trim().length() > 1000)
            return "redirect:/admin/messages";

        String baseUrl = ServletUriComponentsBuilder.fromCurrentContextPath().build().toUriString();
        String msg = "You:\n" + message.getText() + "\n\nAnswer:\n" + text + "\n\nYour AMovie, " + baseUrl;
        mailSenderService.send(message.getEmail(), "Answer for your message", msg);

        contactUsService.deleteMessage(message);
        redirect.addFlashAttribute("messageType", "success");
        redirect.addFlashAttribute("message", "Answer was successfully sent");

        return "redirect:/admin/messages";
    }
}

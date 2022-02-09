package com.example.cinema.admin.controller;

import com.example.cinema.account.service.UserService;
import com.example.cinema.cinema.service.TicketService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@RequestMapping("/admin")
@Controller
public class AdminTicketController {
    @Autowired
    private TicketService ticketService;

    @Autowired
    private UserService userService;

    @GetMapping("/tickets")
    public String tickets(
            @RequestParam(required = false, defaultValue = "0") int page,
            @RequestParam(required = false, defaultValue = "") String search, Model model
    ){
        if(page < 0)
            return "redirect:/admin/tickets";

        var tickets = ticketService.findAll(page, search);

        if(page > tickets.getTotalPages())
            return "redirect:/admin/tickets";

        model.addAttribute("page", tickets);
        model.addAttribute("total", ticketService.ticketList().size());
        model.addAttribute("url", "/admin/tickets");

        if (!search.equals("")) {
            model.addAttribute("search", search);
        }

        return "admin/ticket/list";
    }

    @GetMapping("/user/{id}/tickets")
    public String userTickets(
            @PathVariable Long id, Model model, RedirectAttributes redirect,
            @RequestParam(required = false, defaultValue = "0") int page
    ){
        var user = userService.getUserById(id);

        if(user == null){
            redirect.addFlashAttribute("messageType", "error");
            redirect.addFlashAttribute("message", "User not found");
            return "redirect:/admin/users";
        }

        if(page < 0)
            return "redirect:/admin/user/" + id + "/tickets";

        var tickets = ticketService.ticketsByUserAdmin(user, page);

        if(page > tickets.getTotalPages())
            return "redirect:/admin/user/" + id + "/tickets";

        model.addAttribute("title", "users");
        model.addAttribute("title_user", "tickets");
        model.addAttribute("uuser", user);
        model.addAttribute("url", "/admin/user/" + id + "/tickets");
        model.addAttribute("page", tickets);

        return "admin/user/tickets";
    }

    @PostMapping("/ticket/{id}/delete")
    public String deleteTicket(@PathVariable String id, RedirectAttributes redirect){
        var ticket = ticketService.getByNumber(id);

        if(ticket == null){
            redirect.addFlashAttribute("messageType", "error");
            redirect.addFlashAttribute("message", "Ticket not found");
            return "redirect:/admin/tickets";
        }

        Long userId = null;
        if(ticket.getUser() != null)
            userId = ticket.getUser().getId();

        ticketService.removeTicket(ticket);

        if(userId == null){
            redirect.addFlashAttribute("messageType", "success");
            redirect.addFlashAttribute("message", "Ticket was successfully deleted");
            return "redirect:/admin/tickets";
        } else {
            redirect.addFlashAttribute("messageType", "success");
            redirect.addFlashAttribute("message", "Ticket was successfully deleted");
            return "redirect:/admin/user/" + userId +"/tickets";
        }
    }
}

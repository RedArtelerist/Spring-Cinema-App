package com.example.cinema.admin.controller;

import com.example.cinema.admin.dto.AdminMovieDto;
import com.example.cinema.admin.model.Category;
import com.example.cinema.admin.service.MovieService;
import com.example.cinema.cinema.model.Cinema;
import com.example.cinema.cinema.model.Seance;
import com.example.cinema.cinema.model.Technology;
import com.example.cinema.cinema.service.CinemaService;
import com.example.cinema.cinema.service.HallService;
import com.example.cinema.cinema.service.SeanceService;
import com.example.cinema.utils.ControllerUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.validation.Valid;
import java.util.Map;

@RequestMapping("/admin/cinema/{cinemaId}")
@Controller
public class AdminSeanceController {
    @Autowired
    private CinemaService cinemaService;

    @Autowired
    private SeanceService seanceService;

    @Autowired
    private MovieService movieService;

    @Autowired
    private HallService hallService;

    @GetMapping("/seances")
    public String seances(@PathVariable Long cinemaId, Model model, RedirectAttributes redirect,
                          @RequestParam(required = false, defaultValue = "") String sort,
                          @RequestParam(required = false, defaultValue = "") String date,
                          @RequestParam(required = false, defaultValue = "") String movieId,
                          @RequestParam(required = false, defaultValue = "0") int page){
        Cinema cinema = cinemaService.getById(cinemaId);

        if(cinema == null){
            redirect.addFlashAttribute("messageType", "error");
            redirect.addFlashAttribute("message", "Cinema not found");
            return "redirect:/admin/cinemas";
        }

        if(!sort.equals(""))
            model.addAttribute("sort", sort);
        if(!date.equals(""))
            model.addAttribute("date", date);

        AdminMovieDto movie = null;
        try {
            movie = movieService.getByIdForAdmin(Long.parseLong(movieId));
            model.addAttribute("movie", movie);
        }
        catch (Exception ignored){}

        model.addAttribute("cinema", cinema);
        model.addAttribute("url", "/admin/ciname/" + cinemaId + "/seances");
        model.addAttribute("page", seanceService.findSeancesByCinema(cinema, sort, date, movie, page));
        model.addAttribute("total", seanceService.seanceList(cinema).size());
        model.addAttribute("dates", seanceService.getDates(cinema));
        model.addAttribute("movies", seanceService.getMoviesForAdmin(cinema));


        return "admin/cinema/seances";
    }

    @GetMapping("/seance/create")
    public String seanceCreate(@PathVariable Long cinemaId, Model model, RedirectAttributes redirect){
        Cinema cinema = cinemaService.getById(cinemaId);

        if(cinema == null){
            redirect.addFlashAttribute("messageType", "error");
            redirect.addFlashAttribute("message", "Cinema not found");
            return "redirect:/admin/cinemas";
        }

        addModelAttr(cinema, model);

        return "admin/cinema/seance_form";
    }

    @PostMapping("/seance/create")
    public String seanceCreate(@PathVariable Long cinemaId, @Valid Seance seance, BindingResult bindingResult,
                               Model model, RedirectAttributes redirect){
        Cinema cinema = cinemaService.getById(cinemaId);

        if(cinema == null){
            redirect.addFlashAttribute("messageType", "error");
            redirect.addFlashAttribute("message", "Cinema not found");
            return "redirect:/admin/cinemas";
        }

        if (bindingResult.hasErrors()) {
            Map<String, String> errorsMap = ControllerUtils.getErrors(bindingResult);
            model.mergeAttributes(errorsMap);
            model.addAttribute("seance", seance);
            addModelAttr(cinema, model);

            return "admin/cinema/seance_form";
        }
        try {
            seanceService.createSeance(seance);
        }
        catch (Exception ex){
            model.addAttribute("startTimeError", ex.getMessage());
            model.addAttribute("seance", seance);
            addModelAttr(cinema, model);

            return "admin/cinema/seance_form";
        }

        return "redirect:/admin/cinema/" + cinemaId + "/seances";
    }

    @GetMapping("/seance/{id}")
    public String seanceEdit(@PathVariable Long cinemaId, @PathVariable Long id, Model model, RedirectAttributes redirect){
        Cinema cinema = cinemaService.getById(cinemaId);

        if(cinema == null){
            redirect.addFlashAttribute("messageType", "error");
            redirect.addFlashAttribute("message", "Cinema not found");
            return "redirect:/admin/cinemas";
        }

        Seance editSeance = seanceService.getById(id);

        if(editSeance == null){
            redirect.addFlashAttribute("messageType", "error");
            redirect.addFlashAttribute("message", "Seance not found");
            return "redirect:/admin/cinema/" + cinemaId + "/seances";
        }

        model.addAttribute("seance", editSeance);
        addModelAttr(cinema, model);

        return "admin/cinema/seance_form";
    }

    @PostMapping("/seance/{id}")
    public String seanceEdit(@PathVariable Long cinemaId, @PathVariable Long id, @Valid Seance seance, BindingResult bindingResult,
                               Model model, RedirectAttributes redirect){
        Cinema cinema = cinemaService.getById(cinemaId);

        if(cinema == null){
            redirect.addFlashAttribute("messageType", "error");
            redirect.addFlashAttribute("message", "Cinema not found");
            return "redirect:/admin/cinemas";
        }

        Seance editSeance = seanceService.getById(id);

        if(editSeance == null){
            redirect.addFlashAttribute("messageType", "error");
            redirect.addFlashAttribute("message", "Seance not found");
            return "redirect:/admin/cinema/" + cinemaId + "/seances";
        }

        if (bindingResult.hasErrors()) {
            Map<String, String> errorsMap = ControllerUtils.getErrors(bindingResult);
            model.mergeAttributes(errorsMap);
            model.addAttribute("seance", seance);
            addModelAttr(cinema, model);

            return "admin/cinema/seance_form";
        }
        try {
            seanceService.updateSeance(editSeance, seance);
            redirect.addFlashAttribute("messageType", "success");
            redirect.addFlashAttribute("message", "Seance was successfully updated");
        }
        catch (Exception ex){
            model.addAttribute("startTimeError", ex.getMessage());
            model.addAttribute("seance", seance);
            addModelAttr(cinema, model);

            return "admin/cinema/seance_form";
        }

        return "redirect:/admin/cinema/" + cinemaId + "/seance/" + id;
    }

    @PostMapping("/seance/{id}/delete")
    public String seanceDelete(@PathVariable Long cinemaId, @PathVariable Long id, RedirectAttributes redirect){
        Cinema cinema = cinemaService.getById(cinemaId);

        if(cinema == null){
            redirect.addFlashAttribute("messageType", "error");
            redirect.addFlashAttribute("message", "Cinema not found");
            return "redirect:/admin/cinemas";
        }

        Seance seance = seanceService.getById(id);

        if(seance == null){
            redirect.addFlashAttribute("messageType", "error");
            redirect.addFlashAttribute("message", "Seance not found");
            return "redirect:/admin/cinema/" + cinemaId + "/seances";
        }
        seanceService.deleteSeance(seance);

        redirect.addFlashAttribute("messageType", "success");
        redirect.addFlashAttribute("message", "Seance was successfully deleted");
        return "redirect:/admin/cinema/" + cinemaId + "/seances";
    }

    private void addModelAttr(Cinema cinema, Model model){
        model.addAttribute("cinema", cinema);
        model.addAttribute("technologies", Technology.values());
        model.addAttribute("movies", movieService.findByCategory(Category.Movie));
        model.addAttribute("halls", hallService.findByCinema(cinema));
    }
}

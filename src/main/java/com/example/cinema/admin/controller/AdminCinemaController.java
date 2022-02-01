package com.example.cinema.admin.controller;

import com.example.cinema.cinema.model.Cinema;
import com.example.cinema.cinema.model.City;
import com.example.cinema.cinema.model.Hall;
import com.example.cinema.cinema.model.ImageCinema;
import com.example.cinema.cinema.service.CinemaService;
import com.example.cinema.cinema.service.HallService;
import com.example.cinema.utils.ControllerUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.validation.Valid;
import java.io.IOException;
import java.util.Map;

@RequestMapping("/admin")
@Controller
public class AdminCinemaController {
    @Autowired
    private CinemaService cinemaService;

    @Autowired
    private HallService hallService;

    @GetMapping("/cinemas")
    public String cinemaList(Model model, @RequestParam(required = false, defaultValue = "") String search,
                            @RequestParam(required = false, defaultValue = "") String sort,
                            @RequestParam(required = false, defaultValue = "0") int page){
        if(page < 0)
            return "redirect:/admin/cinemas";

        var cinemas = cinemaService.findForAdmin(sort, search, page);

        if(page > cinemas.getTotalPages())
            return "redirect:/admin/cinemas";

        model.addAttribute("title", "cinemas");
        model.addAttribute("url", "/admin/cinemas");
        model.addAttribute("page", cinemas);
        model.addAttribute("total", cinemaService.cinemaList().size());

        if(!sort.equals(""))
            model.addAttribute("sort", sort);

        if (!search.equals("")) {
            model.addAttribute("search", search);
        }

        return "admin/cinema/list";
    }

    @GetMapping("/cinema/create")
    public String cinemaCreate(Model model){
        model.addAttribute("cities", City.values());

        return "admin/cinema/form";
    }

    @PostMapping("/cinema/create")
    public String cinemaCreate(@Valid Cinema cinema, BindingResult bindingResult,
                               MultipartFile image, MultipartFile[] images, Model model) throws IOException {
        if(bindingResult.hasErrors()){
            Map<String, String> errors = ControllerUtils.getErrors(bindingResult);
            model.mergeAttributes(errors);
            model.addAttribute("cities", City.values());

            return "admin/cinema/form";
        }

        cinemaService.createCinema(cinema, image, images);

        return "redirect:/admin/cinemas";
    }

    @GetMapping("/cinema/{id}/edit")
    public String cinemaEdit(@PathVariable Long id, Model model, RedirectAttributes redirect){
        Cinema cinema = cinemaService.getById(id);

        if(cinema == null){
            redirect.addFlashAttribute("messageType", "error");
            redirect.addFlashAttribute("message", "Cinema not found");

            return "redirect:/admin/cinemas";
        }

        model.addAttribute("cinema", cinema);
        model.addAttribute("cities", City.values());

        return "admin/cinema/form";
    }

    @PostMapping("/cinema/{id}/edit")
    public String cinemaEdit(@PathVariable Long id, @Valid Cinema cinema, BindingResult bindingResult,
                            MultipartFile image, Model model, MultipartFile[] images, RedirectAttributes redirect) throws IOException {
        Cinema editCinema = cinemaService.getById(id);

        if(editCinema == null){
            redirect.addFlashAttribute("messageType", "error");
            redirect.addFlashAttribute("message", "Cinema not found");

            return "redirect:/admin/cinemas";
        }

        if(bindingResult.hasErrors()){
            Map<String, String> errors = ControllerUtils.getErrors(bindingResult);
            model.mergeAttributes(errors);
            model.addAttribute("cinema", cinema);
            model.addAttribute("cities", City.values());

            return "admin/cinema/form";
        }

        cinemaService.editCinema(cinema, editCinema, image, images);

        return "redirect:/admin/cinema/" + id + "/edit";
    }

    @PostMapping("/cinema/{id}/delete")
    public String cinemaDelete(@PathVariable Long id, RedirectAttributes redirect){
        Cinema cinema = cinemaService.getById(id);

        if(cinema == null){
            redirect.addFlashAttribute("messageType", "error");
            redirect.addFlashAttribute("message", "Cinema not found");
            return "redirect:/admin/cinemas";
        }

        try {
            cinemaService.deleteCinema(cinema);
            redirect.addFlashAttribute("messageType", "success");
            redirect.addFlashAttribute("message", "Cinema was successfully delete");
        }
        catch (Exception ex){
            System.out.print(ex.getMessage());
        }

        return "redirect:/admin/cinemas";
    }

    @PostMapping("/cinema/{id}/image/{imgId}/delete")
    public String cinemaImageDelete(@PathVariable Long id, @PathVariable Long imgId, RedirectAttributes redirect){
        Cinema cinema = cinemaService.getById(id);

        if(cinema == null){
            redirect.addFlashAttribute("messageType", "error");
            redirect.addFlashAttribute("message", "Cinema not found");
            return "redirect:/admin/cinemas";
        }

        ImageCinema imageCinema = cinemaService.getImageById(imgId);

        if(imageCinema == null)
            return "redirect:/admin/cinema/" + id + "/edit";

        try {
            cinemaService.deleteImage(cinema, imageCinema);
        }
        catch (Exception ignored){}

        return "redirect:/admin/cinema/" + id + "/edit";
    }

    @PostMapping("/hall/create")
    public String createHall(@Valid Hall hall, BindingResult bindingResult, RedirectAttributes redirect){
        Long cinemaId = hall.getCinema().getId();
        Cinema cinema = cinemaService.getById(cinemaId);

        if(cinema == null){
            redirect.addFlashAttribute("messageType", "error");
            redirect.addFlashAttribute("message", "Cinema not found");
            return "redirect:/admin/cinemas";
        }

        if (bindingResult.hasErrors()) {
            Map<String, String> errorsMap = ControllerUtils.getErrors(bindingResult);

            redirect.addFlashAttribute("hallNameError", errorsMap.get("nameError"));
            redirect.addFlashAttribute("numSeatsError", errorsMap.get("numSeatsError"));
            redirect.addFlashAttribute("hallId", hall.getId());
            redirect.addFlashAttribute("hallName", hall.getName());
            redirect.addFlashAttribute("hallNum", hall.getNumSeats());
            redirect.addFlashAttribute("hallActive", hall.isActive());

            return "redirect:/admin/cinema/" + cinemaId + "/edit";
        } else {
            if(hall.getId() != null){
                Hall editHall = hallService.getById(hall.getId());
                if(editHall == null){
                    redirect.addFlashAttribute("messageType", "error");
                    redirect.addFlashAttribute("message", "Hall not found");
                    return "redirect:/admin/cinema/" + cinemaId + "/edit";
                }
                try {
                    hallService.updateHall(editHall, hall);
                }
                catch (Exception ex){
                    redirect.addFlashAttribute("numSeatsError", ex.getMessage());
                    redirect.addFlashAttribute("hallId", hall.getId());
                    redirect.addFlashAttribute("hallName", hall.getName());
                    redirect.addFlashAttribute("hallNum", hall.getNumSeats());
                    redirect.addFlashAttribute("hallActive", hall.isActive());
                    return "redirect:/admin/cinema/" + cinemaId + "/edit";
                }
            } else
                hallService.saveHall(hall);

            return "redirect:/admin/cinema/" + cinemaId + "/edit";
        }
    }

    @PostMapping("/hall/{id}/delete")
    public String deleteHall(@PathVariable Long id, RedirectAttributes redirect){
        Hall hall = hallService.getById(id);

        if(hall == null){
            redirect.addFlashAttribute("messageType", "error");
            redirect.addFlashAttribute("message", "Hall not found");
            return "redirect:/admin/cinemas";
        }

        Long cinemaId = hall.getCinema().getId();

        hallService.delete(hall);

        redirect.addFlashAttribute("messageType", "success");
        redirect.addFlashAttribute("message", "Hall was successfully deleted");
        return "redirect:/admin/cinema/" + cinemaId + "/edit";
    }

}
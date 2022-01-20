package com.example.cinema.admin.controller;

import com.example.cinema.account.model.Gender;
import com.example.cinema.admin.model.Star;
import com.example.cinema.admin.service.StarService;
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
public class AdminStarController {
    @Autowired
    private StarService starService;

    @GetMapping("/stars")
    public String starList(Model model, @RequestParam(required = false, defaultValue = "") String search,
                           @RequestParam(required = false, defaultValue = "") String sort,
                           @RequestParam(required = false, defaultValue = "0") int page){
        if(page < 0)
            return "redirect:/admin/stars";

        var stars = starService.findAll(sort, search, page);

        if(page > stars.getTotalPages())
            return "redirect:/admin/stars";

        model.addAttribute("title", "stars");
        model.addAttribute("url", "/admin/stars");
        model.addAttribute("page", stars);
        model.addAttribute("total", starService.starList().size());

        if(!sort.equals(""))
            model.addAttribute("sort", sort);

        if (!search.equals("")) {
            model.addAttribute("search", search);
        }

        return "admin/star/list";
    }

    @GetMapping("/star/create")
    public String starCreate(Model model){
        model.addAttribute("genders", Gender.values());
        return "admin/star/form";
    }

    @PostMapping("/star/create")
    public String starCreate(@Valid Star star, BindingResult bindingResult,
                             MultipartFile image, Model model) throws IOException {
        if(bindingResult.hasErrors()){
            Map<String, String> errors = ControllerUtils.getErrors(bindingResult);
            model.mergeAttributes(errors);
            model.addAttribute("genders", Gender.values());

            return "admin/star/form";
        }

        if(star.getDeath() != null){
            if(star.getBirthday().after(star.getDeath())) {
                model.addAttribute("deathError", "Death can't be before birthday");
                model.addAttribute("genders", Gender.values());
                return "admin/star/form";
            }
        }

        starService.createStar(star, image);

        return "redirect:/admin/stars";
    }

    @GetMapping("/star/{id}/edit")
    public String starEdit(@PathVariable Long id, Model model, RedirectAttributes redirect){
        Star star = starService.getStarById(id);

        if(star == null){
            redirect.addFlashAttribute("messageType", "error");
            redirect.addFlashAttribute("message", "Star not found");

            return "redirect:/admin/stars";
        }

        model.addAttribute("star", star);
        model.addAttribute("genders", Gender.values());

        return "admin/star/form";
    }

    @PostMapping("/star/{id}/edit")
    public String starEdit(@PathVariable Long id, @Valid Star star, BindingResult bindingResult,
                           MultipartFile image, Model model, RedirectAttributes redirect) throws IOException {
        Star editStar = starService.getStarById(id);

        if(editStar == null){
            redirect.addFlashAttribute("messageType", "error");
            redirect.addFlashAttribute("message", "Star not found");

            return "redirect:/admin/companies";
        }

        if(bindingResult.hasErrors()){
            Map<String, String> errors = ControllerUtils.getErrors(bindingResult);
            model.mergeAttributes(errors);
            model.addAttribute("star", star);
            model.addAttribute("genders", Gender.values());

            return "admin/star/form";
        }

        starService.editStar(star, editStar, image);

        return "redirect:/admin/stars";
    }

    @PostMapping("/star/{id}/delete")
    public String starDelete(@PathVariable Long id, RedirectAttributes redirect){
        Star star = starService.getStarById(id);

        if(star == null){
            redirect.addFlashAttribute("messageType", "error");
            redirect.addFlashAttribute("message", "Star not found");
            return "redirect:/admin/stars";
        }

        starService.deleteStar(star);
        redirect.addFlashAttribute("messageType", "success");
        redirect.addFlashAttribute("message", "Star was successfully delete");

        return "redirect:/admin/stars";
    }
}

package com.example.cinema.admin.controller;

import com.example.cinema.account.model.Gender;
import com.example.cinema.admin.model.*;
import com.example.cinema.admin.service.CompanyService;
import com.example.cinema.admin.service.MovieService;
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
public class AdminMovieController {
    @Autowired
    private MovieService movieService;

    @Autowired
    private StarService starService;

    @Autowired
    private CompanyService companyService;

    @GetMapping("/movies")
    public String movieList(Model model, @RequestParam(required = false, defaultValue = "") String search,
                           @RequestParam(required = false, defaultValue = "") String sort,
                           @RequestParam(required = false, defaultValue = "0") int page){
        if(page < 0)
            return "redirect:/admin/movies";

        var movies = movieService.findItemsForAdmin(sort, search, page);

        if(page > movies.getTotalPages())
            return "redirect:/admin/movies";

        model.addAttribute("title", "movies");
        model.addAttribute("url", "/admin/movies");
        model.addAttribute("page", movies);
        model.addAttribute("total", movieService.movieList().size());

        if(!sort.equals(""))
            model.addAttribute("sort", sort);

        if (!search.equals("")) {
            model.addAttribute("search", search);
        }

        return "admin/movie/list";
    }

    @GetMapping("/movie/create")
    public String movieCreate(Model model){
        addAttributes(model);

        return "admin/movie/form";
    }

    @PostMapping("/movie/create")
    public String movieCreate(@Valid Movie movie, BindingResult bindingResult,
                              MultipartFile poster, MultipartFile[] images, Model model) throws IOException {
        if(bindingResult.hasErrors()){
            Map<String, String> errors = ControllerUtils.getErrors(bindingResult);
            model.mergeAttributes(errors);
            addAttributes(model);

            return "admin/movie/form";
        }

        movieService.createMovie(movie, poster, images);

        return "redirect:/admin/movies";
    }

    @GetMapping("/movie/{id}/edit")
    public String movieEdit(@PathVariable Long id, Model model, RedirectAttributes redirect){
        Movie movie = movieService.getById(id);

        if(movie == null){
            redirect.addFlashAttribute("messageType", "error");
            redirect.addFlashAttribute("message", "Movie not found");

            return "redirect:/admin/movies";
        }

        model.addAttribute("movie", movie);
        addAttributes(model);
        return "admin/movie/form";
    }

    @PostMapping("/movie/{id}/edit")
    public String movieEdit(@PathVariable Long id, @Valid Movie movie, BindingResult bindingResult,
                           MultipartFile poster, Model model, MultipartFile[] images, RedirectAttributes redirect) throws IOException {
        Movie editMovie = movieService.getById(id);

        if(editMovie == null){
            redirect.addFlashAttribute("messageType", "error");
            redirect.addFlashAttribute("message", "Movie not found");

            return "redirect:/admin/movies";
        }

        if(bindingResult.hasErrors()){
            Map<String, String> errors = ControllerUtils.getErrors(bindingResult);
            model.mergeAttributes(errors);
            model.addAttribute("movie", movie);
            addAttributes(model);

            return "admin/movie/form";
        }

        movieService.editMovie(movie, editMovie, poster, images);

        return "redirect:/admin/movie/" + id + "/edit";
    }

    @PostMapping("/movie/{id}/delete")
    public String movieDelete(@PathVariable Long id, RedirectAttributes redirect){
        Movie movie = movieService.getById(id);

        if(movie == null){
            redirect.addFlashAttribute("messageType", "error");
            redirect.addFlashAttribute("message", "Movie not found");
            return "redirect:/admin/movies";
        }

        try {
            movieService.deleteMovie(movie);
            redirect.addFlashAttribute("messageType", "success");
            redirect.addFlashAttribute("message", "Movie was successfully delete");
        }
        catch (Exception ex){
            System.out.print(ex.getMessage());
        }

        return "redirect:/admin/movies";
    }

    @PostMapping("/movie/{id}/image/{imgId}/delete")
    public String movieImageDelete(@PathVariable Long id, @PathVariable Long imgId, RedirectAttributes redirect){
        Movie movie = movieService.getById(id);

        if(movie == null){
            redirect.addFlashAttribute("messageType", "error");
            redirect.addFlashAttribute("message", "Movie not found");
            return "redirect:/admin/movies";
        }

        ImageMovie imageMovie = movieService.getImageById(imgId);

        if(imageMovie == null)
            return "redirect:/admin/movie/" + id + "/edit";

        try {
            movieService.deleteImage(movie, imageMovie);
        }
        catch (Exception ignored){}

        return "redirect:/admin/movie/" + id + "/edit";
    }

    private void addAttributes(Model model){
        model.addAttribute("countries", Country.values());
        model.addAttribute("genres", Genre.values());
        model.addAttribute("rates", MPAA.values());
        model.addAttribute("categories", Category.values());
        model.addAttribute("stars", starService.starList());
        model.addAttribute("companies", companyService.companyList());
    }
}

package com.example.cinema.admin.service;

import com.example.cinema.account.model.User;
import com.example.cinema.admin.model.Movie;
import com.example.cinema.admin.model.Star;
import com.example.cinema.admin.repository.MovieRepository;
import com.example.cinema.admin.repository.StarRepository;
import com.example.cinema.main.dto.MovieDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.persistence.EntityManager;
import java.io.IOException;
import java.util.*;
import java.util.stream.Collectors;

@Service
public class StarService {
    @Autowired
    private StarRepository starRepository;

    @Autowired
    private FirebaseImageService firebaseImageService;

    @Autowired
    private MovieRepository movieRepository;

    @Autowired
    private EntityManager em;

    public List<Star> starList(){
        return starRepository.findAll(Sort.by(Sort.Direction.ASC, "firstName", "lastName"));
    }

    public Page<Star> findAll(String sort, String search, int pageNum){
        var sorting = Sort.by(Sort.Direction.ASC, "firstName", "lastName");

        if(sort.equals("name-asc"))
            sorting = Sort.by(Sort.Direction.ASC, "firstName", "lastName");

        if(sort.equals("name-desc"))
            sorting = Sort.by(Sort.Direction.DESC, "firstName", "lastName");

        if(sort.equals("status"))
            sorting = Sort.by(Sort.Direction.ASC, "status", "firstName", "lastName");

        if(sort.equals("birthday"))
            sorting = Sort.by(Sort.Direction.ASC, "birthday");

        Pageable pageable = PageRequest.of(pageNum,30, sorting);

        if(search != null && !search.equals(""))
            return starRepository.search(search.toLowerCase(), pageable);

        return starRepository.findAll(pageable);
    }

    public Page<Star> starList(String sort, String search, int pageNum){
        var sorting = Sort.by(Sort.Direction.ASC, "firstName", "lastName");

        if(sort.equals("name-asc"))
            sorting = Sort.by(Sort.Direction.ASC, "firstName", "lastName");

        if(sort.equals("name-desc"))
            sorting = Sort.by(Sort.Direction.DESC, "firstName", "lastName");
        if(sort.equals("birthday"))
            sorting = Sort.by(Sort.Direction.ASC, "birthday");

        if(sort.equals("popularity")) {
            Pageable pageable = PageRequest.of(pageNum - 1, 20);
            if(search != null && !search.equals(""))
                return starRepository.sortByPopularity(search, pageable);
            else
                return starRepository.sortByPopularity(pageable);
        }

        Pageable pageable = PageRequest.of(pageNum - 1,20, sorting);

        if(search != null && !search.equals(""))
            return starRepository.findBySearch(search.toLowerCase(), pageable);

        return starRepository.findAll(pageable);
    }

    public Star getStarById(Long id){
        Optional<Star> optionalStar = starRepository.findById(id);
        return optionalStar.orElse(null);
    }

    public Star findById(Long id){
        Optional<Star> optionalStar = starRepository.findActiveById(id);
        return optionalStar.orElse(null);
    }

    public void createStar(Star star, MultipartFile image) throws IOException {
        if(image != null && !image.getOriginalFilename().isEmpty()) {
            String name = firebaseImageService.save(image, "stars");
            String imageUrl = firebaseImageService.getImageUrl(name);
            star.setImgName(name);
            star.setImgUrl(imageUrl);
        }

        starRepository.save(star);
    }

    public void editStar(Star star, Star editStar, MultipartFile image) throws IOException {
        editStar.setFirstName(star.getFirstName());
        editStar.setLastName(star.getLastName());
        editStar.setGender(star.getGender());
        editStar.setBirthPlace(star.getBirthPlace());
        editStar.setBirthday(star.getBirthday());
        editStar.setDeath(star.getDeath());
        editStar.setStatus(star.isStatus());

        if(image != null && !image.getOriginalFilename().isEmpty()) {
            if(editStar.getImgName() != null && !editStar.getImgName().isEmpty())
                firebaseImageService.delete(editStar.getImgName());

            String name = firebaseImageService.save(image, "stars");
            String imageUrl = firebaseImageService.getImageUrl(name);
            editStar.setImgName(name);
            editStar.setImgUrl(imageUrl);
        }

        starRepository.save(editStar);
    }

    public void deleteStar(Star star){
        for(var movie : star.getDirector_movies())
            movie.getDirectors().remove(star);

        for(var movie : star.getActor_movies())
            movie.getCast().remove(star);

        starRepository.delete(star);
    }

    public List<MovieDto> getMoviesByActor(Star actor, User user){
        return movieRepository.getByActor(actor, user);
    }

    public List<MovieDto> getMoviesByDirector(Star director, User user){
        return movieRepository.getByDirector(director, user);
    }

    public List<Map<String, String>> getBestMovies(Star star){
        List<Object[]> movies = movieRepository.bestMoviesByStar(star);
        List<Map<String, String>> result = new ArrayList<>();

        for(var item : movies){
            result.add(Map.of("id", item[0].toString(), "title", item[1].toString()));
        }

        return result;
    }
}

package com.example.cinema.component;

import com.example.cinema.admin.model.Category;
import com.example.cinema.admin.repository.MovieRepository;
import com.example.cinema.cinema.service.SeanceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.stream.Collectors;

@Component
public class LoadContentInterceptor implements HandlerInterceptor {
    @Autowired
    private SeanceService seanceService;

    @Autowired
    private MovieRepository movieRepository;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) {
        var movies_cinema = seanceService.findMovies(null)
                .stream().limit(10).collect(Collectors.toList());

        var coming = movieRepository.findComingSoon(Category.Movie)
                .stream().limit(10).collect(Collectors.toList());

        request.setAttribute("movies_cinema", movies_cinema);
        request.setAttribute("movies_coming", coming);
        return true;
    }
}

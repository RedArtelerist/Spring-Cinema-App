package com.example.cinema.main.service;

import com.example.cinema.account.model.User;
import com.example.cinema.admin.model.Category;
import com.example.cinema.admin.model.Genre;
import com.example.cinema.admin.model.Movie;
import com.example.cinema.main.dto.FilterItemDto;
import com.example.cinema.main.dto.RatingDto;
import com.example.cinema.main.model.Rating;
import com.example.cinema.main.repository.RatingRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import javax.persistence.EntityManager;
import java.util.*;
import java.util.stream.Collectors;

@Service
public class RatingService {
    @Autowired
    private RatingRepository ratingRepository;

    @Autowired
    EntityManager em;

    public Rating getById(Long id){
        Optional<Rating> ratingOptional = ratingRepository.findById(id);
        return ratingOptional.orElse(null);
    }

    public Rating getRating(User user, Long itemId){
        return ratingRepository.findByUserAndMovie(user, itemId);
    }

    public Page<RatingDto> getUserRatings(User owner, User user, int pageNum, Map<String, Object> params){
        Pageable pageable = PageRequest.of(pageNum - 1, 30);

        String sort = (String) params.get("sort");
        Integer from_year = (Integer) params.get("from_year");
        Integer to_year = (Integer) params.get("to_year");

        var filter = prepareData(params);
        var query = sortVotes(owner, user, sort,from_year, to_year);
        query = filterVotes(query, filter);

        final int start = (int)pageable.getOffset();
        final int end = Math.min((start + pageable.getPageSize()), query.size());

        return new PageImpl<>(query.subList(start, end), pageable, query.size());
    }

    public void setRating(User user, Movie movie, Integer value){
        var rating = getRating(user, movie.getId());

        if (rating == null) {
            rating = new Rating();
            rating.setMovie(movie);
            rating.setUser(user);
        }
        rating.setValue(value);
        rating.setUpdatedAt(new Date());

        ratingRepository.save(rating);
    }

    public void delete(Rating rating){
        if(rating != null)
            ratingRepository.delete(rating);
    }

    public List<Integer> getMinMaxYear(User user){
        Integer min = ratingRepository.getMinYear(user);
        Integer max = ratingRepository.getMaxYear(user);
        return Arrays.asList(min, max);
    }

    private List<RatingDto> sortVotes(User owner, User user, String sort, Integer from, Integer to){
        List<RatingDto> query;
        switch (sort) {
            case "rating" -> query = ratingRepository.userVotesSortByRating(owner, user, from, to);
            case "date-asc" -> query = ratingRepository.userVotesOrderByDateAsc(owner, user, from, to);
            case "score" -> query = ratingRepository.userVotesOrderByScore(owner, user, from, to);
            default -> query = ratingRepository.userVotes(owner, user, from, to);
        }
        return query;
    }

    private List<RatingDto> filterVotes(List<RatingDto> query, FilterItemDto filter){
        if(filter.getCategory() != null){
            Category category = filter.getCategory();
            query = query.stream().filter(
                    vote -> vote.getItem().getCategory().equals(category)
            ).collect(Collectors.toList());
        }

        if(filter.getGenre() != null){
            Genre genre = filter.getGenre();
            query = query.stream().filter(
                    movie -> movie.getItem().getGenres().contains(genre)
            ).collect(Collectors.toList());
        }

        return query;
    }


    private FilterItemDto prepareData(Map<String, Object> params){
        String categoryStr = (String) params.get("category");
        String genreStr = (String) params.get("genre");

        Category category;
        try {
            category = Category.valueOf(categoryStr);
        }
        catch (Exception ex){
            category = null;
        }
        Genre genre;
        try {
            genre = Genre.valueOf(genreStr);
        }
        catch (Exception ex){
            genre = null;
        }
        return new FilterItemDto(category, null, genre, null);
    }

}

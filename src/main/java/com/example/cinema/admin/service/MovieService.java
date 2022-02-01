package com.example.cinema.admin.service;

import com.example.cinema.account.model.User;
import com.example.cinema.admin.dto.AdminMovieDto;
import com.example.cinema.admin.model.*;
import com.example.cinema.admin.repository.ImageMovieRepository;
import com.example.cinema.admin.repository.MovieRepository;
import com.example.cinema.main.dto.FilterItemDto;
import com.example.cinema.main.dto.MovieDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.*;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.persistence.EntityManager;
import java.io.IOException;
import java.util.*;
import java.util.stream.Collectors;

@Service
public class MovieService {
    @Autowired
    private MovieRepository movieRepository;

    @Autowired
    private ImageMovieRepository imageMovieRepository;

    @Autowired
    private FirebaseImageService firebaseImageService;

    @Autowired CompanyService companyService;

    @Autowired
    private EntityManager em;

    public List<Movie> movieList(){
        return movieRepository.findAll(Sort.by(Sort.Direction.ASC, "title"));
    }

    public Page<AdminMovieDto> findItemsForAdmin(String sort, String search, int pageNum){
        Pageable pageable = PageRequest.of(pageNum, 20);

        var sorting = Sort.by(Sort.Direction.ASC, "title");

        if(sort.equals("title-asc"))
            sorting = Sort.by(Sort.Direction.ASC, "title");

        if(sort.equals("title-desc"))
            sorting = Sort.by(Sort.Direction.DESC, "title");

        if(sort.equals("status"))
            sorting = Sort.by(Sort.Direction.ASC, "status", "title");

        if(sort.equals("release-asc"))
            sorting = Sort.by(Sort.Direction.ASC, "release", "title");

        if(sort.equals("release-desc"))
            sorting = Sort.by(Sort.Direction.DESC, "release", "title");

        if(sort.equals("created"))
            sorting = Sort.by(Sort.Direction.DESC, "id");

        if(sort.equals("rating")) {
            return movieRepository.findMoviesForAdminOrderByRating(search, pageable);
        }

        pageable = PageRequest.of(pageNum,20, sorting);

        return movieRepository.findMoviesForAdmin(search, pageable);
    }

    public Page<MovieDto> findItems(User user, int pageNum, Map<String, Object> params){
        Pageable pageable = PageRequest.of(pageNum - 1, 10);

        String sort = (String) params.get("sort");
        Integer from_year = (Integer) params.get("from_year");
        Integer to_year = (Integer) params.get("to_year");

        var filter = prepareData(params);
        var query = sortItems(sort, user, from_year, to_year);
        query = filterItems(query, filter);

        final int start = (int)pageable.getOffset();
        final int end = Math.min((start + pageable.getPageSize()), query.size());

        return new PageImpl<>(query.subList(start, end), pageable, query.size());
    }

    public List<AdminMovieDto> findByCategory(Category category){
        return movieRepository.findMovieByCategory(category);
    }

    public Movie getById(Long id){
        Optional<Movie> movieOptional = movieRepository.findById(id);
        return movieOptional.orElse(null);
    }

    public MovieDto getById(Long id, User user){
        Optional<MovieDto> movieOptional = movieRepository.findMovie(id, user);

        return movieOptional.orElse(null);
    }

    public AdminMovieDto getByIdForAdmin(Long id){
        Optional<AdminMovieDto> movieOptional = movieRepository.findAdminMovie(id);

        return movieOptional.orElse(null);
    }

    public void createMovie(Movie movie, MultipartFile image, MultipartFile[] gallery) throws IOException {
        if(image != null && !image.getOriginalFilename().isEmpty()) {
            String name = firebaseImageService.save(image, "movies");
            String posterUrl = firebaseImageService.getImageUrl(name);
            movie.setPosterName(name);
            movie.setPosterUrl(posterUrl);
        }

        if(gallery.length > 0){
            setGallery(gallery, movie);
        }

        movieRepository.save(movie);
    }

    public void editMovie(Movie movie, Movie editMovie, MultipartFile image, MultipartFile[] gallery) throws IOException {
        editMovie.setTitle(movie.getTitle());
        editMovie.setDescription(movie.getDescription());
        editMovie.setCountries(movie.getCountries());
        editMovie.setYear(movie.getYear());
        editMovie.setBudget(movie.getBudget());
        editMovie.setBoxOffice(movie.getBoxOffice());
        editMovie.setRelease(movie.getRelease());
        editMovie.setTime(movie.getTime());
        editMovie.setTrailer(movie.getTrailer());
        editMovie.setCategory(movie.getCategory());
        editMovie.setMpaa(movie.getMpaa());
        editMovie.setCompanies(movie.getCompanies());
        editMovie.setDirectors(movie.getDirectors());
        editMovie.setCast(movie.getCast());
        editMovie.setGenres(movie.getGenres());
        editMovie.setStatus(movie.isStatus());

        if(image != null && !image.getOriginalFilename().isEmpty()) {
            if(editMovie.getPosterName() != null && !editMovie.getPosterName().isEmpty())
                firebaseImageService.delete(editMovie.getPosterName());

            String name = firebaseImageService.save(image, "movies");
            String imageUrl = firebaseImageService.getImageUrl(name);
            editMovie.setPosterName(name);
            editMovie.setPosterUrl(imageUrl);
        }

        if(gallery.length > 0){
            setGallery(gallery, editMovie);
        }

        movieRepository.save(editMovie);
    }

    public void deleteMovie(Movie movie) throws IOException {
        for(var company : movie.getCompanies())
            company.getMovies().remove(movie);

        for(var director : movie.getDirectors())
            director.getDirector_movies().remove(movie);

        for(var actor : movie.getCast())
            actor.getActor_movies().remove(movie);

        if(movie.getPosterName() != null)
            firebaseImageService.delete(movie.getPosterName());

        deleteGallery(movie);

        movieRepository.delete(movie);
    }

    private void setGallery(MultipartFile[] gallery, Movie movie) throws IOException {
        for(var item : gallery){
            if(item != null && !item.getOriginalFilename().isEmpty()) {
                ImageMovie img = new ImageMovie();
                String name = firebaseImageService.save(item, "movies");
                String url = firebaseImageService.getImageUrl(name);
                img.setImageName(name);
                img.setImageUrl(url);
                img.setMovie(movie);
                movie.getGallery().add(img);
            }
        }
    }

    public ImageMovie getImageById(Long id){
        Optional<ImageMovie> imageMovieOptional = imageMovieRepository.findById(id);
        return imageMovieOptional.orElse(null);
    }

    public void deleteImage(Movie movie, ImageMovie image) throws IOException {
        if(movie.getGallery().contains(image)) {
            firebaseImageService.delete(image.getImageName());
            movie.getGallery().remove(image);
            imageMovieRepository.delete(image);
        }
        movieRepository.save(movie);
    }

    public void deleteGallery(Movie movie) throws IOException {
        for(var image : movie.getGallery()) {
            firebaseImageService.delete(image.getImageName());
            imageMovieRepository.delete(image);
        }
    }

    public List<Company> getMostPopularCompanies(){
        var companies = movieRepository.getPopularCompanies();
        return companies.stream().filter(company -> company.getMovies().size() > 0).collect(Collectors.toList());
    }

    public List<Integer> getMinMaxMovieYear(){
        Integer minYear = movieRepository.getMinYear();
        Integer maxYear = movieRepository.getMaxYear();
        return Arrays.asList(minYear, maxYear);
    }

    public List<Country> getCountries(){
        return movieRepository.getCountries();
    }

    private List<MovieDto> sortItems(String sort, User user, Integer from_year, Integer to_year){
        List<MovieDto> query;
        switch (sort) {
            case "rating" -> query = movieRepository.findMoviesOrderByRating(user, from_year, to_year);
            case "release" -> query = movieRepository.findMoviesOrderByRelease(user, from_year, to_year);
            case "popularity" -> {
                query = movieRepository.findMovies(user, from_year, to_year);
                query = query.stream()
                        .sorted(Comparator.comparing(MovieDto::getNumVotes).reversed()
                                .thenComparing(MovieDto::getTitle))
                        .collect(Collectors.toList());
            }
            case "comments" -> {
                query = movieRepository.findMovies(user, from_year, to_year);
                query = query.stream()
                        .sorted(Comparator.comparing(MovieDto::getNumComments).reversed()
                                .thenComparing(MovieDto::getTitle))
                        .collect(Collectors.toList());
            }
            case "coming" -> query = movieRepository.findMoviesOrderByComing(user, from_year, to_year);
            default -> query = movieRepository.findMovies(user, from_year, to_year);
        }
        return query;
    }

    private List<MovieDto> filterItems(List<MovieDto> query, FilterItemDto filter){
        if(filter.getCategory() != null){
            Category category = filter.getCategory();
            query = query.stream().filter(
                    item -> item.getCategory().equals(category)
            ).collect(Collectors.toList());
        }

        if(filter.getCompany() != null) {
            Company company = filter.getCompany();
            query = query.stream().filter(
                    movie -> movie.getCompanies().contains(company)
            ).collect(Collectors.toList());
        }
        if(filter.getGenre() != null){
            Genre genre = filter.getGenre();
            query = query.stream().filter(
                    movie -> movie.getGenres().contains(genre)
            ).collect(Collectors.toList());
        }
        if(filter.getCountry() != null){
            Country country = filter.getCountry();
            query = query.stream().filter(
                    movie -> movie.getCountries().contains(country)
            ).collect(Collectors.toList());
        }
        return query;
    }

    private FilterItemDto prepareData(Map<String, Object> params){
        String categoryStr = (String) params.get("category");
        Long companyId = (Long) params.get("company");
        String genreStr = (String) params.get("genre");
        String countryStr = (String) params.get("country");

        Category category;
        try {
            category = Category.valueOf(categoryStr);
        }
        catch (Exception ex){
            category = null;
        }
        Company company = null;
        if(companyId != null) {
            company = companyService.getCompanyById(companyId);
        }
        Genre genre;
        try {
            genre = Genre.valueOf(genreStr);
        }
        catch (Exception ex){
            genre = null;
        }
        Country country;
        try {
            country = Country.valueOf(countryStr);
        }
        catch (Exception ex){
            country = null;
        }
        return new FilterItemDto(category, company, genre, country);
    }
}

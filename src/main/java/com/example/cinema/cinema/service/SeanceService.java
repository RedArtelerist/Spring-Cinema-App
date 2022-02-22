package com.example.cinema.cinema.service;

import com.example.cinema.account.model.User;
import com.example.cinema.admin.dto.AdminMovieDto;
import com.example.cinema.admin.model.Movie;
import com.example.cinema.admin.service.MovieService;
import com.example.cinema.cinema.dto.MovieSeanceDto;
import com.example.cinema.cinema.model.Cinema;
import com.example.cinema.cinema.model.City;
import com.example.cinema.cinema.model.Seance;
import com.example.cinema.cinema.repository.SeanceRepository;
import com.example.cinema.main.dto.MovieDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import javax.persistence.EntityManager;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.stream.Collectors;

@Service
public class SeanceService {
    @Autowired
    private SeanceRepository seanceRepository;

    @Autowired
    private MovieService movieService;

    public List<Seance> seanceList(Cinema cinema){
        return seanceRepository.findByCinema(cinema);
    }

    public Page<Seance> findSeancesByCinema(Cinema cinema, String sort, String dateStr,
                                            AdminMovieDto movie, int pageNum){
        Sort sorting = Sort.by(Sort.Direction.ASC, "date", "startTime");
        if(sort.equals("status"))
            sorting = Sort.by(Sort.Order.desc("available"), Sort.Order.asc("date"), Sort.Order.asc("startTime"));

        Pageable pageable = PageRequest.of(pageNum, 30, sorting);

        SimpleDateFormat formatter = new SimpleDateFormat("dd.MM.yyyy");
        Date date;
        try {
            date = formatter.parse(dateStr);
        }
        catch (Exception ex){
            date = null;
        }

        if(movie != null && date != null)
            return seanceRepository.seancesByCinemaAndDateAndMovie(cinema, movie.getId(), date, pageable);

        if(movie != null)
            return seanceRepository.seancesByCinemaAndMovie(cinema, movie.getId(), pageable);

        if(date != null)
            return seanceRepository.seancesByCinemaAndDate(cinema, date, pageable);

        return seanceRepository.seancesByCinema(cinema, pageable);
    }

    public List<MovieSeanceDto> findSeancesByCinemaAndDate(Cinema cinema, Date date, User user){
        var seances = seanceRepository.findByCinemaAndDate(cinema, date);
        var movieSeances = seances.stream().collect(Collectors.groupingBy(Seance::getMovie));

        List<Movie> keys = movieSeances.keySet().stream().sorted(
                Comparator.comparing(Movie::getTitle)).collect(Collectors.toList()
        );
        List<MovieSeanceDto> result = new ArrayList<>();

        for(var movie : keys){
            var movieDto = movieService.getById(movie.getId(), user);
            result.add(new MovieSeanceDto(movieDto, movieSeances.get(movie)));
        }
        return result;
    }

    public Map<Cinema, List<Seance>> findSeancesByMovie(Long movieId, City city, Date date){
        var seances = seanceRepository.findByMovieAndCityAndDate(movieId, city, date);
        return seances.stream().collect(Collectors.groupingBy(c -> c.getHall().getCinema()));
    }

    public List<MovieDto> findMovies(User user){
        var ids = seanceRepository.getMovies();
        ids = ids.stream().distinct().collect(Collectors.toList());
        List<MovieDto> movieDtoList = new ArrayList<>();

        for(var id : ids)
            movieDtoList.add(movieService.getById(id, user));

        return movieDtoList;
    }

    public List<MovieDto> findTopMovies(User user){
        var ids = seanceRepository.getMovies();
        ids = ids.stream().distinct().collect(Collectors.toList());
        List<MovieDto> movieDtoList = new ArrayList<>();

        for(var id : ids)
            movieDtoList.add(movieService.getById(id, user));

        return movieDtoList.stream().sorted(
                Comparator.comparing(MovieDto::getRating, Comparator.nullsFirst(Comparator.naturalOrder())).reversed()
        ).limit(6).collect(Collectors.toList());
    }

    public Seance getById(Long id){
        Optional<Seance> optionalSeance = seanceRepository.findById(id);
        return optionalSeance.orElse(null);
    }

    public Seance findById(Long id){
        Optional<Seance> optionalSeance = seanceRepository.findAvailableById(id);
        return optionalSeance.orElse(null);
    }

    public void createSeance(Seance seance) throws Exception {
        if(seance.getStartTime().after(seance.getEndTime()))
            throw new Exception("Start time must be early then end time");

        if(!checkIfValidDate(seance))
            throw new Exception("Date and start time early then current time");

        if(!checkDuration(seance))
            throw new Exception("Duration must be between 1 and 4 hours");

        var seances = seanceRepository.findSeancesInInterval(
                seance.getHall(), seance.getDate(), seance.getStartTime(), seance.getEndTime()
        );

        if(seances.size() > 0)
            throw new Exception("Incorrect start and end time, there are other seances at that time");

        seanceRepository.save(seance);
    }

    public void updateSeance(Seance editSeance, Seance seance) throws Exception {
        if(seance.getStartTime().after(seance.getEndTime()))
            throw new Exception("Start time must be early then end time");

        if(!checkIfValidDate(seance))
            throw new Exception("Date and start time early then current time");

        if(!checkDuration(seance))
            throw new Exception("Duration must be between 1 and 4 hours");

        var seances = seanceRepository.findSeancesInInterval(
                seance.getHall(), seance.getDate(), seance.getStartTime(), seance.getEndTime()
        );

        if(seances.size() > 0 && !seances.contains(editSeance))
            throw new Exception("Incorrect start and end time, there are other seances at that time");

        editSeance.setMovie(seance.getMovie());
        editSeance.setHall(seance.getHall());
        editSeance.setDate(seance.getDate());
        editSeance.setStartTime(seance.getStartTime());
        editSeance.setEndTime(seance.getEndTime());
        editSeance.setPrice(seance.getPrice());
        editSeance.setTechnologies(seance.getTechnologies());
        editSeance.setAvailable(seance.isAvailable());

        seanceRepository.save(editSeance);
    }

    public void deleteSeance(Seance seance){
        seanceRepository.delete(seance);
    }

    public List<Date> getDates(Cinema cinema){
        return seanceRepository.getDatesByCinema(cinema);
    }

    public List<Date> getCinemaSeancesDates(Cinema cinema){
        return seanceRepository.getDatesByCinema(cinema, true);
    }

    public List<Date> getDatesByMovie(Long movieId, City city){
        return seanceRepository.getDatesByMovie(movieId, city);
    }

    public List<City> getCitiesByMovie(Long movieId){
        return seanceRepository.getCitiesByMovie(movieId);
    }

    public List<AdminMovieDto> getMoviesForAdmin(Cinema cinema){
        return seanceRepository.getAdminMoviesByCinema(cinema);
    }

    private boolean checkIfValidDate(Seance seance){
        Date now = new Date();
        Date date = combineDateTime(seance.getDate(), seance.getStartTime());

        return !now.after(date);
    }

    private boolean checkDuration(Seance seance){
        long diff = seance.getEndTime().getTime() - seance.getStartTime().getTime();
        long diffMinutes = diff / (60 * 1000);

        return diffMinutes >= 60 && diffMinutes <= 240;
    }

    private Date combineDateTime(Date date, Date time) {
        Calendar calendarA = Calendar.getInstance();
        calendarA.setTime(date);
        Calendar calendarB = Calendar.getInstance();
        calendarB.setTime(time);

        calendarA.set(Calendar.HOUR_OF_DAY, calendarB.get(Calendar.HOUR_OF_DAY));
        calendarA.set(Calendar.MINUTE, calendarB.get(Calendar.MINUTE));
        calendarA.set(Calendar.SECOND, calendarB.get(Calendar.SECOND));
        calendarA.set(Calendar.MILLISECOND, calendarB.get(Calendar.MILLISECOND));

        return calendarA.getTime();
    }
}

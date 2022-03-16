package com.example.cinema.cinema.repository;

import com.example.cinema.admin.dto.AdminMovieDto;
import com.example.cinema.admin.model.Movie;
import com.example.cinema.cinema.model.Cinema;
import com.example.cinema.cinema.model.City;
import com.example.cinema.cinema.model.Hall;
import com.example.cinema.cinema.model.Seance;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.Date;
import java.util.List;
import java.util.Optional;

@Repository
public interface SeanceRepository extends JpaRepository<Seance, Long> {
    @Query("select s from Seance s where s.available = true and s.id = :id")
    Optional<Seance> findAvailableById(@Param("id") Long id);

    @Query("select s from Seance s where s.hall.cinema = :cinema")
    List<Seance> findByCinema(Cinema cinema);

    @Query("select s from Seance s where s.hall.cinema = :cinema")
    Page<Seance> seancesByCinema(@Param("cinema") Cinema cinema, Pageable pageable);

    @Query("select s from Seance s where s.hall.cinema = :cinema and s.movie.id = :movie and s.date = :date")
    Page<Seance> seancesByCinemaAndDateAndMovie(
            @Param("cinema") Cinema cinema, @Param("movie") Long movieId,
            @Param("date") Date date, Pageable pageable
    );

    @Query("select s from Seance s where s.hall.cinema = :cinema and s.date = :date")
    Page<Seance> seancesByCinemaAndDate(
            @Param("cinema") Cinema cinema, @Param("date") Date date, Pageable pageable
    );

    @Query("select s from Seance s where s.hall.cinema = :cinema and s.movie.id = :movie")
    Page<Seance> seancesByCinemaAndMovie(
            @Param("cinema") Cinema cinema, @Param("movie") Long movieId, Pageable pageable
    );

    @Query("select s from Seance s where s.hall = :hall and s.date = :date and " +
            "(:time1 between s.startTime and s.endTime or :time2 between s.startTime and s.endTime)")
    List<Seance> findSeancesInInterval(
            @Param("hall") Hall hall, @Param("date") Date date,
            @Param("time1") Date time1, @Param("time2") Date time2
    );

    @Query("select s from Seance s where s.date < :date or (s.date = :date and s.startTime <= :time) and s.available = true")
    List<Seance> findExpiredSeances(@Param("date") Date date, @Param("time") Date time);

    @Query("select s from Seance s where s.date < :date or (s.date = :date and s.endTime <= :time)")
    List<Seance> findEndedSeances(@Param("date") Date date,  @Param("time") Date time);

    @Query("select distinct s.date from Seance s where s.hall.cinema = :cinema order by s.date")
    List<Date> getDatesByCinema(@Param("cinema") Cinema cinema);

    @Query("select distinct s.date from Seance s where s.hall.cinema = :cinema and s.available = :status order by s.date")
    List<Date> getDatesByCinema(@Param("cinema") Cinema cinema, @Param("status") Boolean status);

    @Query("select distinct s.date from Seance s where s.movie.id = :movieId and " +
            "s.available = true and s.hall.cinema.city = :city")
    List<Date> getDatesByMovie(@Param("movieId") Long movieId, @Param("city") City city);

    @Query("select distinct s.hall.cinema.city from Seance s where s.movie.id = :movieId and s.available = true")
    List<City> getCitiesByMovie(@Param("movieId") Long movieId);

    @Query("select distinct new com.example.cinema.admin.dto.AdminMovieDto(" +
            "   s.movie," +
            "   avg(r.value)" +
            ") " +
            "from Seance s left join s.movie.ratings r " +
            "where s.hall.cinema = :cinema group by s.movie ")
    List<AdminMovieDto> getAdminMoviesByCinema(@Param("cinema") Cinema cinema);

    @Query("select s from Seance s where s.hall.cinema = :cinema and s.date = :date order by s.startTime")
    List<Seance> findByCinemaAndDate(@Param("cinema") Cinema cinema, @Param("date") Date date);

    @Query("select s from Seance s where s.hall.cinema = :cinema " +
            "and s.movie.id = :movieId and s.date = :date order by s.startTime")
    List<Seance> findByCinemaAndDateAndMovie(
            @Param("cinema") Cinema cinema, @Param("movieId") Long movieId, @Param("date") Date date
    );

    @Query("select s from Seance s where s.movie.id = :movieId and " +
            "s.hall.cinema.city = :city and s.date = :date " +
            "and s.available = true order by s.startTime")
    List<Seance> findByMovieAndCityAndDate(
            @Param("movieId") Long movieId, @Param("city") City city, @Param("date") Date date
    );

    @Query("select s.movie.id from Seance s where s.available = true order by s.date, s.startTime")
    List<Long> getMovies();
}

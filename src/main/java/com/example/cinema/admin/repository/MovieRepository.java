package com.example.cinema.admin.repository;

import com.example.cinema.account.model.User;
import com.example.cinema.admin.dto.AdminMovieDto;
import com.example.cinema.admin.model.*;
import com.example.cinema.main.dto.MovieDto;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;
import java.util.Optional;

@Repository
public interface MovieRepository extends JpaRepository<Movie, Long> {
    @Query("select new com.example.cinema.admin.dto.AdminMovieDto(" +
            "   m," +
            "   avg(r.value)" +
            ") " +
            "from Movie m left join m.ratings r " +
            "where lower(m.title) LIKE %?1% " +
            "group by m")
    Page<AdminMovieDto> findMoviesForAdmin(String search, Pageable pageable);

    @Query("select new com.example.cinema.admin.dto.AdminMovieDto(" +
            "   m," +
            "   avg(r.value)" +
            ") " +
            "from Movie m left join m.ratings r " +
            "where lower(m.title) LIKE %?1% " +
            "and m.release <= CURRENT_DATE " +
            "group by m " +
            "order by avg(r.value) desc ")
    Page<AdminMovieDto> findMoviesForAdminOrderByRating(String search, Pageable pageable);

    @Query("select new com.example.cinema.main.dto.MovieDto(" +
            "   m," +
            "   avg(r.value), " +
            "   sum(case when r.user = :user then r.value else 0 end), " +
            "   sum(case when w.user = :user then 1 else 0 end) > 0 " +
            ") " +
            "from Movie m left join m.ratings r " +
            "left join m.watchList w " +
            "where m.id = :id " +
            "group by m")
    Optional<MovieDto> findMovie(@Param("id") Long id, @Param("user") User user);

    @Query("select new com.example.cinema.main.dto.MovieDto(" +
            "   m," +
            "   avg(r.value), " +
            "   sum(case when r.user = :user then r.value else 0 end), " +
            "   sum(case when w.user = :user then 1 else 0 end) > 0 " +
            ") " +
            "from Movie m left join m.ratings r " +
            "left join m.watchList w " +
            "where m.year >= :from and m.year <= :to " +
            "group by m " +
            "order by m.title asc")
    List<MovieDto> findMovies(@Param("user") User user, @Param("from") Integer from, @Param("to") Integer to);

    @Query("select new com.example.cinema.main.dto.MovieDto(" +
            "   m," +
            "   avg(r.value), " +
            "   sum(case when r.user = :user then r.value else 0 end), " +
            "   sum(case when w.user = :user then 1 else 0 end) > 0 " +
            ") " +
            "from Movie m left join m.ratings r " +
            "left join m.watchList w " +
            "where m.year >= :from and m.year <= :to " +
            "and m.release <= CURRENT_DATE " +
            "group by m " +
            "order by coalesce(avg(r.value), 0) desc, m.title asc")
    List<MovieDto> findMoviesOrderByRating(@Param("user") User user, @Param("from") Integer from, @Param("to") Integer to);


    @Query("select new com.example.cinema.main.dto.MovieDto(" +
            "   m," +
            "   avg(r.value), " +
            "   sum(case when r.user = :user then r.value else 0 end), " +
            "   sum(case when w.user = :user then 1 else 0 end) > 0 " +
            ") " +
            "from Movie m left join m.ratings r " +
            "left join m.watchList w " +
            "where m.year >= :from and m.year <= :to " +
            "and m.release <= CURRENT_DATE " +
            "group by m " +
            "order by m.release desc, m.title asc ")
    List<MovieDto> findMoviesOrderByRelease(@Param("user") User user, @Param("from") Integer from, @Param("to") Integer to);

    @Query("select new com.example.cinema.main.dto.MovieDto(" +
            "   m," +
            "   avg(r.value), " +
            "   sum(case when r.user = :user then r.value else 0 end), " +
            "   sum(case when w.user = :user then 1 else 0 end) > 0 " +
            ") " +
            "from Movie m left join m.ratings r " +
            "left join m.watchList w " +
            "where m.year >= :from and m.year <= :to " +
            "and m.release > CURRENT_DATE " +
            "group by m " +
            "order by m.release asc, m.title asc ")
    List<MovieDto> findMoviesOrderByComing(@Param("user") User user, @Param("from") Integer from, @Param("to") Integer to);

    @Query("select c from Company c left join c.movies movies " +
            "group by c order by count(movies) desc, c.name asc")
    List<Company> getPopularCompanies();

    @Query("select distinct c from Movie m left join m.countries c order by c")
    List<Country> getCountries();

    @Query("select min(m.year) from Movie m")
    Integer getMinYear();

    @Query("select max(m.year) from Movie m")
    Integer getMaxYear();

    @Query("select new com.example.cinema.main.dto.MovieDto(" +
            "   m," +
            "   avg(r.value), " +
            "   sum(case when r.user = :user then r.value else 0 end), " +
            "   sum(case when w.user = :user then 1 else 0 end) > 0 " +
            ") " +
            "from Movie m left join m.ratings r " +
            "left join m.watchList w left join m.cast cast " +
            "where :actor in (cast) " +
            "group by m order by m.release desc "
    )
    List<MovieDto> getByActor(@Param("actor") Star actor, @Param("user") User user);

    @Query("select new com.example.cinema.main.dto.MovieDto(" +
            "   m," +
            "   avg(r.value), " +
            "   sum(case when r.user = :user then r.value else 0 end), " +
            "   sum(case when w.user = :user then 1 else 0 end) > 0 " +
            ") " +
            "from Movie m left join m.ratings r " +
            "left join m.watchList w left join m.directors dirs " +
            "where :director in (dirs) " +
            "group by m order by m.release desc "
    )
    List<MovieDto> getByDirector(@Param("director") Star director, @Param("user") User user);

    @Query("select m.id, m.title from Movie m left join m.ratings r " +
            "left join m.cast cast left join m.directors dirs " +
            "where :star in (cast) or :star in (dirs) group by m " +
            "order by avg(r.value) desc")
    List<Object[]> bestMoviesByStar(@Param("star") Star star);
}

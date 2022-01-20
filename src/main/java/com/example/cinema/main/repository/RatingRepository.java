package com.example.cinema.main.repository;

import com.example.cinema.account.model.User;
import com.example.cinema.main.dto.RatingDto;
import com.example.cinema.main.model.Rating;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface RatingRepository extends JpaRepository<Rating, Long> {
    @Query("select r from Rating r where r.user = :user and r.movie.id = :itemId")
    Rating findByUserAndMovie(@Param("user") User user, @Param("itemId") Long itemId);

    @Query("select new com.example.cinema.main.dto.RatingDto(" +
            "   rate," +
            "   avg(r.value), " +
            "   sum(case when r.user = :user then r.value else 0 end), " +
            "   sum(case when w.user = :user then 1 else 0 end) > 0 " +
            ") " +
            "from Rating rate left join rate.movie.ratings r " +
            "left join rate.movie.watchList w " +
            "where rate.user = :owner and rate.movie.year >= :from and rate.movie.year <= :to " +
            "group by rate " +
            "order by rate.updatedAt desc")
    List<RatingDto> userVotes(@Param("owner") User owner, @Param("user") User user,
                              @Param("from") Integer from, @Param("to") Integer to
    );

    @Query("select new com.example.cinema.main.dto.RatingDto(" +
            "   rate," +
            "   avg(r.value), " +
            "   sum(case when r.user = :user then r.value else 0 end), " +
            "   sum(case when w.user = :user then 1 else 0 end) > 0 " +
            ") " +
            "from Rating rate left join rate.movie.ratings r " +
            "left join rate.movie.watchList w " +
            "where rate.user = :owner and rate.movie.year >= :from and rate.movie.year <= :to " +
            "group by rate " +
            "order by rate.updatedAt asc ")
    List<RatingDto> userVotesOrderByDateAsc(@Param("owner") User owner, @Param("user") User user,
                              @Param("from") Integer from, @Param("to") Integer to
    );

    @Query("select new com.example.cinema.main.dto.RatingDto(" +
            "   rate," +
            "   avg(r.value), " +
            "   sum(case when r.user = :user then r.value else 0 end), " +
            "   sum(case when w.user = :user then 1 else 0 end) > 0 " +
            ") " +
            "from Rating rate left join rate.movie.ratings r " +
            "left join rate.movie.watchList w " +
            "where rate.user = :owner and rate.movie.year >= :from and rate.movie.year <= :to " +
            "group by rate " +
            "order by coalesce(avg(r.value), 0) desc")
    List<RatingDto> userVotesSortByRating(@Param("owner") User owner, @Param("user") User user,
                                          @Param("from") Integer from, @Param("to") Integer to
    );

    @Query("select new com.example.cinema.main.dto.RatingDto(" +
            "   rate," +
            "   avg(r.value), " +
            "   sum(case when r.user = :user then r.value else 0 end), " +
            "   sum(case when w.user = :user then 1 else 0 end) > 0 " +
            ") " +
            "from Rating rate left join rate.movie.ratings r " +
            "left join rate.movie.watchList w " +
            "where rate.user = :owner and rate.movie.year >= :from and rate.movie.year <= :to " +
            "group by rate " +
            "order by rate.value desc, rate.updatedAt desc")
    List<RatingDto> userVotesOrderByScore(@Param("owner") User owner, @Param("user") User user,
                                          @Param("from") Integer from, @Param("to") Integer to
    );

    @Query("select min(r.movie.year) from Rating r where r.user = :user")
    Integer getMinYear(@Param("user") User user);

    @Query("select max(r.movie.year) from Rating r where r.user = :user")
    Integer getMaxYear(@Param("user") User user);
}

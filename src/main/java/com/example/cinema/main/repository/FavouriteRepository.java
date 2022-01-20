package com.example.cinema.main.repository;

import com.example.cinema.account.model.User;
import com.example.cinema.main.dto.FavouriteDto;
import com.example.cinema.main.model.Favourite;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface FavouriteRepository extends JpaRepository<Favourite, Long> {
    @Query("select f from Favourite f where f.user = :user and f.movie.id = :itemId")
    Favourite findByUserAndMovie(@Param("user") User user, @Param("itemId") Long itemId);

    @Query("select new com.example.cinema.main.dto.FavouriteDto(" +
            "   fav," +
            "   avg(r.value), " +
            "   sum(case when r.user = :user then r.value else 0 end), " +
            "   sum(case when r.user = :me then r.value else 0 end), " +
            "   sum(case when w.user = :me then 1 else 0 end) > 0 " +
            ") " +
            "from Favourite fav left join fav.movie.ratings r " +
            "left join fav.movie.watchList w " +
            "where fav.user = :user " +
            "group by fav order by fav.createdAt desc ")
    List<FavouriteDto> findByUser(@Param("user") User user, @Param("me") User me);
}

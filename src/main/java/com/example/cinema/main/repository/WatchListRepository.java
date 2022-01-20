package com.example.cinema.main.repository;

import com.example.cinema.account.model.User;
import com.example.cinema.admin.model.Movie;
import com.example.cinema.main.dto.WatchListDto;
import com.example.cinema.main.model.Rating;
import com.example.cinema.main.model.WatchList;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface WatchListRepository extends JpaRepository<WatchList, Long> {
    @Query("select w from WatchList w where w.user = :user and w.movie.id = :itemId")
    WatchList findByUserAndMovie(@Param("user") User user, @Param("itemId") Long itemId);

    @Query("select new com.example.cinema.main.dto.WatchListDto(" +
            "   wlist," +
            "   avg(r.value), " +
            "   sum(case when r.user = :user then r.value else 0 end), " +
            "   sum(case when r.user = :me then r.value else 0 end), " +
            "   sum(case when w.user = :me then 1 else 0 end) > 0 " +
            ") " +
            "from WatchList wlist left join wlist.movie.ratings r " +
            "left join wlist.movie.watchList w " +
            "where wlist.user = :user " +
            "group by wlist order by wlist.createdAt desc ")
    List<WatchListDto> findByUser(@Param("user") User user, @Param("me") User me);
}

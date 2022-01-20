package com.example.cinema.main.repository;

import com.example.cinema.account.model.User;
import com.example.cinema.main.model.Comment;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CommentRepository extends JpaRepository<Comment, Long> {
    Page<Comment> findAll(Pageable pageable);

    @Query("select c from Comment c left join c.likes cl " +
            "group by c order by count(cl) desc, c.createdAt desc")
    Page<Comment> findAllOrderByRating(Pageable pageable);

    @Query("SELECT c FROM Comment c WHERE lower(c.user.firstName) LIKE %?1%"
            + " OR lower(c.user.lastName) LIKE %?1%"
            + " OR lower(c.user.username) LIKE %?1%"
            + " OR lower(c.text) LIKE %?1%"
    )
    Page<Comment> search(String search, Pageable pageable);

    @Query("select c from Comment c left join c.likes cl " +
            "WHERE lower(c.user.firstName) LIKE %?1%" +
            "OR lower(c.user.lastName) LIKE %?1%" +
            "OR lower(c.user.username) LIKE %?1%" +
            "OR lower(c.text) LIKE %?1% " +
            "group by c order by count(cl) desc, c.createdAt desc")
    Page<Comment> searchOrderByRating(String search, Pageable pageable);

    Page<Comment> findByUser(User user, Pageable pageable);

    List<Comment> findByParent(Comment parent);

    @Query("select c from Comment as c where c.movie.id = :movieId and c.parent is null order by c.createdAt desc")
    List<Comment> movieComments(@Param("movieId") Long movieId);
}

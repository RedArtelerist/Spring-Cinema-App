package com.example.cinema.main.service;

import com.example.cinema.account.model.User;
import com.example.cinema.main.model.Comment;
import com.example.cinema.main.repository.CommentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class CommentService {
    @Autowired
    private CommentRepository commentRepository;

    public List<Comment> commentList(){
        return commentRepository.findAll(Sort.by(Sort.Direction.DESC, "createdAt"));
    }

    public Page<Comment> findAll(String sort, String search, int pageNum){
        var sorting = Sort.by(Sort.Direction.DESC, "createdAt");

        if(sort.equals("date-asc"))
            sorting = Sort.by(Sort.Direction.ASC, "createdAt");

        if(sort.equals("rating")){
            Pageable pageable = PageRequest.of(pageNum, 20);
            if(search != null && !search.equals("")){
                return commentRepository.searchOrderByRating(search.toLowerCase(), pageable);
            } else
                return commentRepository.findAllOrderByRating(pageable);
        }

        Pageable pageable = PageRequest.of(pageNum,20, sorting);

        if(search != null && !search.equals(""))
            return commentRepository.search(search.toLowerCase(), pageable);

        return commentRepository.findAll(pageable);
    }

    public Page<Comment> userAdminComments(User user, int pageNum){
        var sorting = Sort.by(Sort.Direction.DESC, "createdAt");

        Pageable pageable = PageRequest.of(pageNum,20, sorting);

        return commentRepository.findByUser(user, pageable);
    }

    public Page<Comment> userComments(User user, String sort, int pageNum){
        var sorting = Sort.by(Sort.Direction.DESC, "createdAt");
        if(sort.equals("date-asc"))
            sorting = Sort.by(Sort.Direction.ASC, "createdAt");

        Pageable pageable = PageRequest.of(pageNum - 1,20, sorting);

        return commentRepository.findByUser(user, pageable);
    }

    public List<Comment> movieComments(Long movieId){
        return commentRepository.movieComments(movieId);
    }

    public Comment getById(Long id){
        Optional<Comment> commentOptional = commentRepository.findById(id);
        return commentOptional.orElse(null);
    }

    public void addComment(Comment comment){
        commentRepository.save(comment);
    }

    public void deleteComment(Comment comment){
        commentRepository.delete(comment);
    }
}

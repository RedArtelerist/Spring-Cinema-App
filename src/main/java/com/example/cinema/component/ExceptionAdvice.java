package com.example.cinema.component;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.multipart.MaxUploadSizeExceededException;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.logging.Level;
import java.util.logging.Logger;

@ControllerAdvice
public class ExceptionAdvice {

    @ExceptionHandler(MaxUploadSizeExceededException.class)
    public ModelAndView handleMaxSizeException(
            MaxUploadSizeExceededException exc,
            HttpServletRequest httpRequest,
            HttpServletResponse response) {

        ModelAndView modelAndView = new ModelAndView("error/404");
        modelAndView.getModel().put("messageType", "danger");
        modelAndView.getModel().put("message", "File too large! File must be less 5 mb");
        return modelAndView;
    }

    @ExceptionHandler(RuntimeException.class)
    public ModelAndView handleNotFound(HttpServletRequest request, Exception e)   {
        Logger.getLogger(getClass().getName()).log(Level.SEVERE, "Request: " + request.getRequestURL() + " raised " + e);
        return new ModelAndView("error/404");
    }
}
package com.example.cinema.component.interceptor;

import com.example.cinema.account.model.User;
import com.example.cinema.account.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Component
public class VerifyAccessInterceptor implements HandlerInterceptor {
    @Autowired
    private UserService userService;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        try {
            User userFromDatabase = userService.loadUserByUsername(auth.getName());

            Authentication newAuth = null;

            if (auth.getClass() == UsernamePasswordAuthenticationToken.class) {
                var authorities = userFromDatabase.getAuthorities();
                var principal = auth.getPrincipal();
                if (principal != null) {
                    newAuth = new UsernamePasswordAuthenticationToken(userFromDatabase, auth.getCredentials(), authorities);
                }
            }

            SecurityContextHolder.getContext().setAuthentication(newAuth);
            return true;
        }
        catch (Exception ex){
            return true;
        }
    }

}

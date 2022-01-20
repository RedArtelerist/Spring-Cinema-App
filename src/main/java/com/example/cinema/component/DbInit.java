package com.example.cinema.component;

import com.example.cinema.account.model.Role;
import com.example.cinema.account.model.User;
import com.example.cinema.account.repository.UserRepository;
import com.example.cinema.account.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;
import java.util.Arrays;
import java.util.HashSet;

@Component
public class DbInit {
    @Autowired
    private UserService userService;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @PostConstruct
    private void initializeOwner() {
        try {
            userService.findUserByEmail("fedorenko.max02@gmail.com");
            userService.loadUserByUsername("RedHost");
        }
        catch (Exception ex){
            User owner = new User();
            owner.setUsername("RedHost");
            owner.setEmail("fedorenko.max02@gmail.com");
            owner.setFirstName("Maksym");
            owner.setLastName("Fedorenko");
            owner.setActive(true);
            owner.setLocked(false);
            owner.setPassword(passwordEncoder.encode("MSms611001msMS"));
            owner.setRoles(new HashSet<>(Arrays.asList(Role.OWNER, Role.ADMIN, Role.USER)));
            userRepository.save(owner);
        }
    }
}

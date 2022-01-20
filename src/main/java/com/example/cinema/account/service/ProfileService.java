package com.example.cinema.account.service;

import com.example.cinema.account.dto.ProfileDto;
import com.example.cinema.account.model.ConfirmationToken;
import com.example.cinema.account.model.User;
import com.example.cinema.account.repository.UserRepository;
import com.example.cinema.admin.service.FirebaseImageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

@Service
public class ProfileService {
    @Autowired
    private UserService userService;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private ConfirmationTokenService confirmationTokenService;

    @Autowired
    private FirebaseImageService firebaseImageService;

    @Autowired
    private PasswordEncoder passwordEncoder;

    public void updateProfile(User user, ProfileDto profile, MultipartFile image) throws Exception {
        userService.checkIfExists(user, profile.getUsername(), profile.getEmail());

        if(!user.getUsername().equals(profile.getUsername())){
            userService.expireUserSessions(user);
            user.setUsername(profile.getUsername());
        }

        if(!user.getEmail().equals(profile.getEmail())) {
            userService.expireUserSessions(user);
            user.setEmail(profile.getEmail());
            user.setActive(false);

            ConfirmationToken confirmationToken = new ConfirmationToken(user);
            confirmationTokenService.saveConfirmationToken(confirmationToken);
            userService.sendMessage(user, confirmationToken.getConfirmationToken(), "confirm");
        }

        user.setFirstName(profile.getFirstName());
        user.setLastName(profile.getLastName());
        user.setBirthDay(profile.getBirthDay());
        user.setGender(profile.getGender());

        if(image != null && !image.getOriginalFilename().isEmpty()) {
            if(user.getImageName() != null && !user.getImageName().isEmpty())
                firebaseImageService.delete(user.getImageName());

            String name = firebaseImageService.save(image, "users");
            String imageUrl = firebaseImageService.getImageUrl(name);
            user.setImageName(name);
            user.setImgUrl(imageUrl);
        }

        userRepository.save(user);
    }

    public void changePassword(User user, String password){
        user.setPassword(passwordEncoder.encode(password));
        userRepository.save(user);
    }

    public void subscribe(User currentUser, User user) {
        user.getSubscribers().add(currentUser);

        userRepository.save(user);
    }

    public void unsubscribe(User currentUser, User user) {
        user.getSubscribers().remove(currentUser);

        userRepository.save(user);
    }
}

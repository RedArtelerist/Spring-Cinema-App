package com.example.cinema.account.service;

import com.example.cinema.account.model.ConfirmationToken;
import com.example.cinema.account.model.PasswordResetToken;
import com.example.cinema.account.model.Role;
import com.example.cinema.account.model.User;
import com.example.cinema.account.repository.UserRepository;
import com.example.cinema.admin.dto.UserUpdateDto;
import com.example.cinema.admin.service.FirebaseImageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.security.core.session.SessionInformation;
import org.springframework.security.core.session.SessionRegistry;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import java.io.IOException;
import java.text.MessageFormat;
import java.util.Collections;
import java.util.List;
import java.util.Optional;

@Service
public class UserService implements UserDetailsService {
    @Autowired
    private UserRepository userRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    private ConfirmationTokenService confirmationTokenService;

    @Autowired PasswordResetTokenService resetTokenService;

    @Autowired
    private MailSenderService mailSenderService;

    @Autowired
    private FirebaseImageService firebaseImageService;

    @Autowired
    @Qualifier("sessionRegistry")
    private SessionRegistry sessionRegistry;

    public List<User> userList(){
        return userRepository.findAll();
    }

    public Page<User> findAll(String sort, String search, int pageNum) {
        var sorting = Sort.by(Sort.Direction.DESC, "createdAt");

        if(sort.equals("created-asc"))
            sorting = Sort.by(Sort.Direction.ASC, "createdAt");

        if(sort.equals("created-desc"))
            sorting = Sort.by(Sort.Direction.DESC, "createdAt");

        if(sort.equals("status"))
            sorting = Sort.by(Sort.Direction.ASC, "locked");

        if(sort.equals("username"))
            sorting = Sort.by(Sort.Direction.ASC, "username");

        Pageable pageable = PageRequest.of(pageNum,20, sorting);

        if(search != null && !search.equals(""))
            return userRepository.search(search.toLowerCase(), pageable);

        return userRepository.findAll(pageable);
    }

    public User getUserById(Long id){
        Optional<User> optionalUser = userRepository.findById(id);
        return optionalUser.orElse(null);
    }

    @Override
    public User loadUserByUsername(String username) throws UsernameNotFoundException {
        Optional<User> optionalUser = userRepository.findByUsernameIgnoreCase(username);

        if (optionalUser.isPresent()) {
            return optionalUser.get();
        }
        else {
            throw new UsernameNotFoundException(
                    MessageFormat.format("User with username {0} cannot be found.", username)
            );
        }
    }

    public User findUserByEmail(String email) throws UsernameNotFoundException {
        Optional<User> optionalUser = userRepository.findByEmail(email);

        if (optionalUser.isPresent()) {
            return optionalUser.get();
        }
        else {
            throw new UsernameNotFoundException(
                    MessageFormat.format("User with email {0} cannot be found.", email)
            );
        }
    }

    public void signUpUser(User user) throws Exception {
        Optional<User> user_by_username = userRepository.findByUsernameIgnoreCase(user.getUsername());
        Optional<User> user_by_email = userRepository.findByEmail(user.getEmail());

        if (user_by_username.isPresent()) {
            throw new Exception("username:User with this username already exists");
        }

        if (user_by_email.isPresent()) {
            throw new Exception("email:User with this email already exists");
        }

        user.setRoles(Collections.singleton(Role.USER));
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        userRepository.save(user);

        ConfirmationToken confirmationToken = new ConfirmationToken(user);
        confirmationTokenService.saveConfirmationToken(confirmationToken);
        sendMessage(user, confirmationToken.getConfirmationToken(), "confirm");
    }

    public void updateUser(UserUpdateDto user, User user_to_edit) throws Exception {
        checkIfExists(user_to_edit, user.getUsername(), user.getEmail());

        if(!user.getUsername().equals(user_to_edit.getUsername())) {
            expireUserSessions(user_to_edit);
            user_to_edit.setUsername(user.getUsername());
        }
        user_to_edit.setEmail(user.getEmail());
        user_to_edit.setFirstName(user.getFirstName());
        user_to_edit.setLastName(user.getLastName());
        user_to_edit.setGender(user.getGender());
        user_to_edit.setBirthDay(user.getBirthDay());
        user_to_edit.setRoles(user.getRoles());

        userRepository.save(user_to_edit);
    }

    public void confirmUser(ConfirmationToken confirmationToken) {
        User user = confirmationToken.getUser();
        user.setActive(true);
        userRepository.save(user);

        confirmationTokenService.deleteConfirmationToken(confirmationToken.getId());
    }

    public void forgotPassword(User user){
        PasswordResetToken resetToken = new PasswordResetToken(user);
        resetTokenService.savePasswordResetToken(resetToken);
        sendMessage(user, resetToken.getResetToken(), "reset-password");
    }

    public void resetPassword(PasswordResetToken resetToken, String password){
        User user = resetToken.getUser();
        user.setPassword(passwordEncoder.encode(password));
        userRepository.save(user);

        resetTokenService.deletePasswordResetToken(resetToken.getId());
    }

    public void banUser(User user){
        user.setLocked(!user.getLocked());
        expireUserSessions(user);
        userRepository.save(user);
    }

    public void deleteUser(User user){
        var conf_tokens = confirmationTokenService.findByUser(user);
        var reset_tokens = resetTokenService.findByUser(user);

        for(var token : conf_tokens){
            confirmationTokenService.deleteConfirmationToken(token.getId());
        }

        for(var token : reset_tokens){
            resetTokenService.deletePasswordResetToken(token.getId());
        }
        expireUserSessions(user);

        userRepository.delete(user);
    }

    public void deleteUserImage(User user) throws IOException {
        if(user.getImageName() != null){
            firebaseImageService.delete(user.getImageName());
            user.setImageName(null);
            user.setImgUrl("https://firebasestorage.googleapis.com/v0/b/spring-project-31341.appspot.com/o/users%2Fdefault.png?alt=media");
            userRepository.save(user);
        }
    }

    public void expireUserSessions(User user){
        List<Object> loggedUsers = sessionRegistry.getAllPrincipals();
        for (Object principal : loggedUsers) {
            if(principal instanceof User) {
                final User loggedUser = (User) principal;
                if(user.getUsername().equals(loggedUser.getUsername())) {
                    List<SessionInformation> sessionsInfo = sessionRegistry.getAllSessions(principal, false);
                    if(null != sessionsInfo && sessionsInfo.size() > 0) {
                        for (SessionInformation sessionInformation : sessionsInfo) {
                            sessionInformation.expireNow();
                            //sessionRegistry.removeSessionInformation(sessionInformation.getSessionId());
                            // User is not forced to re-logging
                        }
                    }
                }
            }
        }
    }

    public void sendMessage(User user, String token, String type) {
        String baseUrl = ServletUriComponentsBuilder.fromCurrentContextPath().build().toUriString();
        String subject = "", message = "";
        if (!StringUtils.isEmpty(user.getEmail())) {
            if(type.equals("confirm")) {
                message = String.format(
                        "Hello, %s! \nWelcome to site. Please, visit next link: %s/confirm/%s",
                        user.getUsername(), baseUrl, token
                );

                subject = "Mail Confirmation Link!";

            }
            else if(type.equals("reset-password")){

                message =  String.format("Hello,%s\n"
                        + "You have requested to reset your password.\n"
                        + "Click the link below to change your password:\n"
                        + "%s/reset-password/%s\n"
                        + "Ignore this email if you do remember your password, "
                        + "or you have not made the request.",
                        user.getUsername(), baseUrl, token
                );

                subject = "Mail Reset Password Link!";
            }
            mailSenderService.send(user.getEmail(), subject, message);
        }
    }

    public void checkIfExists(User user, String username, String email) throws Exception {
        Optional<User> user_by_username;
        Optional<User> user_by_email;

        if(!user.getUsername().equals(username)) {
            user_by_username = userRepository.findByUsernameIgnoreCase(username);
            if (user_by_username.isPresent()) {
                throw new Exception("username:User with this username already exists");
            }
        }

        if(!user.getEmail().equals(email)) {
            user_by_email = userRepository.findByEmail(email);
            if (user_by_email.isPresent()) {
                throw new Exception("email:User with this email already exists");
            }
        }
    }
}

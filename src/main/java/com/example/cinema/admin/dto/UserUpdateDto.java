package com.example.cinema.admin.dto;

import com.example.cinema.account.model.Gender;
import com.example.cinema.account.model.Role;
import lombok.Data;
import org.hibernate.validator.constraints.Length;
import org.springframework.format.annotation.DateTimeFormat;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Pattern;
import java.util.Date;
import java.util.Set;

@Data
public class UserUpdateDto {
    @Pattern(regexp = "^[a-zA-Z0-9]([._-](?![._-])|[a-zA-Z0-9])*[a-zA-Z0-9]$",
            message = "Username must contain only letters, digits and special characters(., -,  _)"
    )
    @Length(min = 3, max = 30, message = "Username be between 3 and 30 characters")
    private String username;

    @Pattern(regexp = "^[A-Z][a-z]*", message = "First name must contain only letters with first capital letter")
    @Length(min = 3, max = 30, message = "First name must be between 3 and 30 characters")
    private String firstName;

    @Pattern(regexp = "^[A-Z][a-z]*", message = "Last name must contain only letters with first capital letter")
    @Length(min = 3, max = 30, message = "Last name must be between 3 and 30 characters")
    private String lastName;

    @Email(message = "Email is not correct")
    @NotBlank(message = "Email cannot be empty")
    private String email;

    private Gender gender;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date birthDay;

    private Set<Role> roles;

    public boolean isAdmin(){
        return roles.contains(Role.ADMIN);
    }
}

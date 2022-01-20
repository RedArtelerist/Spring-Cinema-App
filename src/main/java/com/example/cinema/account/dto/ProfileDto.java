package com.example.cinema.account.dto;

import com.example.cinema.account.model.Gender;
import lombok.Data;
import org.hibernate.validator.constraints.Length;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Pattern;
import java.util.Date;

@Data
public class ProfileDto {
    @Pattern(regexp = "^[a-zA-Z0-9]([._-](?![._-])|[a-zA-Z0-9])*[a-zA-Z0-9]$",
            message = "Username must contain only letters, digits and special characters(., -,  _)"
    )
    @Length(min = 3, max = 30, message = "Username be between 3 and 30 characters")
    private String username;

    @Email(message = "Email is not correct")
    @NotBlank(message = "Email cannot be empty")
    private String email;

    @Pattern(regexp = "^[A-Z][a-z]*", message = "First name must contain only letters with first capital letter")
    @Length(min = 3, max = 30, message = "First name must be between 3 and 30 characters")
    private String firstName;

    @Pattern(regexp = "^[A-Z][a-z]*", message = "Last name must contain only letters with first capital letter")
    @Length(min = 3, max = 30, message = "Last name must be between 3 and 30 characters")
    private String lastName;

    @Enumerated(EnumType.STRING)
    private Gender gender = Gender.MALE;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date birthDay;

    private String imgUrl;
}

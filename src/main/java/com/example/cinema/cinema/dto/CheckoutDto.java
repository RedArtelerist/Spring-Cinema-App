package com.example.cinema.cinema.dto;

import lombok.Getter;
import lombok.Setter;
import org.hibernate.validator.constraints.Length;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;

@Getter
@Setter
public class CheckoutDto {
    @Email(message = "Email is not correct")
    @NotBlank(message = "Email cannot be empty")
    private String email;

    @Pattern(regexp = "^\\+[0-9]{2}\\((\\d{3})\\)\\s\\d{3}-\\d{2}-\\d{2}", message = "Incorrect phone number")
    private String phone;

    @Pattern(regexp = "^[a-zA-Z]*", message = "First name must contain only letters")
    @Length(min = 3, max = 30, message = "First name must be between 3 and 30 characters")
    private String firstName;

    @Pattern(regexp = "^[a-zA-Z]*", message = "First name must contain only letters")
    @Length(min = 3, max = 30, message = "Last name must be between 3 and 30 characters")
    private String lastName;
}

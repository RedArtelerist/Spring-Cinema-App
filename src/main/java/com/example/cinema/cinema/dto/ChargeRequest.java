package com.example.cinema.cinema.dto;

import lombok.Getter;
import lombok.Setter;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;

@Getter
@Setter
public class ChargeRequest {
    @NotNull(message = "Amount can't be null")
    private int amount;

    @NotEmpty(message = "Token can't be empty")
    private String stripeToken;
}
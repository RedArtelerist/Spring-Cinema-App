package com.example.cinema.account.dto;

import com.example.cinema.account.constraints.ValidPassword;

public class PassResetDto {
    @ValidPassword
    private String password;
    private String password2;

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getPassword2() {
        return password2;
    }

    public void setPassword2(String password2) {
        this.password2 = password2;
    }
}

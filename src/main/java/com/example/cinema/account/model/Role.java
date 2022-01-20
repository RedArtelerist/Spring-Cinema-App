package com.example.cinema.account.model;

import org.springframework.security.core.GrantedAuthority;

public enum Role implements GrantedAuthority {
    USER, ADMIN, OWNER, MODERATOR;

    @Override
    public String getAuthority() {
        return name();
    }
}
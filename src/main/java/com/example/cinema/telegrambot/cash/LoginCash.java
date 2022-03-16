package com.example.cinema.telegrambot.cash;

import com.example.cinema.telegrambot.dto.LoginDto;
import lombok.Getter;
import lombok.Setter;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

@Service
@Setter
@Getter
public class LoginCash {
    private final Map<Long, LoginDto> loginMap = new HashMap<>();

    public void saveLoginCash(long userId, LoginDto login) {
        loginMap.put(userId, login);
    }
}

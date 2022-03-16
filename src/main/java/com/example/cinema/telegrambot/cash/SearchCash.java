package com.example.cinema.telegrambot.cash;

import com.example.cinema.telegrambot.dto.SearchDto;
import lombok.Getter;
import lombok.Setter;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

@Service
@Setter
@Getter
public class SearchCash {
    private final Map<Long, SearchDto> searchMap = new HashMap<>();

    public void saveSearchCash(long userId, SearchDto search) {
        searchMap.put(userId, search);
    }
}

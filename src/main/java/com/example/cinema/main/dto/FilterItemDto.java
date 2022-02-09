package com.example.cinema.main.dto;

import com.example.cinema.admin.model.Category;
import com.example.cinema.admin.model.Company;
import com.example.cinema.admin.model.Country;
import com.example.cinema.admin.model.Genre;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class FilterItemDto {
    Category category;
    Company company;
    Genre genre;
    Country country;
    String search;

    public FilterItemDto(Category category, Company company, Genre genre, Country country, String search) {
        this.category = category;
        this.company = company;
        this.genre = genre;
        this.country = country;
        this.search = search.toLowerCase().trim();
    }
}

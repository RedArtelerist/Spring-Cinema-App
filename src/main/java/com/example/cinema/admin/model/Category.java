package com.example.cinema.admin.model;

public enum Category {
    Movie("Movie"), TVShow("TV Show");

    private final String label;

    Category(String label) {
        this.label = label;
    }

    public String getLabel() {
        return label;
    }
}

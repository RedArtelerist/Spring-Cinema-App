package com.example.cinema.admin.model;

public enum MPAA {
    G("G"),
    PG("PG"),
    PG_13("PG-13"),
    R("R"),
    NC_17("NC-17");

    private final String label;

    MPAA(String label) {
        this.label = label;
    }

    public String getLabel() {
        return label;
    }
}

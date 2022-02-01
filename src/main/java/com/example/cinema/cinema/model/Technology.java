package com.example.cinema.cinema.model;

public enum Technology {
     _2D("2D"), _3D("3D"), Imax("IMAX"), _4DX("4DX"), Lux("LUX"), Atmos("ATMOS");

    private final String label;

    Technology(String label) {
        this.label = label;
    }

    public String getLabel() {
        return label;
    }
}

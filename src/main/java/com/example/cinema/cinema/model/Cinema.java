package com.example.cinema.cinema.model;

import com.fasterxml.jackson.annotation.JsonManagedReference;
import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.Range;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;

@Entity
public class Cinema {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, length = 30)
    @Pattern(regexp="^[a-zA-Z\\s\\-]{5,30}",message="Name must contain only letters and must be between 5 and 30 characters")
    private String name;

    @Enumerated(EnumType.STRING)
    private City city;

    @Column(nullable = false, length = 60)
    @Length(min = 5, max = 60, message = "Address must be between 5 and 60 characters")
    private String address;

    @Pattern(regexp = "^\\+[0-9]{2}\\((\\d{3})\\)\\s\\d{3}-\\d{2}-\\d{2}", message = "Incorrect phone number")
    private String phone;

    @NotNull(message = "Latitude can't be null")
    @Range(min = -90, max = 90, message = "range [-90; 90]")
    private Double latitude;

    @NotNull(message = "Longitude can't be null")
    @Range(min = -180, max = 180, message = "range [-180; 180]")
    private Double longitude;

    @NotNull(message = "Rating can't be null")
    @Range(min = 1, max = 5, message = "range [1; 5]")
    private Double rating;

    private boolean active;

    @Column(name = "image_name")
    private String imageName;

    @Column(name = "image_url", columnDefinition = "varchar(200) default 'https://firebasestorage.googleapis.com/v0/b/spring-project-31341.appspot.com/o/stars%2Fdefault.png?alt=media'")
    private String imageUrl = "https://firebasestorage.googleapis.com/v0/b/spring-project-31341.appspot.com/o/cinemas%2Fdefault.png?alt=media";

    @OneToMany(mappedBy = "cinema", fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    @JsonManagedReference
    private List<ImageCinema> gallery = new ArrayList<>();

    @OneToMany(mappedBy = "cinema", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    @JsonManagedReference
    private List<Hall> halls = new ArrayList<>();

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name.trim();
    }

    public City getCity() {
        return city;
    }

    public void setCity(City city) {
        this.city = city;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address.trim();
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public Double getLatitude() {
        return latitude;
    }

    public void setLatitude(Double latitude) {
        this.latitude = latitude;
    }

    public Double getLongitude() {
        return longitude;
    }

    public void setLongitude(Double longitude) {
        this.longitude = longitude;
    }

    public Double getRating() {
        return rating;
    }

    public void setRating(Double rating) {
        this.rating = rating;
    }

    public boolean isActive() {
        return active;
    }

    public void setActive(boolean active) {
        this.active = active;
    }

    public String getImageName() {
        return imageName;
    }

    public void setImageName(String imageName) {
        this.imageName = imageName;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public List<ImageCinema> getGallery() {
        return gallery;
    }

    public void setGallery(List<ImageCinema> gallery) {
        this.gallery = gallery;
    }

    public List<Hall> getHalls() {
        return halls;
    }

    public void setHalls(List<Hall> halls) {
        this.halls = halls;
    }
}

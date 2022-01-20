package com.example.cinema.admin.model;

import com.example.cinema.main.model.Comment;
import com.example.cinema.main.model.Favourite;
import com.example.cinema.main.model.Rating;
import com.example.cinema.main.model.WatchList;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.Range;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import java.util.*;

@Entity
public class Movie {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    @Length(min = 2, max = 100, message = "Title must be between 2 and 100 characters")
    private String title;

    @ElementCollection(targetClass = Country.class, fetch = FetchType.EAGER)
    @CollectionTable(name = "movie_counties", joinColumns = @JoinColumn(name = "movie_id"))
    @Enumerated(EnumType.STRING)
    private Set<Country> countries = new HashSet<>();

    @Length(min = 20, max = 4096, message = "Description must be between 20 and 4096 characters")
    private String description;

    @NotNull(message = "Year must not be empty")
    @Range(min = 1950, max = 2050, message = "Year must between 1950 and 2050")
    private Integer year;

    @Range(min = 1000, max = 1000000000, message = "Budget must between 1000$ and 1 billion $")
    private Integer budget;

    @Range(min = 1000, max = 5000000000L, message = "BoxOffice must between 1000$ and 5 billion $")
    private Integer boxOffice;

    @NotNull(message = "Release date must not be empty")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @Column(columnDefinition = "DATE")
    private Date release;

    //@Length(min = 2, max = 30, message = "Time must between 2 and 30)")
    private String time;

    @Column(name = "poster_name")
    private String posterName;

    @Column(name = "poster_url", columnDefinition = "varchar(200) default 'https://firebasestorage.googleapis.com/v0/b/spring-project-31341.appspot.com/o/movies%2Fdefault.jpg?alt=media'")
    private String posterUrl = "https://firebasestorage.googleapis.com/v0/b/spring-project-31341.appspot.com/o/movies%2Fdefault.jpg?alt=media";

    private String trailer;

    private boolean status;

    @Enumerated(EnumType.STRING)
    private MPAA mpaa;

    @Enumerated(EnumType.STRING)
    private Category category;

    @ElementCollection(targetClass = Genre.class, fetch = FetchType.EAGER)
    @CollectionTable(name = "movie_genres", joinColumns = @JoinColumn(name = "movie_id"))
    @Enumerated(EnumType.STRING)
    private Set<Genre> genres = new HashSet<>();

    @ManyToMany(fetch = FetchType.LAZY)
    @JoinTable(name = "movie_companies",
            joinColumns = { @JoinColumn(name = "movie_id") },
            inverseJoinColumns = { @JoinColumn(name = "company_id") })
    @JsonManagedReference
    private List<Company> companies;

    @ManyToMany(fetch = FetchType.LAZY)
    @JoinTable(name = "movie_directors",
            joinColumns = { @JoinColumn(name = "movie_id") },
            inverseJoinColumns = { @JoinColumn(name = "star_id") })
    @JsonManagedReference
    private List<Star> directors;

    @ManyToMany(fetch = FetchType.LAZY)
    @JoinTable(name = "movie_cast",
            joinColumns = { @JoinColumn(name = "movie_id") },
            inverseJoinColumns = { @JoinColumn(name = "star_id") })
    @JsonManagedReference
    private List<Star> cast;

    @OneToMany(mappedBy = "movie", fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    @JsonManagedReference
    private List<ImageMovie> gallery = new ArrayList<>();

    @OneToMany(mappedBy = "movie", fetch = FetchType.LAZY, cascade = CascadeType.ALL, orphanRemoval = true)
    @JsonManagedReference
    private List<Rating> ratings = new ArrayList<>();

    @OneToMany(mappedBy = "movie", fetch = FetchType.LAZY, cascade = CascadeType.ALL, orphanRemoval = true)
    @JsonManagedReference
    private List<WatchList> watchList = new ArrayList<>();

    @OneToMany(mappedBy = "movie", fetch = FetchType.LAZY, cascade = CascadeType.ALL, orphanRemoval = true)
    @JsonManagedReference
    private List<Favourite> favourites = new ArrayList<>();

    @OneToMany(mappedBy = "movie", fetch = FetchType.LAZY, cascade = CascadeType.ALL, orphanRemoval = true)
    @JsonManagedReference
    private List<Comment> comments = new ArrayList<>();

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title.trim();
    }

    public Set<Country> getCountries() {
        return countries;
    }

    public void setCountries(Set<Country> countries) {
        this.countries = countries;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description.trim();
    }

    public Integer getYear() {
        return year;
    }

    public void setYear(Integer year) {
        this.year = year;
    }

    public Integer getBudget() {
        return budget;
    }

    public void setBudget(Integer budget) {
        this.budget = budget;
    }

    public Integer getBoxOffice() {
        return boxOffice;
    }

    public void setBoxOffice(Integer boxOffice) {
        this.boxOffice = boxOffice;
    }

    public Date getRelease() {
        return release;
    }

    public void setRelease(Date release) {
        this.release = release;
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time.trim();
    }

    public String getPosterName() {
        return posterName;
    }

    public void setPosterName(String posterName) {
        this.posterName = posterName;
    }

    public String getPosterUrl() {
        return posterUrl;
    }

    public void setPosterUrl(String posterUrl) {
        this.posterUrl = posterUrl;
    }

    public String getTrailer() {
        return trailer;
    }

    public void setTrailer(String trailer) {
        this.trailer = trailer;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public Category getCategory() {
        return category;
    }

    public void setCategory(Category category) {
        this.category = category;
    }

    public MPAA getMpaa() {
        return mpaa;
    }

    public void setMpaa(MPAA mpaa) {
        this.mpaa = mpaa;
    }

    public Set<Genre> getGenres() {
        return genres;
    }

    public void setGenres(Set<Genre> genres) {
        this.genres = genres;
    }

    public List<Company> getCompanies() {
        return companies;
    }

    public void setCompanies(List<Company> companies) {
        this.companies = companies;
    }

    public List<Star> getDirectors() {
        return directors;
    }

    public void setDirectors(List<Star> directors) {
        this.directors = directors;
    }

    public List<Star> getCast() {
        return cast;
    }

    public void setCast(List<Star> cast) {
        this.cast = cast;
    }

    public List<ImageMovie> getGallery() {
        return gallery;
    }

    public void setGallery(List<ImageMovie> gallery) {
        this.gallery = gallery;
    }

    public List<Rating> getRatings() {
        return ratings;
    }

    public void setRatings(List<Rating> ratings) {
        this.ratings = ratings;
    }

    public List<WatchList> getWatchList() {
        return watchList;
    }

    public void setWatchList(List<WatchList> watchList) {
        this.watchList = watchList;
    }

    public List<Favourite> getFavourites() {
        return favourites;
    }

    public void setFavourites(List<Favourite> favourites) {
        this.favourites = favourites;
    }

    public List<Comment> getComments() {
        return comments;
    }

    public void setComments(List<Comment> comments) {
        this.comments = comments;
    }
}


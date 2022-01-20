package com.example.cinema.admin.model;

import com.example.cinema.account.model.Gender;
import com.fasterxml.jackson.annotation.JsonBackReference;
import org.hibernate.validator.constraints.Length;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.TimeZone;

@Entity
public class Star {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "first_name", nullable = false, length = 20)
    @Pattern(regexp = "^[A-Z][A-Za-z-. ]{1,30}", message = "First name must contain only letters with first capital letter," +
            "First name must be between 2 and 30 characters")
    private String firstName;

    @Column(name = "last_name", length = 20)
    @Length(max = 20, message = "Last name must be less 20 characters")
    private String lastName;

    @Column(nullable = false)
    @Enumerated(EnumType.STRING)
    private Gender gender;

    @Column(name = "birth_place", nullable = false, length = 50)
    @Length(min = 5, max = 50, message = "Birth place must be between 5 and 50 characters")
    private String birthPlace;

    @NotNull(message = "Birthday must not be empty")
    @Column(columnDefinition = "DATE")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date birthday;

    @Column(columnDefinition = "DATE")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date death;

    private boolean status;

    @Column(name = "img_name")
    private String imgName;

    @Column(name = "img_url", columnDefinition = "varchar(200) default 'https://firebasestorage.googleapis.com/v0/b/spring-project-31341.appspot.com/o/stars%2Fdefault.png?alt=media'")
    private String imgUrl = "https://firebasestorage.googleapis.com/v0/b/spring-project-31341.appspot.com/o/stars%2Fdefault.png?alt=media";

    @ManyToMany(mappedBy = "directors")
    @JsonBackReference
    private List<Movie> director_movies;

    @ManyToMany(mappedBy = "cast")
    @JsonBackReference
    private List<Movie> actor_movies;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName.trim();
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName.trim();
    }

    public Gender getGender() {
        return gender;
    }

    public void setGender(Gender gender) {
        this.gender = gender;
    }

    public String getBirthPlace() {
        return birthPlace;
    }

    public void setBirthPlace(String birthPlace) {
        this.birthPlace = birthPlace.trim();
    }

    public Date getBirthday() {
        return birthday;
    }

    public void setBirthday(Date birthday) {
        this.birthday = birthday;
    }

    public Date getDeath() {
        return death;
    }

    public void setDeath(Date death) {
        this.death = death;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public String getImgName() {
        return imgName;
    }

    public void setImgName(String imgName) {
        this.imgName = imgName;
    }

    public String getImgUrl() {
        return imgUrl;
    }

    public void setImgUrl(String imgUrl) {
        this.imgUrl = imgUrl;
    }

    public List<Movie> getDirector_movies() {
        return director_movies;
    }

    public void setDirector_movies(List<Movie> director_movies) {
        this.director_movies = director_movies;
    }

    public List<Movie> getActor_movies() {
        return actor_movies;
    }

    public void setActor_movies(List<Movie> actor_movies) {
        this.actor_movies = actor_movies;
    }

    public int getAge(){
        Calendar birthCal = Calendar.getInstance(TimeZone.getTimeZone("Europe/Paris"));
        birthCal.setTime(birthday);
        if(death == null)
            return Calendar.getInstance().get(Calendar.YEAR) - birthCal.get(Calendar.YEAR);
        else {
            Calendar deathCal = Calendar.getInstance(TimeZone.getTimeZone("Europe/Paris"));
            deathCal.setTime(death);
            return deathCal.get(Calendar.YEAR) - birthCal.get(Calendar.YEAR);
        }
    }

    public String fullName(){
        if(lastName != null && !lastName.equals(""))
            return firstName + " " + lastName;
        else
            return firstName;
    }
}

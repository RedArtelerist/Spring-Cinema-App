package com.example.cinema.main.model;

import org.hibernate.validator.constraints.Length;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import javax.persistence.*;
import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Pattern;
import java.util.Date;

@Entity
@EntityListeners(AuditingEntityListener.class)
public class ContactUsMessage {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, length = 30)
    @Pattern(regexp = "^[a-zA-Z ]*", message = "Name must contain only letters")
    @Length(min = 3, max = 30, message = "Name must be between 3 and 30 characters")
    private String name;

    @Column(nullable = false, length = 60)
    @Email(message = "Email is not correct")
    @NotBlank(message = "Email can't be empty")
    private String email;

    @Column(nullable = false, length = 1000)
    @Length(min = 10, max = 1000, message = "Your comment must be between 10 and 1000 characters")
    private String text;

    @CreatedDate
    @Column(name = "created_at", nullable = false, updatable = false)
    private Date createdAt;

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

    public String getEmail() {
        return email.trim();
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getText() {
        return text.trim();
    }

    public void setText(String text) {
        this.text = text;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }
}

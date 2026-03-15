package com.example.cuisine.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

/**
 * App user — can be a regular user or an admin (you).
 *
 * ROLE_USER  → can browse, save favourites
 * ROLE_ADMIN → can also upload/edit/delete recipes
 */
@Entity
@Table(name = "users")
@Getter @Setter @NoArgsConstructor
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, unique = true)
    private String email;

    @Column(nullable = false)
    private String password; // BCrypt hashed — never store plain text!

    private String displayName;

    // Preferred language for content (EN, FR, ZH_CN)
    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 10)
    private Language preferredLanguage = Language.EN;

    // ROLE_USER or ROLE_ADMIN
    @Column(nullable = false)
    private String role = "ROLE_USER";

    @Column(nullable = false)
    private Boolean enabled = true;

    @Column(name = "created_at", updatable = false)
    private LocalDateTime createdAt;

    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Favourite> favourites = new ArrayList<>();

    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
    }
}

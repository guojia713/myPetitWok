package com.example.cuisine.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDateTime;

/**
 * A user's saved/favourite recipe.
 * Simple join between User and Recipe with a timestamp.
 */
@Entity
@Table(name = "favourites",
       uniqueConstraints = @UniqueConstraint(columnNames = {"user_id", "recipe_id"}))
@Getter @Setter @NoArgsConstructor
public class Favourite {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "recipe_id", nullable = false)
    private Recipe recipe;

    @Column(name = "saved_at", updatable = false)
    private LocalDateTime savedAt;

    @PrePersist
    protected void onCreate() {
        savedAt = LocalDateTime.now();
    }
}

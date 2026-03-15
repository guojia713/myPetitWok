package com.example.cuisine.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

/**
 * Core recipe data — no translatable text here.
 * All text (name, description) lives in RecipeTranslation.
 */
@Entity
@Table(name = "recipes")
@Getter @Setter @NoArgsConstructor
public class Recipe {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    // e.g. CHINESE, JAPANESE, KOREAN, THAI, VIETNAMESE
    @Column(nullable = false)
    private String cuisineType;

    // BEGINNER, INTERMEDIATE, ADVANCED
    @Column(nullable = false)
    private String difficulty;

    @Column(nullable = false)
    private Integer prepTimeMinutes;

    @Column(nullable = false)
    private Integer cookTimeMinutes;

    @Column(nullable = false)
    private Integer servings;

    // Spice level 0-5
    @Column(nullable = false)
    private Integer spiceLevel = 0;

    // Main dish photo stored in S3
    private String imageUrl;

    // Published = visible to public. Unpublished = draft (only you can see in admin)
    @Column(nullable = false)
    private Boolean published = false;

    @Column(name = "created_at", updatable = false)
    private LocalDateTime createdAt;

    @Column(name = "updated_at")
    private LocalDateTime updatedAt;

    // ---- Relationships ----

    @OneToMany(mappedBy = "recipe", cascade = CascadeType.ALL, orphanRemoval = true)
    @OrderBy("id ASC")
    private List<RecipeTranslation> translations = new ArrayList<>();

    @OneToMany(mappedBy = "recipe", cascade = CascadeType.ALL, orphanRemoval = true)
    @OrderBy("stepOrder ASC")
    private List<RecipeStep> steps = new ArrayList<>();

    @OneToMany(mappedBy = "recipe", cascade = CascadeType.ALL, orphanRemoval = true)
    @OrderBy("sortOrder ASC")
    private List<RecipeIngredient> recipeIngredients = new ArrayList<>();

    @OneToMany(mappedBy = "recipe", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Favourite> favourites = new ArrayList<>();

    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
        updatedAt = LocalDateTime.now();
    }

    @PreUpdate
    protected void onUpdate() {
        updatedAt = LocalDateTime.now();
    }

    // Helper: get translation for a specific language, fallback to EN
    public RecipeTranslation getTranslation(Language lang) {
        return translations.stream()
                .filter(t -> t.getLanguage() == lang)
                .findFirst()
                .orElseGet(() -> translations.stream()
                        .filter(t -> t.getLanguage() == Language.EN)
                        .findFirst()
                        .orElse(null));
    }
}

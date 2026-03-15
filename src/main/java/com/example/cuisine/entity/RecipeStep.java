package com.example.cuisine.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.ArrayList;
import java.util.List;

/**
 * A single step in a recipe's cooking instructions.
 * Each step can have a photo (uploaded to S3) to guide the user.
 * Translations hold the actual instruction text per language.
 */
@Entity
@Table(name = "recipe_steps")
@Getter @Setter @NoArgsConstructor
public class RecipeStep {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "recipe_id", nullable = false)
    private Recipe recipe;

    // Step number (1, 2, 3...)
    @Column(nullable = false)
    private Integer stepOrder;

    // Optional photo for this step (e.g. showing how the wok should look)
    private String imageUrl;

    // Estimated time for this step in minutes (optional)
    private Integer durationMinutes;

    @OneToMany(mappedBy = "step", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<RecipeStepTranslation> translations = new ArrayList<>();

    // Helper: get translation for a specific language, fallback to EN
    public RecipeStepTranslation getTranslation(Language lang) {
        return translations.stream()
                .filter(t -> t.getLanguage() == lang)
                .findFirst()
                .orElseGet(() -> translations.stream()
                        .filter(t -> t.getLanguage() == Language.EN)
                        .findFirst()
                        .orElse(null));
    }
}

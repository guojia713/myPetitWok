package com.example.cuisine.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.ArrayList;
import java.util.List;

/**
 * A reusable ingredient shared across many recipes.
 * Key feature: substitute ingredient + where to find in Europe.
 */
@Entity
@Table(name = "ingredients")
@Getter @Setter @NoArgsConstructor
public class Ingredient {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    // The original Asian name (e.g. "豆瓣酱", "Doubanjiang")
    @Column(nullable = false)
    private String asianName;

    // S3 URL of ingredient photo (helps users identify in store)
    private String imageUrl;

    // Category: SAUCE, SPICE, VEGETABLE, PROTEIN, NOODLE, etc.
    private String category;

    // Joybuy affiliate link — where to buy this ingredient online
    private String joybuyUrl;

    // Self-referencing: if this ingredient is hard to find,
    // point to a simpler substitute
    // e.g. Shaoxing wine → Dry Sherry
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "substitute_id")
    private Ingredient substitute;

    @OneToMany(mappedBy = "ingredient", cascade = CascadeType.ALL, orphanRemoval = true)
    @OrderBy("id ASC")
    private List<IngredientTranslation> translations = new ArrayList<>();

    // Helper: get translation for a specific language, fallback to EN
    public IngredientTranslation getTranslation(Language lang) {
        return translations.stream()
                .filter(t -> t.getLanguage() == lang)
                .findFirst()
                .orElseGet(() -> translations.stream()
                        .filter(t -> t.getLanguage() == Language.EN)
                        .findFirst()
                        .orElse(null));
    }
}

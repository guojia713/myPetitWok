package com.example.cuisine.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

/**
 * Translatable text for an ingredient.
 *
 * Example rows for Doubanjiang (ingredient_id = 5):
 *   (5, EN,    "Spicy Bean Paste",  "Fermented broad beans with chili...", "Available at Asian supermarkets or Amazon")
 *   (5, FR,    "Pâte de haricots pimentée", "Haricots fermentés avec piment...", "Disponible dans les épiceries asiatiques")
 *   (5, ZH_CN, "豆瓣酱", "用辣椒和蚕豆发酵制成...", "各大亚洲超市均有售")
 */
@Entity
@Table(name = "ingredient_translations",
       uniqueConstraints = @UniqueConstraint(columnNames = {"ingredient_id", "language"}))
@Getter @Setter @NoArgsConstructor
public class IngredientTranslation {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "ingredient_id", nullable = false)
    private Ingredient ingredient;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 10)
    private Language language;

    // Local name in this language (what Europeans call it)
    @Column(nullable = false)
    private String name;

    // What it is, how it tastes, why it's used
    @Column(columnDefinition = "TEXT")
    private String description;

    // Crucial for European users: where to find this in Europe
    // e.g. "Asian supermarkets, Amazon.fr, or Carrefour international aisle"
    @Column(columnDefinition = "TEXT")
    private String whereToFind;
}

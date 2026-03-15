package com.example.cuisine.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

/**
 * Stores all translatable text for a recipe.
 * One row per language per recipe.
 *
 * Example rows for Mapo Tofu (recipe_id = 1):
 *   (1, EN,    "Mapo Tofu",  "A spicy Sichuan classic...")
 *   (1, FR,    "Mapo Tofu",  "Un classique épicé du Sichuan...")
 *   (1, ZH_CN, "麻婆豆腐",   "四川经典麻辣豆腐菜肴...")
 */
@Entity
@Table(name = "recipe_translations",
       uniqueConstraints = @UniqueConstraint(columnNames = {"recipe_id", "language"}))
@Getter @Setter @NoArgsConstructor
public class RecipeTranslation {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "recipe_id", nullable = false)
    private Recipe recipe;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 10)
    private Language language;

    // Dish name in this language
    @Column(nullable = false)
    private String name;

    // Short description shown on recipe card
    @Column(columnDefinition = "TEXT")
    private String description;

    // Phonetic pronunciation — helpful for Chinese dish names
    // e.g. "Má pó dòufu" for EN/FR users reading 麻婆豆腐
    private String phonetic;
}

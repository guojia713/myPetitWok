package com.example.cuisine.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

/**
 * Links a Recipe to an Ingredient with quantity info.
 * Also tracks whether this ingredient is optional.
 *
 * Example: Mapo Tofu needs:
 *   - 400g Tofu (required)
 *   - 2 tbsp Doubanjiang (required)
 *   - 1 tsp Sichuan peppercorns (optional — hard to find)
 */
@Entity
@Table(name = "recipe_ingredients")
@Getter @Setter @NoArgsConstructor
public class RecipeIngredient {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "recipe_id", nullable = false)
    private Recipe recipe;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "ingredient_id", nullable = false)
    private Ingredient ingredient;

    // e.g. "400", "2", "1/2"
    private String quantity;

    // e.g. "g", "tbsp", "tsp", "piece", "clove"
    private String unit;

    // If true, the recipe still works without this ingredient
    @Column(nullable = false)
    private Boolean optional = false;

    // Display order in the ingredients list
    @Column(nullable = false)
    private Integer sortOrder = 0;
}

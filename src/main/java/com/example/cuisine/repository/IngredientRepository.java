package com.example.cuisine.repository;

import com.example.cuisine.entity.Ingredient;
import com.example.cuisine.entity.Language;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface IngredientRepository extends JpaRepository<Ingredient, Long> {

    // Search ingredients by name in a specific language
    @Query("""
        SELECT DISTINCT i FROM Ingredient i
        JOIN i.translations t
        WHERE t.language = :lang
          AND LOWER(t.name) LIKE LOWER(CONCAT('%', :query, '%'))
        """)
    List<Ingredient> searchByLanguage(@Param("query") String query, @Param("lang") Language lang);

    // Find by category (SAUCE, SPICE, etc.)
    List<Ingredient> findByCategoryIgnoreCase(String category);

    // Fetch with all translations eagerly
    @Query("""
        SELECT DISTINCT i FROM Ingredient i
        LEFT JOIN FETCH i.translations
        LEFT JOIN FETCH i.substitute s
        LEFT JOIN FETCH s.translations
        WHERE i.id = :id
        """)
    Optional<Ingredient> findByIdWithDetails(@Param("id") Long id);
}

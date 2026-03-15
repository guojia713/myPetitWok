package com.example.cuisine.repository;

import com.example.cuisine.entity.Language;
import com.example.cuisine.entity.Recipe;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface RecipeRepository extends JpaRepository<Recipe, Long> {

    // Find published recipes, paginated
    Page<Recipe> findByPublishedTrue(Pageable pageable);

    // Find by cuisine type (e.g. CHINESE, JAPANESE)
    Page<Recipe> findByPublishedTrueAndCuisineTypeIgnoreCase(String cuisineType, Pageable pageable);

    // Find by difficulty
    Page<Recipe> findByPublishedTrueAndDifficultyIgnoreCase(String difficulty, Pageable pageable);

    // Full-text search across recipe translations (name + description) for a given language
    @Query("""
        SELECT DISTINCT r FROM Recipe r
        JOIN r.translations t
        WHERE r.published = true
          AND t.language = :lang
          AND (LOWER(t.name) LIKE LOWER(CONCAT('%', :query, '%'))
               OR LOWER(t.description) LIKE LOWER(CONCAT('%', :query, '%')))
        """)
    Page<Recipe> searchByLanguage(
            @Param("query") String query,
            @Param("lang") Language lang,
            Pageable pageable);

    // Filter by cuisine + difficulty combined
    @Query("""
        SELECT r FROM Recipe r
        WHERE r.published = true
          AND (:cuisineType IS NULL OR LOWER(r.cuisineType) = LOWER(:cuisineType))
          AND (:difficulty IS NULL OR LOWER(r.difficulty) = LOWER(:difficulty))
          AND (:maxSpice IS NULL OR r.spiceLevel <= :maxSpice)
        """)
    Page<Recipe> findWithFilters(
            @Param("cuisineType") String cuisineType,
            @Param("difficulty") String difficulty,
            @Param("maxSpice") Integer maxSpice,
            Pageable pageable);

    // Fetch recipe with all translations eagerly (avoids N+1)
    @Query("""
        SELECT DISTINCT r FROM Recipe r
        LEFT JOIN FETCH r.translations
        LEFT JOIN FETCH r.recipeIngredients ri
        LEFT JOIN FETCH ri.ingredient i
        LEFT JOIN FETCH i.translations
        WHERE r.id = :id AND r.published = true
        """)
    Optional<Recipe> findByIdWithDetails(@Param("id") Long id);

    // Admin: fetch any recipe by id (published or not)
    @Query("""
        SELECT DISTINCT r FROM Recipe r
        LEFT JOIN FETCH r.translations
        LEFT JOIN FETCH r.recipeIngredients ri
        LEFT JOIN FETCH ri.ingredient i
        LEFT JOIN FETCH i.translations
        WHERE r.id = :id
        """)
    Optional<Recipe> findByIdWithDetailsAdmin(@Param("id") Long id);
}

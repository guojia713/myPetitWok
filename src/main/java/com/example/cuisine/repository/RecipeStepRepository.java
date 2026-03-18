package com.example.cuisine.repository;

import com.example.cuisine.entity.RecipeStep;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface RecipeStepRepository extends JpaRepository<RecipeStep, Long> {

    Optional<RecipeStep> findByRecipeIdAndStepOrder(Long recipeId, Integer stepOrder);
}

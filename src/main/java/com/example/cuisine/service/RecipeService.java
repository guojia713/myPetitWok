package com.example.cuisine.service;

import com.example.cuisine.dto.IngredientDto;
import com.example.cuisine.dto.RecipeDto;
import com.example.cuisine.entity.*;
import com.example.cuisine.exception.ApiException;
import com.example.cuisine.repository.FavouriteRepository;
import com.example.cuisine.repository.IngredientRepository;
import com.example.cuisine.repository.RecipeRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class RecipeService {

    private final RecipeRepository recipeRepository;
    private final IngredientRepository ingredientRepository;
    private final FavouriteRepository favouriteRepository;

    // ── Public: list with filters ─────────────────────────────────────────────

    public RecipeDto.PagedResponse findAll(
            String cuisineType, String difficulty, Integer maxSpice,
            String search, Language lang, int page, int size,
            Long currentUserId) {

        Pageable pageable = PageRequest.of(page, size, Sort.by("createdAt").descending());
        Page<Recipe> recipePage;

        if (search != null && !search.isBlank()) {
            recipePage = recipeRepository.searchByLanguage(search, lang, pageable);
        } else if (cuisineType != null || difficulty != null || maxSpice != null) {
            recipePage = recipeRepository.findWithFilters(cuisineType, difficulty, maxSpice, pageable);
        } else {
            recipePage = recipeRepository.findByPublishedTrue(pageable);
        }

        RecipeDto.PagedResponse response = new RecipeDto.PagedResponse();
        response.setContent(recipePage.getContent().stream()
                .map(r -> toCard(r, lang, currentUserId))
                .toList());
        response.setPage(recipePage.getNumber());
        response.setSize(recipePage.getSize());
        response.setTotalElements(recipePage.getTotalElements());
        response.setTotalPages(recipePage.getTotalPages());
        response.setLast(recipePage.isLast());
        return response;
    }

    // ── Public: recipe detail ─────────────────────────────────────────────────

    public RecipeDto.DetailResponse findById(Long id, Language lang, Long currentUserId) {
        Recipe recipe = recipeRepository.findByIdWithDetails(id)
                .orElseThrow(() -> new ApiException(HttpStatus.NOT_FOUND, "Recipe not found"));
        return toDetail(recipe, lang, currentUserId);
    }

    // ── Admin: create recipe ──────────────────────────────────────────────────

    @Transactional
    public RecipeDto.DetailResponse create(RecipeDto.CreateRequest request) {
        Recipe recipe = new Recipe();
        applyCreateRequest(recipe, request);
        recipe.setPublished(false); // start as draft
        Recipe saved = recipeRepository.save(recipe);
        return toDetail(saved, Language.EN, null);
    }

    // ── Admin: update recipe ──────────────────────────────────────────────────

    @Transactional
    public RecipeDto.DetailResponse update(Long id, RecipeDto.CreateRequest request) {
        Recipe recipe = recipeRepository.findByIdWithDetailsAdmin(id)
                .orElseThrow(() -> new ApiException(HttpStatus.NOT_FOUND, "Recipe not found"));

        // Clear existing translations, steps, ingredients — replace with new
        recipe.getTranslations().clear();
        recipe.getSteps().clear();
        recipe.getRecipeIngredients().clear();

        applyCreateRequest(recipe, request);
        return toDetail(recipeRepository.save(recipe), Language.EN, null);
    }

    // ── Admin: publish / unpublish ────────────────────────────────────────────

    @Transactional
    public void setPublished(Long id, boolean published) {
        Recipe recipe = recipeRepository.findById(id)
                .orElseThrow(() -> new ApiException(HttpStatus.NOT_FOUND, "Recipe not found"));
        recipe.setPublished(published);
        recipeRepository.save(recipe);
    }

    // ── Admin: update image URL after S3 upload ───────────────────────────────

    @Transactional
    public void updateImageUrl(Long id, String imageUrl) {
        Recipe recipe = recipeRepository.findById(id)
                .orElseThrow(() -> new ApiException(HttpStatus.NOT_FOUND, "Recipe not found"));
        recipe.setImageUrl(imageUrl);
        recipeRepository.save(recipe);
    }

    // ── Admin: delete ─────────────────────────────────────────────────────────

    @Transactional
    public void delete(Long id) {
        Recipe recipe = recipeRepository.findById(id)
                .orElseThrow(() -> new ApiException(HttpStatus.NOT_FOUND, "Recipe not found"));
        recipeRepository.delete(recipe);
    }

    // ── Private helpers ───────────────────────────────────────────────────────

    private void applyCreateRequest(Recipe recipe, RecipeDto.CreateRequest req) {
        recipe.setCuisineType(req.getCuisineType());
        recipe.setDifficulty(req.getDifficulty());
        recipe.setPrepTimeMinutes(req.getPrepTimeMinutes());
        recipe.setCookTimeMinutes(req.getCookTimeMinutes());
        recipe.setServings(req.getServings());
        recipe.setSpiceLevel(req.getSpiceLevel() != null ? req.getSpiceLevel() : 0);

        // Translations
        if (req.getTranslations() != null) {
            req.getTranslations().forEach((langKey, input) -> {
                Language lang = Language.valueOf(langKey.toUpperCase().replace("-", "_"));
                RecipeTranslation t = new RecipeTranslation();
                t.setRecipe(recipe);
                t.setLanguage(lang);
                t.setName(input.getName());
                t.setDescription(input.getDescription());
                t.setPhonetic(input.getPhonetic());
                recipe.getTranslations().add(t);
            });
        }

        // Ingredients
        if (req.getIngredients() != null) {
            req.getIngredients().forEach(ingInput -> {
                Ingredient ingredient = ingredientRepository.findById(ingInput.getIngredientId())
                        .orElseThrow(() -> new ApiException(HttpStatus.NOT_FOUND,
                                "Ingredient not found: " + ingInput.getIngredientId()));
                RecipeIngredient ri = new RecipeIngredient();
                ri.setRecipe(recipe);
                ri.setIngredient(ingredient);
                ri.setQuantity(ingInput.getQuantity());
                ri.setUnit(ingInput.getUnit());
                ri.setOptional(ingInput.getOptional() != null && ingInput.getOptional());
                ri.setSortOrder(ingInput.getSortOrder() != null ? ingInput.getSortOrder() : 0);
                recipe.getRecipeIngredients().add(ri);
            });
        }

        // Steps
        if (req.getSteps() != null) {
            req.getSteps().forEach(stepInput -> {
                RecipeStep step = new RecipeStep();
                step.setRecipe(recipe);
                step.setStepOrder(stepInput.getStepOrder());
                step.setDurationMinutes(stepInput.getDurationMinutes());

                if (stepInput.getTranslations() != null) {
                    stepInput.getTranslations().forEach((langKey, stInput) -> {
                        Language lang = Language.valueOf(langKey.toUpperCase().replace("-", "_"));
                        RecipeStepTranslation st = new RecipeStepTranslation();
                        st.setStep(step);
                        st.setLanguage(lang);
                        st.setInstruction(stInput.getInstruction());
                        st.setTip(stInput.getTip());
                        step.getTranslations().add(st);
                    });
                }
                recipe.getSteps().add(step);
            });
        }
    }

    // ── Mapping to DTOs ───────────────────────────────────────────────────────

    RecipeDto.CardResponse toCard(Recipe recipe, Language lang, Long currentUserId) {
        RecipeTranslation t = recipe.getTranslation(lang);
        RecipeDto.CardResponse dto = new RecipeDto.CardResponse();
        dto.setId(recipe.getId());
        dto.setName(t != null ? t.getName() : "");
        dto.setDescription(t != null ? t.getDescription() : "");
        dto.setPhonetic(t != null ? t.getPhonetic() : null);
        dto.setCuisineType(recipe.getCuisineType());
        dto.setDifficulty(recipe.getDifficulty());
        dto.setPrepTimeMinutes(recipe.getPrepTimeMinutes());
        dto.setCookTimeMinutes(recipe.getCookTimeMinutes());
        dto.setSpiceLevel(recipe.getSpiceLevel());
        dto.setServings(recipe.getServings());
        dto.setImageUrl(recipe.getImageUrl());
        dto.setFavouriteCount(favouriteRepository.countByRecipeId(recipe.getId()));
        dto.setIsFavourite(currentUserId != null &&
                favouriteRepository.existsByUserIdAndRecipeId(currentUserId, recipe.getId()));
        return dto;
    }

    private RecipeDto.DetailResponse toDetail(Recipe recipe, Language lang, Long currentUserId) {
        RecipeTranslation t = recipe.getTranslation(lang);
        RecipeDto.DetailResponse dto = new RecipeDto.DetailResponse();
        dto.setId(recipe.getId());
        dto.setName(t != null ? t.getName() : "");
        dto.setDescription(t != null ? t.getDescription() : "");
        dto.setPhonetic(t != null ? t.getPhonetic() : null);
        dto.setCuisineType(recipe.getCuisineType());
        dto.setDifficulty(recipe.getDifficulty());
        dto.setPrepTimeMinutes(recipe.getPrepTimeMinutes());
        dto.setCookTimeMinutes(recipe.getCookTimeMinutes());
        dto.setSpiceLevel(recipe.getSpiceLevel());
        dto.setServings(recipe.getServings());
        dto.setImageUrl(recipe.getImageUrl());
        dto.setFavouriteCount(favouriteRepository.countByRecipeId(recipe.getId()));
        dto.setIsFavourite(currentUserId != null &&
                favouriteRepository.existsByUserIdAndRecipeId(currentUserId, recipe.getId()));

        // Ingredients
        dto.setIngredients(recipe.getRecipeIngredients().stream()
                .sorted((a, b) -> a.getSortOrder().compareTo(b.getSortOrder()))
                .map(ri -> toIngredientResponse(ri, lang))
                .toList());

        // Steps
        dto.setSteps(recipe.getSteps().stream()
                .map(step -> toStepResponse(step, lang))
                .toList());

        return dto;
    }

    private IngredientDto.RecipeIngredientResponse toIngredientResponse(RecipeIngredient ri, Language lang) {
        Ingredient ing = ri.getIngredient();
        IngredientTranslation t = ing.getTranslation(lang);

        IngredientDto.RecipeIngredientResponse dto = new IngredientDto.RecipeIngredientResponse();
        dto.setIngredientId(ing.getId());
        dto.setName(t != null ? t.getName() : ing.getAsianName());
        dto.setAsianName(ing.getAsianName());
        dto.setQuantity(ri.getQuantity());
        dto.setUnit(ri.getUnit());
        dto.setOptional(ri.getOptional());
        dto.setImageUrl(ing.getImageUrl());
        dto.setWhereToFind(t != null ? t.getWhereToFind() : null);

        if (ing.getSubstitute() != null) {
            IngredientTranslation st = ing.getSubstitute().getTranslation(lang);
            IngredientDto.SubstituteResponse sub = new IngredientDto.SubstituteResponse();
            sub.setId(ing.getSubstitute().getId());
            sub.setName(st != null ? st.getName() : ing.getSubstitute().getAsianName());
            sub.setAsianName(ing.getSubstitute().getAsianName());
            dto.setSubstitute(sub);
        }
        return dto;
    }

    private RecipeDto.StepResponse toStepResponse(RecipeStep step, Language lang) {
        RecipeStepTranslation t = step.getTranslation(lang);
        RecipeDto.StepResponse dto = new RecipeDto.StepResponse();
        dto.setStepOrder(step.getStepOrder());
        dto.setInstruction(t != null ? t.getInstruction() : "");
        dto.setTip(t != null ? t.getTip() : null);
        dto.setImageUrl(step.getImageUrl());
        dto.setDurationMinutes(step.getDurationMinutes());
        return dto;
    }
}

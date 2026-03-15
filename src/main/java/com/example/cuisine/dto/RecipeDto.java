package com.example.cuisine.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

import java.util.List;
import java.util.Map;

public class RecipeDto {

    // ── List view (lightweight card) ──────────────────────────────────────────
    @Data
    public static class CardResponse {
        public Long id;
        public String name;
        public String description;
        public String phonetic;
        public String cuisineType;
        public String difficulty;
        public Integer prepTimeMinutes;
        public Integer cookTimeMinutes;
        public Integer spiceLevel;
        public Integer servings;
        public String imageUrl;
        public Boolean isFavourite;
        public Long favouriteCount;
    }

    // ── Full detail view ──────────────────────────────────────────────────────
    @Data
    public static class DetailResponse {
        public Long id;
        public String name;
        public String description;
        public String phonetic;
        public String cuisineType;
        public String difficulty;
        public Integer prepTimeMinutes;
        public Integer cookTimeMinutes;
        public Integer spiceLevel;
        public Integer servings;
        public String imageUrl;
        public Boolean isFavourite;
        public Long favouriteCount;
        public List<IngredientDto.RecipeIngredientResponse> ingredients;
        public List<StepResponse> steps;
    }

    // ── Step ──────────────────────────────────────────────────────────────────
    @Data
    public static class StepResponse {
        public Integer stepOrder;
        public String instruction;
        public String tip;
        public String imageUrl;
        public Integer durationMinutes;
    }

    // ── Admin: create / update ────────────────────────────────────────────────
    @Data
    public static class CreateRequest {
        @NotBlank public String cuisineType;
        @NotBlank public String difficulty;
        @NotNull  public Integer prepTimeMinutes;
        @NotNull  public Integer cookTimeMinutes;
        @NotNull  public Integer servings;
        public Integer spiceLevel = 0;
        // key = "EN", "FR", "ZH_CN"
        @NotNull public Map<String, TranslationInput> translations;
        public List<RecipeIngredientInput> ingredients;
        public List<StepInput> steps;
    }

    @Data
    public static class TranslationInput {
        @NotBlank public String name;
        public String description;
        public String phonetic;
    }

    @Data
    public static class RecipeIngredientInput {
        @NotNull public Long ingredientId;
        public String quantity;
        public String unit;
        public Boolean optional = false;
        public Integer sortOrder = 0;
    }

    @Data
    public static class StepInput {
        @NotNull public Integer stepOrder;
        public Integer durationMinutes;
        // key = "EN", "FR", "ZH_CN"
        @NotNull public Map<String, StepTranslationInput> translations;
    }

    @Data
    public static class StepTranslationInput {
        @NotBlank public String instruction;
        public String tip;
    }

    // ── Pagination wrapper ────────────────────────────────────────────────────
    @Data
    public static class PagedResponse {
        public List<CardResponse> content;
        public int page;
        public int size;
        public long totalElements;
        public int totalPages;
        public boolean last;
    }
}

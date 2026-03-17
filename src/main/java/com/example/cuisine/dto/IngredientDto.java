package com.example.cuisine.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

import java.util.Map;

public class IngredientDto {

    // ── Used inside RecipeDetailResponse ─────────────────────────────────────
    @Data
    public static class RecipeIngredientResponse {
        public Long ingredientId;
        public String name;        // in requested language
        public String asianName;   // always shown — helps identify in store
        public String quantity;
        public String unit;
        public Boolean optional;
        public String imageUrl;
        public String whereToFind; // in requested language
        public String joybuyUrl;
        public SubstituteResponse substitute;
    }

    @Data
    public static class SubstituteResponse {
        public Long id;
        public String name;
        public String asianName;
    }

    // ── Standalone ingredient detail ──────────────────────────────────────────
    @Data
    public static class DetailResponse {
        public Long id;
        public String asianName;
        public String name;
        public String description;
        public String whereToFind;
        public String imageUrl;
        public String category;
        public String joybuyUrl;
        public SubstituteResponse substitute;
    }

    // ── Admin: create ingredient ──────────────────────────────────────────────
    @Data
    public static class CreateRequest {
        @NotBlank public String asianName;
        public String category;
        public Long substituteId;
        public String joybuyUrl;
        // key = "EN", "FR", "ZH_CN"
        @NotNull public Map<String, TranslationInput> translations;
    }

    @Data
    public static class TranslationInput {
        @NotBlank public String name;
        public String description;
        public String whereToFind;
    }
}

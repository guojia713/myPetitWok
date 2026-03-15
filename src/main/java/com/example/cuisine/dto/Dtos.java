package com.example.cuisine.dto;

import com.example.cuisine.entity.Language;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

// ─── Auth ─────────────────────────────────────────────────────────────────────

@Data
class RegisterRequest {
    @Email @NotBlank public String email;
    @NotBlank public String password;
    public String displayName;
    public Language preferredLanguage = Language.EN;
}

@Data
class LoginRequest {
    @Email @NotBlank public String email;
    @NotBlank public String password;
}

@Data
class AuthResponse {
    public String token;
    public String email;
    public String displayName;
    public String role;
    public Language preferredLanguage;
}

// ─── Recipe Card (list view — lightweight) ────────────────────────────────────

@Data
class RecipeCardDto {
    public Long id;
    public String name;           // in requested language
    public String description;    // short description
    public String phonetic;       // pronunciation hint
    public String cuisineType;
    public String difficulty;
    public Integer prepTimeMinutes;
    public Integer cookTimeMinutes;
    public Integer spiceLevel;
    public Integer servings;
    public String imageUrl;
    public Boolean isFavourite;   // true if logged-in user saved this
    public Long favouriteCount;
}

// ─── Recipe Detail (full view) ────────────────────────────────────────────────

@Data
class RecipeDetailDto {
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
    public List<RecipeIngredientDto> ingredients;
    public List<RecipeStepDto> steps;
}

@Data
class RecipeIngredientDto {
    public Long ingredientId;
    public String name;           // in requested language
    public String asianName;      // always shown — helps in Asian supermarkets
    public String quantity;
    public String unit;
    public Boolean optional;
    public String imageUrl;
    public String whereToFind;    // in requested language
    public IngredientSubstituteDto substitute; // null if no substitute
}

@Data
class IngredientSubstituteDto {
    public Long id;
    public String name;
    public String asianName;
}

@Data
class RecipeStepDto {
    public Integer stepOrder;
    public String instruction;    // in requested language
    public String tip;            // optional cooking tip
    public String imageUrl;
    public Integer durationMinutes;
}

// ─── Admin: Create/Update Recipe ─────────────────────────────────────────────

@Data
class RecipeCreateRequest {
    @NotBlank public String cuisineType;
    @NotBlank public String difficulty;
    @NotNull  public Integer prepTimeMinutes;
    @NotNull  public Integer cookTimeMinutes;
    @NotNull  public Integer servings;
    public Integer spiceLevel = 0;

    // Translations map: key = "EN"/"FR"/"ZH_CN"
    @NotNull public Map<String, TranslationInput> translations;

    public List<RecipeIngredientInput> ingredients;
    public List<RecipeStepInput> steps;
}

@Data
class TranslationInput {
    @NotBlank public String name;
    public String description;
    public String phonetic;
}

@Data
class RecipeIngredientInput {
    @NotNull public Long ingredientId;
    public String quantity;
    public String unit;
    public Boolean optional = false;
    public Integer sortOrder = 0;
}

@Data
class RecipeStepInput {
    @NotNull public Integer stepOrder;
    public Integer durationMinutes;
    // Translations map: key = "EN"/"FR"/"ZH_CN"
    @NotNull public Map<String, StepTranslationInput> translations;
}

@Data
class StepTranslationInput {
    @NotBlank public String instruction;
    public String tip;
}

// ─── Paginated response wrapper ───────────────────────────────────────────────

@Data
class PagedResponse<T> {
    public List<T> content;
    public int page;
    public int size;
    public long totalElements;
    public int totalPages;
    public boolean last;
}

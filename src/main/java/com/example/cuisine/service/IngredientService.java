package com.example.cuisine.service;

import com.example.cuisine.dto.IngredientDto;
import com.example.cuisine.entity.*;
import com.example.cuisine.exception.ApiException;
import com.example.cuisine.repository.IngredientRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class IngredientService {

    private final IngredientRepository ingredientRepository;

    // ── Public: list ──────────────────────────────────────────────────────────

    public List<IngredientDto.DetailResponse> findAll(String category, String search, Language lang) {
        List<Ingredient> ingredients;
        if (search != null && !search.isBlank()) {
            ingredients = ingredientRepository.searchByLanguage(search, lang);
        } else if (category != null && !category.isBlank()) {
            ingredients = ingredientRepository.findByCategoryIgnoreCase(category);
        } else {
            ingredients = ingredientRepository.findAll();
        }
        return ingredients.stream().map(i -> toDetail(i, lang)).toList();
    }

    // ── Public: detail ────────────────────────────────────────────────────────

    public IngredientDto.DetailResponse findById(Long id, Language lang) {
        Ingredient ingredient = ingredientRepository.findByIdWithDetails(id)
                .orElseThrow(() -> new ApiException(HttpStatus.NOT_FOUND, "Ingredient not found"));
        return toDetail(ingredient, lang);
    }

    // ── Admin: create ─────────────────────────────────────────────────────────

    @Transactional
    public IngredientDto.DetailResponse create(IngredientDto.CreateRequest request) {
        Ingredient ingredient = new Ingredient();
        applyRequest(ingredient, request);
        return toDetail(ingredientRepository.save(ingredient), Language.EN);
    }

    // ── Admin: update ─────────────────────────────────────────────────────────

    @Transactional
    public IngredientDto.DetailResponse update(Long id, IngredientDto.CreateRequest request) {
        Ingredient ingredient = ingredientRepository.findByIdWithDetails(id)
                .orElseThrow(() -> new ApiException(HttpStatus.NOT_FOUND, "Ingredient not found"));
        ingredient.getTranslations().clear();
        applyRequest(ingredient, request);
        return toDetail(ingredientRepository.save(ingredient), Language.EN);
    }

    // ── Admin: delete ─────────────────────────────────────────────────────────

    @Transactional
    public void delete(Long id) {
        Ingredient ingredient = ingredientRepository.findById(id)
                .orElseThrow(() -> new ApiException(HttpStatus.NOT_FOUND, "Ingredient not found"));
        ingredientRepository.delete(ingredient);
    }

    // ── Admin: update image URL after S3 upload ───────────────────────────────

    @Transactional
    public void updateImageUrl(Long id, String imageUrl) {
        Ingredient ingredient = ingredientRepository.findById(id)
                .orElseThrow(() -> new ApiException(HttpStatus.NOT_FOUND, "Ingredient not found"));
        ingredient.setImageUrl(imageUrl);
        ingredientRepository.save(ingredient);
    }

    // ── Private helpers ───────────────────────────────────────────────────────

    private void applyRequest(Ingredient ingredient, IngredientDto.CreateRequest request) {
        ingredient.setAsianName(request.getAsianName());
        ingredient.setCategory(request.getCategory());
        ingredient.setJoybuyUrl(request.getJoybuyUrl());

        if (request.getSubstituteId() != null) {
            ingredient.setSubstitute(ingredientRepository.findById(request.getSubstituteId())
                    .orElseThrow(() -> new ApiException(HttpStatus.NOT_FOUND,
                            "Substitute ingredient not found: " + request.getSubstituteId())));
        } else {
            ingredient.setSubstitute(null);
        }

        if (request.getTranslations() != null) {
            request.getTranslations().forEach((langKey, input) -> {
                Language lang = Language.valueOf(langKey.toUpperCase().replace("-", "_"));
                IngredientTranslation t = new IngredientTranslation();
                t.setIngredient(ingredient);
                t.setLanguage(lang);
                t.setName(input.getName());
                t.setDescription(input.getDescription());
                t.setWhereToFind(input.getWhereToFind());
                ingredient.getTranslations().add(t);
            });
        }
    }

    IngredientDto.DetailResponse toDetail(Ingredient ingredient, Language lang) {
        IngredientTranslation t = ingredient.getTranslation(lang);
        IngredientDto.DetailResponse dto = new IngredientDto.DetailResponse();
        dto.setId(ingredient.getId());
        dto.setAsianName(ingredient.getAsianName());
        dto.setName(t != null ? t.getName() : ingredient.getAsianName());
        dto.setDescription(t != null ? t.getDescription() : null);
        dto.setWhereToFind(t != null ? t.getWhereToFind() : null);
        dto.setImageUrl(ingredient.getImageUrl());
        dto.setCategory(ingredient.getCategory());
        dto.setJoybuyUrl(ingredient.getJoybuyUrl());

        if (ingredient.getSubstitute() != null) {
            IngredientTranslation st = ingredient.getSubstitute().getTranslation(lang);
            IngredientDto.SubstituteResponse sub = new IngredientDto.SubstituteResponse();
            sub.setId(ingredient.getSubstitute().getId());
            sub.setName(st != null ? st.getName() : ingredient.getSubstitute().getAsianName());
            sub.setAsianName(ingredient.getSubstitute().getAsianName());
            dto.setSubstitute(sub);
        }
        return dto;
    }
}

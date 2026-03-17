package com.example.cuisine.controller;

import com.example.cuisine.dto.RecipeDto;
import com.example.cuisine.entity.Language;
import com.example.cuisine.service.RecipeService;
import com.example.cuisine.service.S3UploadService;
import com.example.cuisine.util.SecurityUtils;
import io.swagger.v3.oas.annotations.security.SecurityRequirements;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

@RestController
@RequestMapping("/api/v1/recipes")
@RequiredArgsConstructor
public class RecipeController {

    private final RecipeService recipeService;
    private final S3UploadService s3UploadService;

    /**
     * GET /api/v1/recipes
     * Public — browse all published recipes.
     *
     * Query params:
     *   lang        = EN | FR | ZH_CN  (default EN)
     *   cuisineType = CHINESE | JAPANESE | KOREAN | THAI | VIETNAMESE
     *   difficulty  = BEGINNER | INTERMEDIATE | ADVANCED
     *   maxSpice    = 0-5
     *   search      = full-text search in recipe names/descriptions
     *   page        = 0-based page number (default 0)
     *   size        = page size (default 12)
     */
    @GetMapping
    @SecurityRequirements
    public ResponseEntity<RecipeDto.PagedResponse> getAll(
            @RequestParam(defaultValue = "EN") String lang,
            @RequestParam(required = false) String cuisineType,
            @RequestParam(required = false) String difficulty,
            @RequestParam(required = false) Integer maxSpice,
            @RequestParam(required = false) String search,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "12") int size) {

        Language language = parseLanguage(lang);
        Long currentUserId = SecurityUtils.getCurrentUserId();

        return ResponseEntity.ok(recipeService.findAll(
                cuisineType, difficulty, maxSpice, search,
                language, page, size, currentUserId));
    }

    /**
     * GET /api/v1/recipes/{id}
     * Public — get full recipe detail with ingredients and steps.
     */
    @GetMapping("/{id}")
    @SecurityRequirements
    public ResponseEntity<RecipeDto.DetailResponse> getById(
            @PathVariable Long id,
            @RequestParam(defaultValue = "EN") String lang) {

        Language language = parseLanguage(lang);
        Long currentUserId = SecurityUtils.getCurrentUserId();
        return ResponseEntity.ok(recipeService.findById(id, language, currentUserId));
    }

    /**
     * POST /api/v1/recipes
     * Admin only — create a new recipe (starts as draft/unpublished).
     */
    @PostMapping
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<RecipeDto.DetailResponse> create(
            @Valid @RequestBody RecipeDto.CreateRequest request) {
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(recipeService.create(request));
    }

    /**
     * PUT /api/v1/recipes/{id}
     * Admin only — update an existing recipe.
     */
    @PutMapping("/{id}")
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<RecipeDto.DetailResponse> update(
            @PathVariable Long id,
            @Valid @RequestBody RecipeDto.CreateRequest request) {
        return ResponseEntity.ok(recipeService.update(id, request));
    }

    /**
     * PUT /api/v1/recipes/{id}/publish
     * Admin only — publish or unpublish a recipe.
     */
    @PutMapping("/{id}/publish")
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<Void> publish(
            @PathVariable Long id,
            @RequestParam(defaultValue = "true") boolean published) {
        recipeService.setPublished(id, published);
        return ResponseEntity.ok().build();
    }

    /**
     * POST /api/v1/recipes/{id}/image
     * Admin only — upload main dish photo to S3.
     */
    @PostMapping("/{id}/image")
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<String> uploadImage(
            @PathVariable Long id,
            @RequestParam("file") MultipartFile file) {
        String url = s3UploadService.uploadRecipeImage(id, file);
        recipeService.updateImageUrl(id, url);
        return ResponseEntity.ok(url);
    }

    /**
     * DELETE /api/v1/recipes/{id}
     * Admin only — permanently delete a recipe.
     */
    @DeleteMapping("/{id}")
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<Void> delete(@PathVariable Long id) {
        recipeService.delete(id);
        return ResponseEntity.noContent().build();
    }

    // ── Helpers ───────────────────────────────────────────────────────────────

    private Language parseLanguage(String lang) {
        try {
            return Language.valueOf(lang.toUpperCase().replace("-", "_"));
        } catch (IllegalArgumentException e) {
            return Language.EN; // fallback to English
        }
    }
}

package com.example.cuisine.controller;

import com.example.cuisine.dto.IngredientDto;
import com.example.cuisine.entity.Language;
import com.example.cuisine.service.IngredientService;
import com.example.cuisine.service.S3UploadService;
import io.swagger.v3.oas.annotations.security.SecurityRequirements;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@RestController
@RequestMapping("/api/v1/ingredients")
@RequiredArgsConstructor
public class IngredientController {

    private final IngredientService ingredientService;
    private final S3UploadService s3UploadService;

    /**
     * GET /api/v1/ingredients
     * Public — list all ingredients with optional filters.
     *
     * Query params:
     *   lang     = EN | FR | ZH_CN  (default EN)
     *   category = SAUCE | SPICE | VEGETABLE | PROTEIN | OIL | OTHER
     *   search   = name search in requested language
     */
    @GetMapping
    @SecurityRequirements
    public ResponseEntity<List<IngredientDto.DetailResponse>> getAll(
            @RequestParam(defaultValue = "EN") String lang,
            @RequestParam(required = false) String category,
            @RequestParam(required = false) String search) {
        return ResponseEntity.ok(ingredientService.findAll(category, search, parseLanguage(lang)));
    }

    /**
     * GET /api/v1/ingredients/{id}
     * Public — get ingredient detail with substitute info.
     */
    @GetMapping("/{id}")
    @SecurityRequirements
    public ResponseEntity<IngredientDto.DetailResponse> getById(
            @PathVariable Long id,
            @RequestParam(defaultValue = "EN") String lang) {
        return ResponseEntity.ok(ingredientService.findById(id, parseLanguage(lang)));
    }

    /**
     * POST /api/v1/ingredients
     * Admin only — create a new ingredient with translations.
     */
    @PostMapping
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<IngredientDto.DetailResponse> create(
            @Valid @RequestBody IngredientDto.CreateRequest request) {
        return ResponseEntity.status(HttpStatus.CREATED).body(ingredientService.create(request));
    }

    /**
     * PUT /api/v1/ingredients/{id}
     * Admin only — replace all translations and metadata.
     */
    @PutMapping("/{id}")
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<IngredientDto.DetailResponse> update(
            @PathVariable Long id,
            @Valid @RequestBody IngredientDto.CreateRequest request) {
        return ResponseEntity.ok(ingredientService.update(id, request));
    }

    /**
     * DELETE /api/v1/ingredients/{id}
     * Admin only — permanently delete an ingredient.
     */
    @DeleteMapping("/{id}")
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<Void> delete(@PathVariable Long id) {
        ingredientService.delete(id);
        return ResponseEntity.noContent().build();
    }

    /**
     * POST /api/v1/ingredients/{id}/image
     * Admin only — upload ingredient photo to S3.
     */
    @PostMapping("/{id}/image")
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<String> uploadImage(
            @PathVariable Long id,
            @RequestParam("file") MultipartFile file) {
        String url = s3UploadService.uploadIngredientImage(id, file);
        ingredientService.updateImageUrl(id, url);
        return ResponseEntity.ok(url);
    }

    // ── Helpers ───────────────────────────────────────────────────────────────

    private Language parseLanguage(String lang) {
        try {
            return Language.valueOf(lang.toUpperCase().replace("-", "_"));
        } catch (IllegalArgumentException e) {
            return Language.EN;
        }
    }
}

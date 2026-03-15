package com.example.cuisine.controller;

import com.example.cuisine.service.FavouriteService;
import com.example.cuisine.util.SecurityUtils;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/v1/favourites")
@RequiredArgsConstructor
public class FavouriteController {

    private final FavouriteService favouriteService;

    /**
     * GET /api/v1/favourites
     * Returns list of recipe IDs saved by the logged-in user.
     */
    @GetMapping
    public ResponseEntity<List<Long>> getMyFavourites() {
        Long userId = SecurityUtils.getRequiredCurrentUserId();
        return ResponseEntity.ok(favouriteService.getFavouriteRecipeIds(userId));
    }

    /**
     * POST /api/v1/favourites/{recipeId}
     * Save a recipe to favourites. Idempotent — safe to call multiple times.
     */
    @PostMapping("/{recipeId}")
    public ResponseEntity<Map<String, String>> addFavourite(@PathVariable Long recipeId) {
        Long userId = SecurityUtils.getRequiredCurrentUserId();
        favouriteService.addFavourite(userId, recipeId);
        return ResponseEntity.ok(Map.of("status", "saved"));
    }

    /**
     * DELETE /api/v1/favourites/{recipeId}
     * Remove a recipe from favourites.
     */
    @DeleteMapping("/{recipeId}")
    public ResponseEntity<Void> removeFavourite(@PathVariable Long recipeId) {
        Long userId = SecurityUtils.getRequiredCurrentUserId();
        favouriteService.removeFavourite(userId, recipeId);
        return ResponseEntity.noContent().build();
    }
}

package com.example.cuisine.service;

import com.example.cuisine.entity.Favourite;
import com.example.cuisine.entity.Recipe;
import com.example.cuisine.entity.User;
import com.example.cuisine.exception.ApiException;
import com.example.cuisine.repository.FavouriteRepository;
import com.example.cuisine.repository.RecipeRepository;
import com.example.cuisine.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
@Transactional
public class FavouriteService {

    private final FavouriteRepository favouriteRepository;
    private final RecipeRepository recipeRepository;
    private final UserRepository userRepository;

    public void addFavourite(Long userId, Long recipeId) {
        if (favouriteRepository.existsByUserIdAndRecipeId(userId, recipeId)) {
            return; // already saved — idempotent
        }
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new ApiException(HttpStatus.NOT_FOUND, "User not found"));
        Recipe recipe = recipeRepository.findById(recipeId)
                .orElseThrow(() -> new ApiException(HttpStatus.NOT_FOUND, "Recipe not found"));

        Favourite fav = new Favourite();
        fav.setUser(user);
        fav.setRecipe(recipe);
        favouriteRepository.save(fav);
    }

    public void removeFavourite(Long userId, Long recipeId) {
        favouriteRepository.deleteByUserIdAndRecipeId(userId, recipeId);
    }

    @Transactional(readOnly = true)
    public List<Long> getFavouriteRecipeIds(Long userId) {
        return favouriteRepository.findByUserId(userId).stream()
                .map(f -> f.getRecipe().getId())
                .toList();
    }
}

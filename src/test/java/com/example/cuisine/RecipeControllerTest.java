package com.example.cuisine;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.context.annotation.Import;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.web.servlet.MockMvc;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;
import static org.hamcrest.Matchers.*;

@SpringBootTest
@AutoConfigureMockMvc
@ActiveProfiles("test")
@Import(TestConfig.class)
class RecipeControllerTest {

    @Autowired MockMvc mockMvc;

    @Test
    void getAll_public_returnsEmptyList() throws Exception {
        mockMvc.perform(get("/api/v1/recipes"))
            .andExpect(status().isOk())
            .andExpect(jsonPath("$.content", notNullValue()))
            .andExpect(jsonPath("$.totalElements", greaterThanOrEqualTo(0)));
    }

    @Test
    void getAll_withLanguageParam_returnsOk() throws Exception {
        mockMvc.perform(get("/api/v1/recipes").param("lang", "FR"))
            .andExpect(status().isOk());
    }

    @Test
    void getAll_withChineseLanguage_returnsOk() throws Exception {
        mockMvc.perform(get("/api/v1/recipes").param("lang", "ZH_CN"))
            .andExpect(status().isOk());
    }

    @Test
    void getById_nonExistent_returns404() throws Exception {
        mockMvc.perform(get("/api/v1/recipes/99999"))
            .andExpect(status().isNotFound());
    }

    @Test
    void createRecipe_unauthenticated_returns403() throws Exception {
        mockMvc.perform(post("/api/v1/recipes")
                .contentType("application/json")
                .content("{}"))
            .andExpect(status().isForbidden());
    }

    @Test
    void addFavourite_unauthenticated_returns401or403() throws Exception {
        // Favourites require login — this triggers the soft login wall
        mockMvc.perform(post("/api/v1/favourites/1"))
            .andExpect(status().is4xxClientError());
    }
}

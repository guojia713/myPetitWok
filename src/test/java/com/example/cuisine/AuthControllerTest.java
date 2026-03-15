package com.example.cuisine;

import com.example.cuisine.dto.AuthDto;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.context.annotation.Import;
import org.springframework.http.MediaType;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.web.servlet.MockMvc;

import static org.hamcrest.Matchers.*;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@SpringBootTest
@AutoConfigureMockMvc
@ActiveProfiles("test")
@Import(TestConfig.class)
class AuthControllerTest {

    @Autowired MockMvc mockMvc;
    @Autowired ObjectMapper objectMapper;

    @Test
    void register_validRequest_returns201WithToken() throws Exception {
        AuthDto.RegisterRequest req = new AuthDto.RegisterRequest();
        req.setEmail("test@example.com");
        req.setPassword("password123");
        req.setDisplayName("Test User");

        mockMvc.perform(post("/api/v1/auth/register")
                .contentType(MediaType.APPLICATION_JSON)
                .content(objectMapper.writeValueAsString(req)))
            .andExpect(status().isCreated())
            .andExpect(jsonPath("$.token", notNullValue()))
            .andExpect(jsonPath("$.email", is("test@example.com")))
            .andExpect(jsonPath("$.role", is("ROLE_USER")));
    }

    @Test
    void register_duplicateEmail_returns409() throws Exception {
        AuthDto.RegisterRequest req = new AuthDto.RegisterRequest();
        req.setEmail("duplicate@example.com");
        req.setPassword("password123");

        // Register once
        mockMvc.perform(post("/api/v1/auth/register")
                .contentType(MediaType.APPLICATION_JSON)
                .content(objectMapper.writeValueAsString(req)))
            .andExpect(status().isCreated());

        // Register again — should fail
        mockMvc.perform(post("/api/v1/auth/register")
                .contentType(MediaType.APPLICATION_JSON)
                .content(objectMapper.writeValueAsString(req)))
            .andExpect(status().isConflict());
    }

    @Test
    void login_wrongPassword_returns401() throws Exception {
        // Register first
        AuthDto.RegisterRequest reg = new AuthDto.RegisterRequest();
        reg.setEmail("logintest@example.com");
        reg.setPassword("correctpassword");
        mockMvc.perform(post("/api/v1/auth/register")
                .contentType(MediaType.APPLICATION_JSON)
                .content(objectMapper.writeValueAsString(reg)))
            .andExpect(status().isCreated());

        // Login with wrong password
        AuthDto.LoginRequest login = new AuthDto.LoginRequest();
        login.setEmail("logintest@example.com");
        login.setPassword("wrongpassword");
        mockMvc.perform(post("/api/v1/auth/login")
                .contentType(MediaType.APPLICATION_JSON)
                .content(objectMapper.writeValueAsString(login)))
            .andExpect(status().isUnauthorized());
    }

    @Test
    void health_returnsUp() throws Exception {
        mockMvc.perform(get("/health"))
            .andExpect(status().isOk())
            .andExpect(jsonPath("$.status", is("UP")));
    }
}

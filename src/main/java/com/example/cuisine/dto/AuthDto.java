package com.example.cuisine.dto;

import com.example.cuisine.entity.Language;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import lombok.Data;

public class AuthDto {

    @Data
    public static class RegisterRequest {
        @Email @NotBlank public String email;
        @NotBlank public String password;
        public String displayName;
        public Language preferredLanguage = Language.EN;
    }

    @Data
    public static class LoginRequest {
        @Email @NotBlank public String email;
        @NotBlank public String password;
    }

    @Data
    public static class AuthResponse {
        public String token;
        public String email;
        public String displayName;
        public String role;
        public Language preferredLanguage;
    }
}

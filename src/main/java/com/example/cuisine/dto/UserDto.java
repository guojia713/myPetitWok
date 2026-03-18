package com.example.cuisine.dto;

import com.example.cuisine.entity.Language;
import lombok.Data;

public class UserDto {

    @Data
    public static class ProfileResponse {
        public Long id;
        public String email;
        public String displayName;
        public Language preferredLanguage;
    }

    @Data
    public static class UpdateRequest {
        public String displayName;
        public Language preferredLanguage;
    }
}

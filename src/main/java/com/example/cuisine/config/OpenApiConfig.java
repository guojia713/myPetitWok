package com.example.cuisine.config;

import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.Components;
import io.swagger.v3.oas.models.info.Info;
import io.swagger.v3.oas.models.info.Contact;
import io.swagger.v3.oas.models.security.SecurityRequirement;
import io.swagger.v3.oas.models.security.SecurityScheme;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class OpenApiConfig {

    @Bean
    public OpenAPI openAPI() {
        return new OpenAPI()
                .info(new Info()
                        .title("🍜 myPetitWok API")
                        .description("Asian cuisine recipes for European foodies — EN / FR / 中文")
                        .version("1.0.0")
                        .contact(new Contact().name("myPetitWok").email("admin@mypetitwok.com")))
                // This adds the JWT "Authorize" button to Swagger UI
                .addSecurityItem(new SecurityRequirement().addList("Bearer Token"))
                .components(new Components()
                        .addSecuritySchemes("Bearer Token", new SecurityScheme()
                                .type(SecurityScheme.Type.HTTP)
                                .scheme("bearer")
                                .bearerFormat("JWT")
                                .description("Paste your JWT token here — get it from POST /api/v1/auth/login")));
    }
}
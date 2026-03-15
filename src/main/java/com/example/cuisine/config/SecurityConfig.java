package com.example.cuisine.config;

import com.example.cuisine.security.JwtAuthFilter;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.CorsConfigurationSource;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;

import java.util.List;

@Configuration
@EnableWebSecurity
@EnableMethodSecurity
@RequiredArgsConstructor
public class SecurityConfig {

    private final JwtAuthFilter jwtAuthFilter;

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http
            .csrf(AbstractHttpConfigurer::disable)
            .cors(cors -> cors.configurationSource(corsConfigurationSource()))
            .sessionManagement(s -> s.sessionCreationPolicy(SessionCreationPolicy.STATELESS))
            .authorizeHttpRequests(auth -> auth

                // ── Public endpoints (no login needed) ──────────────────────
                .requestMatchers("/health", "/actuator/**").permitAll()
                .requestMatchers("/api/v1/auth/**").permitAll()

                // Browse recipes — public
                .requestMatchers(HttpMethod.GET, "/api/v1/recipes/**").permitAll()
                .requestMatchers(HttpMethod.GET, "/api/v1/ingredients/**").permitAll()

                // ── Authenticated users ──────────────────────────────────────
                // Favourites require login (soft login wall triggers here)
                .requestMatchers("/api/v1/favourites/**").authenticated()

                // ── Admin only ───────────────────────────────────────────────
                // Create, update, delete, publish, upload images
                .requestMatchers(HttpMethod.POST,   "/api/v1/recipes/**").hasRole("ADMIN")
                .requestMatchers(HttpMethod.PUT,    "/api/v1/recipes/**").hasRole("ADMIN")
                .requestMatchers(HttpMethod.DELETE, "/api/v1/recipes/**").hasRole("ADMIN")
                .requestMatchers(HttpMethod.POST,   "/api/v1/ingredients/**").hasRole("ADMIN")
                .requestMatchers(HttpMethod.PUT,    "/api/v1/ingredients/**").hasRole("ADMIN")
                .requestMatchers(HttpMethod.POST,   "/api/v1/upload/**").hasRole("ADMIN")
                //Swagger UI — allow public acces
                 .requestMatchers(
                                    "/swagger-ui.html",
                                    "/swagger-ui/**",
                                    "/v3/api-docs/**"
                            ).permitAll()
                .anyRequest().authenticated()
            )
            .addFilterBefore(jwtAuthFilter, UsernamePasswordAuthenticationFilter.class);

        return http.build();
    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    /**
     * CORS config — allows the React frontend to call this API.
     * In production, replace * with your actual frontend domain.
     */
    @Bean
    public CorsConfigurationSource corsConfigurationSource() {
        CorsConfiguration config = new CorsConfiguration();
        config.setAllowedOriginPatterns(List.of("*")); // tighten in production
        config.setAllowedMethods(List.of("GET","POST","PUT","DELETE","OPTIONS"));
        config.setAllowedHeaders(List.of("*"));
        config.setAllowCredentials(true);

        UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
        source.registerCorsConfiguration("/**", config);
        return source;
    }
}

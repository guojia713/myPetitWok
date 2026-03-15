package com.example.cuisine.controller;

import com.example.cuisine.dto.AuthDto;
import com.example.cuisine.service.AuthService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1/auth")
@RequiredArgsConstructor
public class AuthController {

    private final AuthService authService;

    @PostMapping("/register")
    public ResponseEntity<AuthDto.AuthResponse> register(
            @Valid @RequestBody AuthDto.RegisterRequest request) {
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(authService.register(request));
    }

    @PostMapping("/login")
    public ResponseEntity<AuthDto.AuthResponse> login(
            @Valid @RequestBody AuthDto.LoginRequest request) {
        return ResponseEntity.ok(authService.login(request));
    }
}

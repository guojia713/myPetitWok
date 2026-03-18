package com.example.cuisine.controller;

import com.example.cuisine.dto.UserDto;
import com.example.cuisine.service.UserService;
import com.example.cuisine.util.SecurityUtils;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1/me")
@RequiredArgsConstructor
public class UserController {

    private final UserService userService;

    /**
     * GET /api/v1/me
     * Authenticated — return current user's profile.
     */
    @GetMapping
    public ResponseEntity<UserDto.ProfileResponse> getProfile() {
        return ResponseEntity.ok(userService.getProfile(SecurityUtils.getCurrentUserId()));
    }

    /**
     * PUT /api/v1/me
     * Authenticated — update display name and/or preferred language.
     */
    @PutMapping
    public ResponseEntity<UserDto.ProfileResponse> updateProfile(
            @RequestBody UserDto.UpdateRequest request) {
        return ResponseEntity.ok(userService.updateProfile(SecurityUtils.getCurrentUserId(), request));
    }
}

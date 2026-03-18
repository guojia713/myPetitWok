package com.example.cuisine.service;

import com.example.cuisine.dto.UserDto;
import com.example.cuisine.entity.User;
import com.example.cuisine.exception.ApiException;
import com.example.cuisine.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class UserService {

    private final UserRepository userRepository;

    public UserDto.ProfileResponse getProfile(Long userId) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new ApiException(HttpStatus.NOT_FOUND, "User not found"));
        return toResponse(user);
    }

    @Transactional
    public UserDto.ProfileResponse updateProfile(Long userId, UserDto.UpdateRequest request) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new ApiException(HttpStatus.NOT_FOUND, "User not found"));
        if (request.getDisplayName() != null) {
            user.setDisplayName(request.getDisplayName());
        }
        if (request.getPreferredLanguage() != null) {
            user.setPreferredLanguage(request.getPreferredLanguage());
        }
        return toResponse(userRepository.save(user));
    }

    private UserDto.ProfileResponse toResponse(User user) {
        UserDto.ProfileResponse dto = new UserDto.ProfileResponse();
        dto.setId(user.getId());
        dto.setEmail(user.getEmail());
        dto.setDisplayName(user.getDisplayName());
        dto.setPreferredLanguage(user.getPreferredLanguage());
        return dto;
    }
}

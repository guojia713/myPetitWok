package com.example.cuisine.service;

import com.example.cuisine.dto.AuthDto;
import com.example.cuisine.entity.User;
import com.example.cuisine.exception.ApiException;
import com.example.cuisine.repository.UserRepository;
import com.example.cuisine.security.JwtService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class AuthService {

    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;
    private final JwtService jwtService;

    @Transactional
    public AuthDto.AuthResponse register(AuthDto.RegisterRequest request) {
        if (userRepository.existsByEmail(request.getEmail())) {
            throw new ApiException(HttpStatus.CONFLICT, "Email already in use");
        }

        User user = new User();
        user.setEmail(request.getEmail());
        user.setPassword(passwordEncoder.encode(request.getPassword()));
        user.setDisplayName(request.getDisplayName());
        user.setPreferredLanguage(request.getPreferredLanguage());
        user.setRole("ROLE_USER");

        userRepository.save(user);
        return buildAuthResponse(user);
    }

    public AuthDto.AuthResponse login(AuthDto.LoginRequest request) {
        User user = userRepository.findByEmail(request.getEmail())
                .orElseThrow(() -> new ApiException(HttpStatus.UNAUTHORIZED, "Invalid email or password"));

        if (!passwordEncoder.matches(request.getPassword(), user.getPassword())) {
            throw new ApiException(HttpStatus.UNAUTHORIZED, "Invalid email or password");
        }

        if (!user.getEnabled()) {
            throw new ApiException(HttpStatus.FORBIDDEN, "Account is disabled");
        }

        return buildAuthResponse(user);
    }

    private AuthDto.AuthResponse buildAuthResponse(User user) {
        String token = jwtService.generateToken(user.getEmail(), user.getRole());
        AuthDto.AuthResponse response = new AuthDto.AuthResponse();
        response.setToken(token);
        response.setEmail(user.getEmail());
        response.setDisplayName(user.getDisplayName());
        response.setRole(user.getRole());
        response.setPreferredLanguage(user.getPreferredLanguage());
        return response;
    }
}

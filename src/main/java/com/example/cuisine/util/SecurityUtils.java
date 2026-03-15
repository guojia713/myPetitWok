package com.example.cuisine.util;

import com.example.cuisine.exception.ApiException;
import com.example.cuisine.repository.UserRepository;
import org.springframework.http.HttpStatus;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;

/**
 * Utility to get the current authenticated user from the SecurityContext.
 * The JWT filter populates this on every authenticated request.
 */
public class SecurityUtils {

    private static UserRepository userRepository;

    // Called by Spring to inject the repository (see AppConfig)
    public static void setUserRepository(UserRepository repo) {
        userRepository = repo;
    }

    /**
     * Returns current user's ID, or null if not authenticated (anonymous browsing).
     */
    public static Long getCurrentUserId() {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth == null || !auth.isAuthenticated() ||
                "anonymousUser".equals(auth.getPrincipal())) {
            return null;
        }
        String email = (String) auth.getPrincipal();
        return userRepository.findByEmail(email).map(u -> u.getId()).orElse(null);
    }

    /**
     * Returns current user's ID — throws 401 if not authenticated.
     * Use for endpoints that require login (favourites, profile).
     */
    public static Long getRequiredCurrentUserId() {
        Long id = getCurrentUserId();
        if (id == null) {
            throw new ApiException(HttpStatus.UNAUTHORIZED, "Authentication required");
        }
        return id;
    }

    public static String getCurrentUserEmail() {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth == null || !auth.isAuthenticated()) return null;
        return (String) auth.getPrincipal();
    }
}

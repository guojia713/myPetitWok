package com.example.cuisine.service;

import com.example.cuisine.exception.ApiException;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import software.amazon.awssdk.core.sync.RequestBody;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.DeleteObjectRequest;
import software.amazon.awssdk.services.s3.model.PutObjectRequest;

import java.io.IOException;
import java.util.List;
import java.util.UUID;

/**
 * Handles image uploads to AWS S3.
 *
 * Uploaded images are publicly readable via CloudFront or direct S3 URL.
 * Images are organized in folders:
 *   recipes/{recipeId}/main.jpg       ← main dish photo
 *   recipes/{recipeId}/step-{n}.jpg   ← step-by-step photos
 *   ingredients/{ingredientId}.jpg    ← ingredient photo
 */
@Service
@RequiredArgsConstructor
public class S3UploadService {

    private final S3Client s3Client;

    @Value("${aws.s3.bucket}")
    private String bucket;

    @Value("${aws.s3.base-url}")
    private String baseUrl; // e.g. https://your-bucket.s3.eu-west-1.amazonaws.com

    private static final List<String> ALLOWED_TYPES = List.of(
            "image/jpeg", "image/png", "image/webp"
    );
    private static final long MAX_SIZE_BYTES = 5 * 1024 * 1024; // 5MB

    /**
     * Upload a recipe main photo.
     * Returns the public URL of the uploaded image.
     */
    public String uploadRecipeImage(Long recipeId, MultipartFile file) {
        String key = "recipes/" + recipeId + "/main-" + UUID.randomUUID() + getExtension(file);
        return upload(file, key);
    }

    /**
     * Upload a recipe step photo.
     */
    public String uploadStepImage(Long recipeId, int stepOrder, MultipartFile file) {
        String key = "recipes/" + recipeId + "/step-" + stepOrder + "-" + UUID.randomUUID() + getExtension(file);
        return upload(file, key);
    }

    /**
     * Upload an ingredient photo.
     */
    public String uploadIngredientImage(Long ingredientId, MultipartFile file) {
        String key = "ingredients/" + ingredientId + "-" + UUID.randomUUID() + getExtension(file);
        return upload(file, key);
    }

    /**
     * Delete an image from S3 by its full URL.
     */
    public void deleteByUrl(String imageUrl) {
        if (imageUrl == null || !imageUrl.startsWith(baseUrl)) return;
        String key = imageUrl.substring(baseUrl.length() + 1);
        s3Client.deleteObject(DeleteObjectRequest.builder()
                .bucket(bucket)
                .key(key)
                .build());
    }

    // ── Private helpers ───────────────────────────────────────────────────────

    private String upload(MultipartFile file, String key) {
        validate(file);
        try {
            PutObjectRequest request = PutObjectRequest.builder()
                    .bucket(bucket)
                    .key(key)
                    .contentType(file.getContentType())
                    .contentLength(file.getSize())
                    .build();

            s3Client.putObject(request, RequestBody.fromBytes(file.getBytes()));
            return baseUrl + "/" + key;

        } catch (IOException e) {
            throw new ApiException(HttpStatus.INTERNAL_SERVER_ERROR, "Failed to upload image");
        }
    }

    private void validate(MultipartFile file) {
        if (file == null || file.isEmpty()) {
            throw new ApiException(HttpStatus.BAD_REQUEST, "File is empty");
        }
        if (!ALLOWED_TYPES.contains(file.getContentType())) {
            throw new ApiException(HttpStatus.BAD_REQUEST,
                    "Only JPEG, PNG, and WebP images are allowed");
        }
        if (file.getSize() > MAX_SIZE_BYTES) {
            throw new ApiException(HttpStatus.BAD_REQUEST, "Image must be under 5MB");
        }
    }

    private String getExtension(MultipartFile file) {
        String ct = file.getContentType();
        if (ct == null) return ".jpg";
        return switch (ct) {
            case "image/png"  -> ".png";
            case "image/webp" -> ".webp";
            default           -> ".jpg";
        };
    }
}

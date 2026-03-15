package com.example.cuisine.config;

import com.example.cuisine.repository.UserRepository;
import com.example.cuisine.util.SecurityUtils;
import jakarta.annotation.PostConstruct;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Lazy;
import software.amazon.awssdk.auth.credentials.DefaultCredentialsProvider;
import software.amazon.awssdk.regions.Region;
import software.amazon.awssdk.services.s3.S3Client;

@Configuration
public class AppConfig {

    @Autowired @Lazy
    private UserRepository userRepository;

    @Value("${aws.region:eu-west-1}")
    private String awsRegion;

    // Wire UserRepository into SecurityUtils static helper
    @PostConstruct
    public void initSecurityUtils() {
        SecurityUtils.setUserRepository(userRepository);
    }

    @Bean
    public S3Client s3Client() {
        return S3Client.builder()
                .region(Region.of(awsRegion))
                .credentialsProvider(DefaultCredentialsProvider.create())
                .build();
    }
}

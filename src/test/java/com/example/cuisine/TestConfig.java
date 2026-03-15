package com.example.cuisine;

import org.springframework.boot.test.context.TestConfiguration;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Primary;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.ssm.SsmClient;

import static org.mockito.Mockito.mock;

@TestConfiguration
public class TestConfig {

    // Replace the real S3Client with a mock during tests
    // This prevents AWS SDK from trying to connect to AWS
    @Bean
    @Primary
    public S3Client s3Client() {
        return mock(S3Client.class);
    }

    // Mock the SSM client (Parameter Store) to prevent bootstrap connection attempts
    @Bean
    @Primary
    public SsmClient ssmClient() {
        return mock(SsmClient.class);
    }
}
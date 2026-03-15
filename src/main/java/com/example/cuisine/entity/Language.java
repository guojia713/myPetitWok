package com.example.cuisine.entity;

/**
 * Supported languages.
 * Adding a new language = adding a new enum value + new translation rows in DB.
 * Zero code changes needed anywhere else.
 */
public enum Language {
    EN,     // English (default)
    FR,     // French
    ZH_CN   // Simplified Chinese
}

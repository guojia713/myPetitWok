-- ============================================================
-- V1: Initial schema
-- Asian Cuisine API — multilingual recipe platform
-- ============================================================

-- Users
CREATE TABLE users (
    id                 BIGSERIAL PRIMARY KEY,
    email              VARCHAR(255) NOT NULL UNIQUE,
    password           VARCHAR(255) NOT NULL,
    display_name       VARCHAR(100),
    preferred_language VARCHAR(10)  NOT NULL DEFAULT 'EN',
    role               VARCHAR(20)  NOT NULL DEFAULT 'ROLE_USER',
    enabled            BOOLEAN      NOT NULL DEFAULT TRUE,
    created_at         TIMESTAMP    NOT NULL DEFAULT NOW()
);

-- Recipes (language-agnostic core data)
CREATE TABLE recipes (
    id                  BIGSERIAL PRIMARY KEY,
    cuisine_type        VARCHAR(50)  NOT NULL,
    difficulty          VARCHAR(20)  NOT NULL,
    prep_time_minutes   INT          NOT NULL,
    cook_time_minutes   INT          NOT NULL,
    servings            INT          NOT NULL,
    spice_level         INT          NOT NULL DEFAULT 0,
    image_url           TEXT,
    published           BOOLEAN      NOT NULL DEFAULT FALSE,
    created_at          TIMESTAMP    NOT NULL DEFAULT NOW(),
    updated_at          TIMESTAMP    NOT NULL DEFAULT NOW()
);

-- Recipe translations (name + description per language)
CREATE TABLE recipe_translations (
    id          BIGSERIAL PRIMARY KEY,
    recipe_id   BIGINT       NOT NULL REFERENCES recipes(id) ON DELETE CASCADE,
    language    VARCHAR(10)  NOT NULL,
    name        VARCHAR(255) NOT NULL,
    description TEXT,
    phonetic    VARCHAR(255),
    UNIQUE (recipe_id, language)
);

-- Ingredients (language-agnostic)
CREATE TABLE ingredients (
    id            BIGSERIAL PRIMARY KEY,
    asian_name    VARCHAR(255) NOT NULL,
    image_url     TEXT,
    category      VARCHAR(50),
    substitute_id BIGINT REFERENCES ingredients(id) ON DELETE SET NULL
);

-- Ingredient translations
CREATE TABLE ingredient_translations (
    id            BIGSERIAL PRIMARY KEY,
    ingredient_id BIGINT       NOT NULL REFERENCES ingredients(id) ON DELETE CASCADE,
    language      VARCHAR(10)  NOT NULL,
    name          VARCHAR(255) NOT NULL,
    description   TEXT,
    where_to_find TEXT,
    UNIQUE (ingredient_id, language)
);

-- Recipe <-> Ingredient join (with quantity)
CREATE TABLE recipe_ingredients (
    id            BIGSERIAL PRIMARY KEY,
    recipe_id     BIGINT       NOT NULL REFERENCES recipes(id) ON DELETE CASCADE,
    ingredient_id BIGINT       NOT NULL REFERENCES ingredients(id),
    quantity      VARCHAR(20),
    unit          VARCHAR(20),
    optional      BOOLEAN      NOT NULL DEFAULT FALSE,
    sort_order    INT          NOT NULL DEFAULT 0
);

-- Recipe steps
CREATE TABLE recipe_steps (
    id               BIGSERIAL PRIMARY KEY,
    recipe_id        BIGINT  NOT NULL REFERENCES recipes(id) ON DELETE CASCADE,
    step_order       INT     NOT NULL,
    image_url        TEXT,
    duration_minutes INT,
    UNIQUE (recipe_id, step_order)
);

-- Recipe step translations
CREATE TABLE recipe_step_translations (
    id          BIGSERIAL PRIMARY KEY,
    step_id     BIGINT      NOT NULL REFERENCES recipe_steps(id) ON DELETE CASCADE,
    language    VARCHAR(10) NOT NULL,
    instruction TEXT        NOT NULL,
    tip         TEXT,
    UNIQUE (step_id, language)
);

-- Favourites
CREATE TABLE favourites (
    id        BIGSERIAL PRIMARY KEY,
    user_id   BIGINT    NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    recipe_id BIGINT    NOT NULL REFERENCES recipes(id) ON DELETE CASCADE,
    saved_at  TIMESTAMP NOT NULL DEFAULT NOW(),
    UNIQUE (user_id, recipe_id)
);

-- ── Indexes for performance ───────────────────────────────────────────────────
CREATE INDEX idx_recipes_published       ON recipes(published);
CREATE INDEX idx_recipes_cuisine         ON recipes(cuisine_type);
CREATE INDEX idx_recipes_difficulty      ON recipes(difficulty);
CREATE INDEX idx_recipe_trans_lang       ON recipe_translations(language);
CREATE INDEX idx_ingredient_trans_lang   ON ingredient_translations(language);
CREATE INDEX idx_favourites_user         ON favourites(user_id);
CREATE INDEX idx_favourites_recipe       ON favourites(recipe_id);

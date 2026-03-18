# 🍜 myPetitWok — Backend API

A production-ready Spring Boot REST API for an Asian cooking app targeting European audiences.

**Features:**
- 🌍 Multilingual content (English, French, Simplified Chinese)
- 🔐 JWT authentication with soft login wall
- 👨‍🍳 Admin recipe + ingredient management with S3 image support
- 🔍 Full-text recipe search with cuisine/difficulty/spice filters
- ❤️ User favourites system
- 👤 User profile (display name, preferred language)
- 🛒 Joybuy affiliate links on ingredients
- 🗄️ Flyway database migrations
- ☁️ AWS-ready (Elastic Beanstalk + RDS + S3)

---

## 🚀 Quick Start (Local)

```bash
# Start PostgreSQL + app
docker compose up -d

# Test it
curl http://localhost:8080/health
curl "http://localhost:8080/api/v1/recipes?lang=FR"
curl "http://localhost:8080/api/v1/ingredients?lang=EN"
```

Swagger UI: http://localhost:8080/swagger-ui/index.html

---

## 🔌 API Reference

### Auth
| Method | URL | Auth | Description |
|--------|-----|------|-------------|
| POST | `/api/v1/auth/register` | None | Create account |
| POST | `/api/v1/auth/login` | None | Login, get JWT token |

### Recipes (Public)
| Method | URL | Auth | Description |
|--------|-----|------|-------------|
| GET | `/api/v1/recipes` | None | List recipes (paginated) |
| GET | `/api/v1/recipes/{id}` | None | Full recipe detail |

**Query parameters for GET /api/v1/recipes:**
```
lang        = EN | FR | ZH_CN          (default: EN)
cuisineType = CHINESE | JAPANESE | KOREAN | THAI | VIETNAMESE
difficulty  = BEGINNER | INTERMEDIATE | ADVANCED
maxSpice    = 0-5
search      = full-text search term
page        = 0-based page (default: 0)
size        = items per page (default: 12)
```

### Ingredients (Public)
| Method | URL | Auth | Description |
|--------|-----|------|-------------|
| GET | `/api/v1/ingredients` | None | List all ingredients |
| GET | `/api/v1/ingredients/{id}` | None | Ingredient detail |

**Query parameters for GET /api/v1/ingredients:**
```
lang     = EN | FR | ZH_CN  (default: EN)
category = SAUCE | SPICE | VEGETABLE | PROTEIN | OIL | OTHER
search   = name search in requested language
```

### User Profile (Requires login)
| Method | URL | Auth | Description |
|--------|-----|------|-------------|
| GET | `/api/v1/me` | JWT | Get my profile |
| PUT | `/api/v1/me` | JWT | Update display name / preferred language |

### Favourites (Requires login)
| Method | URL | Auth | Description |
|--------|-----|------|-------------|
| GET | `/api/v1/favourites` | JWT | Get my saved recipe IDs |
| POST | `/api/v1/favourites/{recipeId}` | JWT | Save a recipe |
| DELETE | `/api/v1/favourites/{recipeId}` | JWT | Unsave a recipe |

### Admin — Recipes (Requires ROLE_ADMIN)
| Method | URL | Auth | Description |
|--------|-----|------|-------------|
| POST | `/api/v1/recipes` | Admin JWT | Create recipe (draft) |
| PUT | `/api/v1/recipes/{id}` | Admin JWT | Update recipe |
| PUT | `/api/v1/recipes/{id}/publish?published=true` | Admin JWT | Publish/unpublish |
| POST | `/api/v1/recipes/{id}/image` | Admin JWT | Upload main photo |
| POST | `/api/v1/recipes/{id}/steps/{stepOrder}/image` | Admin JWT | Upload step photo |
| DELETE | `/api/v1/recipes/{id}` | Admin JWT | Delete recipe |

### Admin — Ingredients (Requires ROLE_ADMIN)
| Method | URL | Auth | Description |
|--------|-----|------|-------------|
| POST | `/api/v1/ingredients` | Admin JWT | Create ingredient |
| PUT | `/api/v1/ingredients/{id}` | Admin JWT | Update ingredient |
| DELETE | `/api/v1/ingredients/{id}` | Admin JWT | Delete ingredient |
| POST | `/api/v1/ingredients/{id}/image` | Admin JWT | Upload ingredient photo |

---

## 🔐 Making Yourself Admin

After registering your account, run this SQL on your database:

```sql
UPDATE users SET role = 'ROLE_ADMIN' WHERE email = 'your@email.com';
```

---

## 🌍 Adding a Recipe (3 languages)

```bash
# 1. Login as admin
TOKEN=$(curl -s -X POST http://localhost:8080/api/v1/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email":"admin@example.com","password":"yourpassword"}' \
  | jq -r '.token')

# 2. Create recipe
curl -X POST http://localhost:8080/api/v1/recipes \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "cuisineType": "JAPANESE",
    "difficulty": "BEGINNER",
    "prepTimeMinutes": 15,
    "cookTimeMinutes": 30,
    "servings": 2,
    "spiceLevel": 1,
    "translations": {
      "EN": { "name": "Miso Soup", "description": "A classic Japanese comfort soup." },
      "FR": { "name": "Soupe Miso", "description": "Une soupe réconfortante japonaise classique." },
      "ZH_CN": { "name": "味噌汤", "description": "经典的日式家常汤品。", "phonetic": "Wèi zēng tāng" }
    },
    "ingredients": [
      { "ingredientId": 9, "quantity": "150", "unit": "g", "optional": false, "sortOrder": 1 }
    ],
    "steps": [
      {
        "stepOrder": 1,
        "translations": {
          "EN": { "instruction": "Heat water to just below boiling.", "tip": "Never boil miso." },
          "FR": { "instruction": "Chauffez l'\''eau juste en dessous du point d'\''ébullition.", "tip": "Ne faites jamais bouillir le miso." },
          "ZH_CN": { "instruction": "将水加热至接近沸腾但不沸腾的状态。", "tip": "味噌绝对不能煮沸。" }
        }
      }
    ]
  }'

# 3. Publish it
curl -X PUT "http://localhost:8080/api/v1/recipes/4/publish?published=true" \
  -H "Authorization: Bearer $TOKEN"

# 4. Upload photo
curl -X POST http://localhost:8080/api/v1/recipes/4/image \
  -H "Authorization: Bearer $TOKEN" \
  -F "file=@/path/to/photo.jpg"
```

---

## 🗂️ Project Structure

```
src/main/java/com/example/cuisine/
├── config/
│   ├── SecurityConfig.java        ← JWT + CORS + endpoint rules
│   ├── AppConfig.java             ← S3 client, SecurityUtils wiring
│   └── OpenApiConfig.java         ← Swagger / OpenAPI setup
├── controller/
│   ├── AuthController.java        ← /api/v1/auth/*
│   ├── RecipeController.java      ← /api/v1/recipes/*
│   ├── IngredientController.java  ← /api/v1/ingredients/*
│   ├── UserController.java        ← /api/v1/me
│   ├── FavouriteController.java   ← /api/v1/favourites/*
│   └── HealthController.java      ← /health
├── dto/
│   ├── AuthDto.java
│   ├── RecipeDto.java
│   ├── IngredientDto.java
│   └── UserDto.java
├── entity/
│   ├── Language.java              ← EN, FR, ZH_CN enum
│   ├── Recipe.java
│   ├── RecipeTranslation.java
│   ├── Ingredient.java            ← With substitute + joybuyUrl
│   ├── IngredientTranslation.java
│   ├── RecipeStep.java
│   ├── RecipeStepTranslation.java
│   ├── RecipeIngredient.java
│   ├── User.java
│   └── Favourite.java
├── repository/
│   ├── RecipeRepository.java
│   ├── RecipeStepRepository.java
│   ├── IngredientRepository.java
│   ├── UserRepository.java
│   └── FavouriteRepository.java
├── security/
│   ├── JwtService.java
│   └── JwtAuthFilter.java
├── service/
│   ├── AuthService.java
│   ├── RecipeService.java
│   ├── IngredientService.java
│   ├── UserService.java
│   ├── FavouriteService.java
│   └── S3UploadService.java
└── util/
    └── SecurityUtils.java

src/main/resources/
├── application.properties         ← Production (AWS)
├── application-local.properties   ← Local dev
├── application-test.properties    ← Tests (H2)
└── db/migration/
    ├── V1__initial_schema.sql     ← All tables + indexes
    ├── V2__seed_ingredients.sql   ← 20 core ingredients EN/FR/ZH_CN
    ├── V3__seed_recipes.sql       ← 3 starter recipes EN/FR/ZH_CN
    ├── V4__add_joybuy_url_to_ingredients.sql
    └── V5__seed_expansion.sql     ← 15 ingredients + 12 recipes (all 5 cuisines)
```

---

## ☁️ AWS Environment Variables

Set these in Elastic Beanstalk → Configuration → Software:

```
SERVER_PORT   = 5000
DB_URL        = jdbc:postgresql://<rds-endpoint>:5432/myPetitWok
DB_USERNAME   = youruser
DB_PASSWORD   = yourpassword
JWT_SECRET    = <random 64-char string>
AWS_REGION    = eu-west-1
S3_BUCKET     = your-bucket-name
S3_BASE_URL   = https://your-bucket.s3.eu-west-1.amazonaws.com
```

---

## 🧪 Run Tests

```bash
./mvnw test
# Uses H2 in-memory DB — no PostgreSQL or AWS needed
```

---

## 📦 Seed Data

| Migration | Content |
|-----------|---------|
| V2 | 20 core ingredients + 5 substitutes (EN/FR/ZH_CN) |
| V3 | 3 recipes: Mapo Tofu, Kung Pao Chicken, Vietnamese Beef Pho |
| V5 | 15 new ingredients + 12 new recipes across all 5 cuisines |

**Total: 35 ingredients, 15 published recipes**

Cuisines covered: 🇨🇳 Chinese · 🇯🇵 Japanese · 🇰🇷 Korean · 🇹🇭 Thai · 🇻🇳 Vietnamese

---

## 🗺️ Roadmap

### ✅ Sprint 1 — Backend MVP
- JWT auth, recipe CRUD, multilingual content, ingredients with substitutes
- Recipe steps with tips, favourites, S3 image upload
- Flyway migrations, Docker setup, 3 seed recipes

### ✅ Sprint 2 — Backend Completion
- Ingredient endpoints (public list + detail, admin CRUD + image upload)
- Recipe step image upload (`POST /recipes/{id}/steps/{stepOrder}/image`)
- User profile endpoints (`GET/PUT /api/v1/me`)
- Joybuy affiliate link on ingredients
- Seed data expanded to 15 recipes across all 5 cuisines

### 📱 Sprint 3 — Expo Mobile App (next)
- React Native + Expo + Expo Router + NativeWind + TanStack Query
- Recipe list (card grid, filters, search), recipe detail screen
- Language switcher EN/FR/ZH_CN

### 🔐 Sprint 4 — Auth + Favourites (mobile)
### 👨‍🍳 Sprint 5 — Admin screens (mobile)
### ⭐ Sprint 6 — Growth features
### 🚀 Sprint 7 — Production launch

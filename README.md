# 🍜 Asian Cuisine API

A production-ready Spring Boot REST API for an Asian cooking app targeting European audiences.

**Features:**
- 🌍 Multilingual content (English, French, Simplified Chinese)
- 🔐 JWT authentication with soft login wall
- 👨‍🍳 Admin recipe upload with S3 image support
- 🔍 Full-text recipe search with cuisine/difficulty/spice filters
- ❤️ User favourites system
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
curl "http://localhost:8080/api/v1/recipes?lang=ZH_CN"
```

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

### Favourites (Requires login)
| Method | URL | Auth | Description |
|--------|-----|------|-------------|
| GET | `/api/v1/favourites` | JWT | Get my saved recipe IDs |
| POST | `/api/v1/favourites/{recipeId}` | JWT | Save a recipe |
| DELETE | `/api/v1/favourites/{recipeId}` | JWT | Unsave a recipe |

### Admin (Requires ROLE_ADMIN)
| Method | URL | Auth | Description |
|--------|-----|------|-------------|
| POST | `/api/v1/recipes` | Admin JWT | Create recipe (draft) |
| PUT | `/api/v1/recipes/{id}` | Admin JWT | Update recipe |
| PUT | `/api/v1/recipes/{id}/publish?published=true` | Admin JWT | Publish/unpublish |
| POST | `/api/v1/recipes/{id}/image` | Admin JWT | Upload main photo |
| DELETE | `/api/v1/recipes/{id}` | Admin JWT | Delete recipe |

---

## 🔐 Making Yourself Admin

After registering your account, run this SQL on your RDS database:

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
          "EN": { "instruction": "Heat water to just below boiling.", "tip": "Never boil miso — it destroys the probiotics." },
          "FR": { "instruction": "Chauffez l'\''eau juste en dessous du point d'\''ébullition.", "tip": "Ne faites jamais bouillir le miso — cela détruit les probiotiques." },
          "ZH_CN": { "instruction": "将水加热至接近沸腾但不沸腾的状态。", "tip": "味噌绝对不能煮沸，否则会破坏其中的益生菌。" }
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
  -F "file=@/path/to/miso-soup.jpg"
```

---

## 🗂️ Project Structure

```
src/main/java/com/example/cuisine/
├── AsianCuisineApplication.java
├── config/
│   ├── SecurityConfig.java        ← JWT + CORS + endpoint rules
│   └── AppConfig.java             ← S3 client, SecurityUtils wiring
├── controller/
│   ├── AuthController.java        ← /api/v1/auth/*
│   ├── RecipeController.java      ← /api/v1/recipes/*
│   ├── FavouriteController.java   ← /api/v1/favourites/*
│   └── HealthController.java      ← /health
├── dto/
│   ├── AuthDto.java
│   ├── RecipeDto.java
│   └── IngredientDto.java
├── entity/
│   ├── Language.java              ← EN, FR, ZH_CN enum
│   ├── Recipe.java                ← Core recipe (no text)
│   ├── RecipeTranslation.java     ← Name + description per language
│   ├── Ingredient.java            ← With substitute linking
│   ├── IngredientTranslation.java ← Name + where to find per language
│   ├── RecipeStep.java            ← Step with optional photo
│   ├── RecipeStepTranslation.java ← Instruction + tip per language
│   ├── RecipeIngredient.java      ← Quantity join table
│   ├── User.java                  ← With ROLE_USER / ROLE_ADMIN
│   └── Favourite.java             ← User saved recipes
├── exception/
│   ├── ApiException.java
│   └── GlobalExceptionHandler.java
├── repository/
│   ├── RecipeRepository.java      ← Search + filter queries
│   ├── IngredientRepository.java
│   ├── UserRepository.java
│   └── FavouriteRepository.java
├── security/
│   ├── JwtService.java            ← Generate + validate tokens
│   └── JwtAuthFilter.java         ← Intercept every request
├── service/
│   ├── AuthService.java
│   ├── RecipeService.java         ← Language-aware DTO mapping
│   ├── FavouriteService.java
│   └── S3UploadService.java
└── util/
    └── SecurityUtils.java         ← Get current user from context

src/main/resources/
├── application.properties         ← Production (AWS)
├── application-local.properties   ← Local dev
├── application-test.properties    ← Tests (H2)
└── db/migration/
    ├── V1__initial_schema.sql     ← All tables + indexes
    ├── V2__seed_ingredients.sql   ← 20 ingredients EN/FR/ZH-CN
    └── V3__seed_recipes.sql       ← 3 starter recipes EN/FR/ZH-CN
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

## 🧪 Run Tests

```bash
./mvnw test
# Uses H2 in-memory DB — no PostgreSQL or AWS needed
```

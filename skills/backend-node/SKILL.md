---
name: backend-node
description: Strict guidelines for Node.js/TypeScript backend architecture. Covers layered structure (core, services, routes/controllers, models), coding standards, and complex feature modules. Use when writing APIs, CRUD operations, or setting up Node.js/Express projects.
user-invocable: true
argument-hint: "<task description> e.g. 'create user authentication endpoints' or 'refactor payment service'"
---

# Backend Node Architecture

## My Preferred Stack Structure

I follow a **Hybrid Layered Architecture** using Node.js with TypeScript.

### A. The Standard Layers (Mandatory for CRUD/General APIs)

1. **`src/core/`**: Foundation & Plumbing
   - Database connection (Prisma/Drizzle/Mongoose setup)
   - Configuration (`config.ts`, parsing `process.env` with Zod validation)
   - Logger setup (Winston/Pino for structured JSON logging)
   - Security utilities (JWT hashing functions)
   - Base utilities and helper functions

2. **`src/services/`**: Business Logic
   - The actual workers/logic.
   - Functions that manipulate data.
   - **Rule:** Services should NOT know about HTTP. No `req` or `res` objects here.

3. **`src/controllers/` & `src/routes/`**: Interface
   - **`src/routes/`**: Define endpoint mappings (Traffic Cop - "POST /users → UserController.createUser").
   - **`src/controllers/`**: Handle HTTP request/response (Waiter - validate data, call services, send responses).
   - Routes are clean mapping tables; Controllers handle the HTTP mechanics.

4. **`src/models/`**: Data Contracts & Validation
   - Zod schemas for request validation (e.g., `UserCreateSchema`).
   - TypeScript types for type inference (e.g., `type UserCreate = z.infer<typeof UserCreateSchema>`).
   - Database models if using ORM/ODM (e.g., Prisma models).

### B. Feature Modules (Allowed for Complex Logic)

- You MAY create dedicated folders for self-contained, highly complex features (e.g., `src/billing/`, `src/websockets/`).
- **Rule:** These modules should still rely on `src/core/` for base utilities and expose their endpoints via the main `src/routes/`, but they can have their own internal structure (e.g., `events.ts`, `cron.ts`).
- Good examples: payment processors, real-time systems, AI integrations.

### C. Coding Standards (Strict)

- **No Unnecessary Comments:** Do NOT add comments for obvious code (e.g., `// print result`, `// loop through items`).
- Only comment on complex business logic or "why" a decision was made.
- Use TypeScript strict mode by default.

## When to Apply Architecture

- **IF** asked to setup a new project, refactor code, or answer "where does this code belong?", **THEN** follow this structure strictly.
- **IF** we are just chatting or writing simple standalone utility scripts, **YOU MAY** relax the folder structure to keep things simple.

## Controller Layer Rules

- Controllers extract data from `req.body`, `req.params`, `req.query`.
- Validate request data using Zod schemas before calling services.
- Call Services to get work done; do not write business logic here.
- Handle HTTP status codes (`res.status(404).json(...)`).
- Catch Service exceptions and translate them to appropriate HTTP responses.

## Service Layer Rules

- All database queries belong in the Service layer, NOT in controllers.
- Services should throw descriptive errors (e.g., `UserNotFoundError`), not HTTP errors.
- Services return plain data/objects; controllers handle response formatting.
- Keep services dependency-free from HTTP frameworks (Express/Fastify).

## CRUD Guidelines

- Keep standard CRUD operations extremely clean.
- Offload actual database calls to an ORM/Repository layer or directly within `src/services/`.
- Do not put database queries directly inside Controllers/Routes.
- Use Zod schemas for request validation (equivalent to FastAPI's Pydantic).

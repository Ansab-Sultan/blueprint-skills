---
name: backend-python
description: Strict guidelines for Python backend architecture using FastAPI. Covers layered structure (core, services, routers, models), coding standards, and complex feature modules. Use when writing APIs, CRUD operations, or setting up Python projects.
user-invocable: true
argument-hint: "<task description> e.g. 'create user authentication endpoints' or 'refactor payment service'"
---

# Backend Python Architecture

## My Preferred Stack Structure

I follow a **Hybrid Layered Architecture** using FastAPI.

### A. The Standard Layers (Mandatory)

1. **`app/core/`**: Foundation & Plumbing
   - Database connection (`database.py`, SQLAlchemy engine)
   - Configuration (`config.py`, Pydantic BaseSettings)
   - Logger setup
   - Security utilities (JWT hashing)
   - Dependency factories (`get_db`, etc.)

2. **`app/services/`**: Business Logic
   - The actual workers/logic.
   - Functions that manipulate data.
   - **Rule:** Services should NOT know about HTTP. No `Request` or `Response` objects here.

3. **`app/routers/`**: Interface
   - FastAPI routers that define endpoints (`@router.post("/users")`).
   - Call Services to get work done.
   - Handle HTTP status codes and return responses.

4. **`app/models/`**: Data Contracts
   - Pydantic schemas for request validation (`UserCreate`, `UserUpdate`).
   - Pydantic schemas for response formatting (`UserResponse`).
   - SQLAlchemy ORM models for database tables (`User` table definition).

### B. Feature Modules (Allowed for AI/Complex Logic)

- You MAY create dedicated folders for self-contained complex features (e.g., `app/chatbot/`, `app/agents/`).
- **Rule:** These modules should still use `core` utilities and be exposed via `routers`, but they can have their own internal structure (e.g., `tools.py`, `graph.py`).
- Good examples: billing systems, AI agents, background job processors.

### C. Coding Standards (Strict)

- **No Unnecessary Comments:** Do NOT add comments for obvious code (e.g., `# print result`, `# loop through items`).
- Only comment on complex business logic or "why" a decision was made.
- Follow PEP 8 formatting.

## When to Apply Architecture

- **IF** I ask you to setup a new project, refactor code, or answer "where does this code belong?", **THEN** follow this structure strictly.
- **IF** we are just chatting, brainstorming, or writing simple standalone scripts, **YOU MAY** relax the folder structure to keep things simple.

## Service Layer Rules

- All database queries belong in the Service layer, NOT in routers.
- Services return Python objects/dictionaries; routers handle Pydantic serialization.
- Use dependency injection for database sessions (`db: Session = Depends(get_db)`).
- Services should raise descriptive exceptions; routers catch and return appropriate HTTP status codes.

## CRUD Guidelines

- Keep standard CRUD operations clean and consistent.
- Use Pydantic models for request validation (auto-handled by FastAPI decorators).
- Use SQLAlchemy models for database table definitions.
- Separate concerns: validation (Pydantic), database access (SQLAlchemy), business logic (Services).

---
name: bootstrap
description: "Scaffold a new project from minimal, opinionated defaults. Python uses uv, TypeScript uses bun and Next.js, PostgreSQL by default. Use when the user says bootstrap, scaffold, new project, new service, or new app."
user-invocable: true
argument-hint: "<project-type> <project-name> e.g. 'python my-service' or 'nextjs my-app'"
---

# Bootstrap a Project

Scaffold a new project with sensible, minimal defaults. Stop after scaffolding — do not build features.

## Defaults

**Python**
- Package manager: `uv` (never pip, poetry, or pipenv)
- Settings: `pydantic-settings`
- Database: PostgreSQL with `asyncpg` (only if the project needs a DB)
- Structure: `app/` at the root, `tests/` mirroring `app/`

**TypeScript / Frontend**
- Runtime and package manager: `bun`
- Framework: `Next.js` (App Router)
- Structure: `app/` at the root (Next.js default)

## Rule: Check Latest Versions

Before running any scaffolder, check the latest stable version of the tool or framework. Do not assume from memory. Use `uv self update && uv --version`, `bun upgrade && bun --version`, `npx create-next-app@latest --help`. Pin to what's current *today*, not what you remember.

## Process

1. **Ask at most three questions, grouped:**
   - What are we building? (CLI, service, library, web app)
   - What's the project name?
   - Any deviations from the defaults above? (If no, proceed.)

2. **Check latest versions** of the tools you're about to use.

3. **Scaffold.** Generate only what's needed for `just dev` and `just test` to work on a clean clone.

4. **First commit:** `git init && git commit -m "initial scaffold"`.

5. **Stop.** Do not write features. Do not add example routes, sample data, or lorem ipsum.

## What Every Project Gets

- `justfile` with `dev`, `test`, `lint`, `typecheck`, `check`
- `CLAUDE.md` with the minimal template (core rule / workflow / architecture / corrections)
- `.env.example` with documented variables, no real `.env`
- `.gitignore` appropriate to the stack
- `README.md` — one paragraph, what it is and how to run it

## Rules

- Minimal dependencies. Add nothing "just in case."
- No `utils/`, `helpers/`, `common/` folders. Name things by what they do.
- No SQLAlchemy unless the user asks — start with raw SQL or SQLModel.
- No example routes, no sample endpoints, no placeholder components.
- If `~/.claude/STACK.md` exists, prefer its defaults over the ones here.

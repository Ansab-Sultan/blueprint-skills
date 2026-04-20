---
name: bootstrap
description: "Scaffold a new project from minimal, opinionated defaults. Python uses uv, TypeScript uses bun and Next.js, PostgreSQL by default. Use when the user says bootstrap, scaffold, new project, new service, or new app."
user-invocable: true
argument-hint: "<project-type> <project-name> e.g. 'python my-service' or 'nextjs my-app'"
---

# Bootstrap a Project

Scaffold a new project with minimal, opinionated defaults. Stop after scaffolding — do not build features.

## Defaults

- **Python** → `uv`, `pydantic-settings`, PostgreSQL when a DB is needed
- **TypeScript** → `bun`, Next.js (App Router)
- **Structure** → `app/` at the root

## Rule: Check Latest Versions

Before running any scaffolder, check the latest stable version of the tool or framework. Do not assume from memory. Pin to what's current today.

## Process

1. Ask at most three questions, grouped:
   - What are we building? (CLI, service, library, web app)
   - What's the project name?
   - Any deviations from the defaults?

2. Check the latest versions of the tools you're about to use.

3. Scaffold the project using the templates below.

4. First commit: `git init && git commit -m "chore: initial scaffold"`.

5. Stop. Do not write features. Do not add example code.

## Templates

Every scaffolded project gets these files at the root.

### `justfile`

````just
default:
    @just --list

# Run the dev server
dev:
    @echo "Not implemented"

# Run tests
test:
    @echo "Not implemented"
````

Replace the placeholders with real commands once the project has something to run and test. Add more recipes (`lint`, `typecheck`, `check`) only when there's something to wire them to.

### `README.md`

````markdown
# <project-name>

<One paragraph: what this is and what it does.>

## Requirements

<Tools needed to run this project.>

## Run

```bash
just dev
```

## Test

```bash
just test
```
````

### `CLAUDE.md`

````markdown
# CLAUDE.md

## Core rule
**Always use `just`, not raw commands.**

## Development workflow
1. Make changes
2. Run tests: `just test`
3. Run the app: `just dev`

## Architecture
(Where things live. Key decisions. Grows over time.)

## Corrections
(Empty at start. Add a rule every time a mistake is made that shouldn't repeat.)
````

### `LICENSE`

Default to MIT. Use `git config user.name` for the copyright holder and the current year.

````
MIT License

Copyright (c) <year> <full name>

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is furnished
to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
````

### Also included

- `.env.example` — documented variables if relevant (no real `.env`)
- `.gitignore` — appropriate to the stack

## Rules

- Minimal dependencies. Add nothing "just in case."
- No example routes, no sample data, no placeholder pages.
- If `~/.claude/STACK.md` exists, prefer its defaults over the ones here.

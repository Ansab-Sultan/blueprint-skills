---
name: blueprint
description: "Interactively gather requirements through multi-round Q&A, then produce a single detailed spec + implementation plan. Use instead of spec + plan for solo or small-team work. Replaces both the spec and plan skills in one session."
user-invocable: true
argument-hint: "<feature-name> <description> e.g. 'user-auth add OAuth login' or just 'add OAuth login'"
---

# Blueprint

## What this skill produces

A single file at `docs/<feature-name>/blueprint.md` containing:
- Full specification (what, why, requirements, design, edge cases)
- A numbered, ordered task list ready for the `build` skill

The `build` skill can then execute this file either task-by-task or all at once.

---

## Phase 1 — Understand (MANDATORY, never skip)

> **Human-in-the-loop rule:** You must not write any file or start designing until the user has answered enough questions for you to be fully confident about every decision that would materially change the implementation. This phase may take multiple rounds. Keep asking until there is nothing left that would force a design change later.

### Step 0 — Derive the feature name
Before doing anything else, determine the `<feature-name>`:
- If the first word of the argument is a concise, lowercase, hyphenated slug (e.g. `user-auth`), use it as the feature name and treat the rest as the description.
- Otherwise, derive a short, lowercase, hyphenated slug from the full request (e.g. "add OAuth login" → `oauth-login`) and treat the entire argument as the description.
- Never ask the user for the feature name. Always derive it silently.

### Step 1 — Read the codebase
Before asking any questions, scan the relevant parts of the codebase:
- Understand the existing architecture, patterns, folder structure, and conventions.
- Identify existing interfaces, schemas, and services that the feature will touch.
- Note any constraints (test setup, CI, build tooling, framework version).

### Step 2 — Identify ambiguities
After reading, build a list of every decision that is unclear or has two reasonable implementations that would behave differently. Classify each as:
- **Blocker**: cannot design without this answer
- **Important**: changes scope or design meaningfully
- **Minor**: can be resolved with a safe default, but worth confirming

### Step 3 — Ask Round 1
Present only the **Blocker** and **Important** questions to the user. Group related questions together. Be concise. Number each question. Do not ask about Minor items yet — resolve them with explicit assumptions instead.

**Format for asking:**
```
Before I write the blueprint, I need to clarify a few things:

1. [Question]
2. [Question]
...

(I'm assuming [X] for minor decisions — let me know if that's wrong.)
```

### Step 4 — Process answers and ask Round 2 (if needed)
After the user answers, re-evaluate:
- Did any answer open up new ambiguities?
- Are there now new Blockers or Important questions?
- If yes, ask a focused Round 2. Do not repeat answered questions.
- Repeat this loop until zero Blockers and zero Important questions remain.
- When satisfied, explicitly tell the user: **"I have everything I need. Writing the blueprint now."**

---

## Phase 2 — Write the Blueprint

Once Q&A is complete, write `docs/<feature-name>/blueprint.md` using the structure below. Be exhaustive and precise — this document must be detailed enough that an engineer with no prior context can implement every task correctly without asking any questions.

### Blueprint Structure

```markdown
# Blueprint: <Feature Name>

## Overview
One paragraph: what is being built, why it is being built, and what problem it solves.

## Context
- How this fits into the existing system
- Existing files, services, or modules this touches
- Patterns and conventions this feature must follow

## Requirements
Numbered list of specific, testable requirements. Each one must describe an observable outcome.

1. ...
2. ...

## Out of Scope
Explicit list of what is NOT being built. Prevents scope creep during implementation.

- ...

## Technical Design

### Architecture
Describe the high-level structure: new files, new modules, changed interfaces.

### Data Models / Schemas
If the feature changes or creates data shapes, define them here in full detail.

### API / Interface Changes
List every interface, API endpoint, function signature, config key, CLI flag, or file format that is added or changed.
For each:
- Old shape (if changing something existing)
- New shape
- Who calls it / who depends on it

### Key Implementation Details
Describe non-obvious implementation decisions. Explain why each decision was made over alternatives. Cover:
- Critical logic paths
- Error handling strategy
- Edge cases and how each is handled
- Performance or security considerations if relevant

### Dependencies
List new libraries, environment variables, or external services required. For each:
- Why it is needed
- How to install or configure it

## Assumptions
Explicit list of every assumption made during Q&A. If any assumption is wrong, it must be corrected before implementation starts.

1. ...

## Tasks

> These tasks are ordered by dependency. Each task leaves the codebase in a runnable, testable state. Use the `build` skill to execute them individually or all at once.

---

### Task 1: <Short Title>

**Goal:** What this task achieves and why it comes first.

**Scope:**
- Exact files to create or modify
- Exact functions, classes, or components to add or change

**Acceptance Criteria:**
- [ ] Criterion 1 (observable outcome)
- [ ] Criterion 2
- ...

**Error Handling:**
Describe how failures in this task's scope should behave.

**Verify:**
```bash
# Exact commands to confirm this task is complete
```

---

### Task 2: <Short Title>
... (repeat for every task)

---

## Full Verification
Commands or steps to verify the entire feature end-to-end after all tasks are complete.

```bash
# e.g. run test suite, start server, hit endpoint
```
```

---

## Phase 3 — Confirm before handing off

After writing the file, present the user with a summary:
- Number of tasks
- Any remaining assumptions they should review
- Two options to proceed:

```
Blueprint saved to docs/<feature-name>/blueprint.md.

You can now:
  A) Run all tasks at once:   /skill:build all tasks from <feature-name>
  B) Run task by task:        /skill:build Task 1 from <feature-name>
```

---

## Rules

- **Never write the blueprint file until Phase 1 Q&A is complete.** No exceptions.
- **Multiple rounds of questions are expected and correct.** A single round is only acceptable when the initial request is fully unambiguous.
- **Every assumption must be written down** in the Assumptions section. Never hide a decision.
- **Tasks must be vertical slices**, not layer-by-layer (e.g. "add auth endpoint with model, service, and route" not "add all models" then "add all routes").
- **Every task must have a concrete Verify block** with exact commands. Never write "run the tests" without specifying which.
- **If a task has more than 5 acceptance criteria, split it.**
- **Call out any breaking changes, migrations, or contract changes** in the task that introduces them.
- **Do not invent requirements** that were not stated or reasonably implied. Ask instead.
- **Derive the feature-name silently** — never ask the user for it. Use the first word if it is already a valid slug, otherwise derive one from the full request.

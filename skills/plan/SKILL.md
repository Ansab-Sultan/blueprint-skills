---
name: plan
description: "Transform requirements and architecture docs into an atomic implementation plan with phased tasks. Use after /blueprint:architecture has produced an architecture doc."
user-invocable: true
argument-hint: "<feature-name> e.g. 'user-auth'"
---

# Generate Implementation Plan

You are a senior engineer and technical lead. Your job is to read requirements and architecture documents and produce a phased implementation plan of atomic, executable tasks.

## Input

The user provides: $ARGUMENTS

The argument is the feature name. Read the requirements from `docs/<feature-name>/requirements.md` and the architecture from `docs/<feature-name>/architecture.md`. Write the plan to `docs/<feature-name>/tasks.md`.

If no argument is provided, look in `docs/` for directories containing `architecture.md`. If there's exactly one, use it. If there are several, list them and ask which one. If there are none, tell the user to run `/blueprint:architecture` first.

## Process

**Start by reading both the requirements and architecture files.** If either doesn't exist, stop and tell the user to provide the correct paths.

Each task must be small enough to execute in a single focused context window — one logical concern per task.

**Split a task if any of these are true:**
- You can't describe the acceptance criteria in 3 bullet points or fewer
- The title contains "and" (that's two tasks)
- It touches two independent subsystems (e.g. auth and billing)
- It would take more than one focused session to implement

Then produce the output file.

## Output Format

Write to `docs/<feature-name>/tasks.md`. Use this structure exactly:

```markdown
# Implementation Plan

## Summary
- Total phases: N
- Total tasks: N
- Estimated complexity: Low / Medium / High

## Dependencies
Show the dependency graph up front so individual tasks don't need to repeat it.
Example: 1 → 2 → 4, 1 → 3 → 4 (tasks 2 and 3 can run in parallel after 1)

---

## Phase 1: [Name]
**Goal**: What this phase delivers. What works at the end of it that didn't before.

### Task 1: [Title]

**Context:** Self-contained background. What is this project? What area does this task touch and why?
Write 2-4 sentences — enough that an agent with zero prior context can understand and execute the task
without reading any other document. Never reference other tasks by number — the agent won't have seen them.

**Build:**
1. Outcome-level steps — describe *what* to build, not *how* to code it
2. Each step is a deliverable, not an implementation instruction
3. Keep to 3-5 steps max

**Verify:** A runnable command with expected output. `curl`, `pytest`, a CLI invocation — something
a coding agent can execute and check. Never "confirm X" or "check that Y" — always a command.

### Task 2: [Title]
...

### Checkpoint
- [ ] All tests pass
- [ ] Application builds and runs
- [ ] [Phase goal verified]

---

## Phase 2: [Name]
...
```

## Slice Vertically, Not Horizontally

Build one complete feature path at a time — not all of one layer, then all of the next.

**Wrong (horizontal):**
```
Phase 1: Build entire database schema
Phase 2: Build all API endpoints
Phase 3: Build all UI components
Phase 4: Connect everything
```

**Right (vertical):**
```
Phase 1: User can create an account (schema + API + UI for registration)
Phase 2: User can log in (auth schema + API + session handling)
Phase 3: User can create a task (task schema + API + UI)
```

Each phase delivers working, testable functionality. Order by risk — highest-uncertainty work first. If Phase 1 fails, you learn it before investing in Phases 2-5.

## Rules

- Every phase must end with a checkpoint. Do not proceed until it passes.
- Written plans survive session boundaries and context compaction — don't skip planning because "the tasks are obvious."
- Each task maps to one commit. The **Context** and **Build** sections are the scope, **Verify** is the acceptance criteria.

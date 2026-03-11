---
name: plan
description: "Transform requirements and architecture docs into an atomic implementation plan with phased tasks. Use after /blueprint:architecture has produced ARCHITECTURE.md."
user-invocable: true
allowed-tools: Read, Write, Edit, Glob, Grep
---

# Generate Implementation Plan

You are a senior engineer and technical lead. Your job is to read `REQUIREMENTS.md` and `ARCHITECTURE.md` and produce a phased implementation plan of atomic, executable tasks.

## Process

**Start by reading both `REQUIREMENTS.md` and `ARCHITECTURE.md`.** If either doesn't exist, stop and tell the user which commands to run first (`/blueprint:requirements` and/or `/blueprint:architecture`).

Each task must be small enough to execute in a single focused context window — no task should touch more than 3-4 files or span more than one logical concern. If a task feels large, split it.

Then produce `TASKS.md` in the project root.

## Output Format

Write the file to `TASKS.md`. Use this structure exactly:

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

**Context:** 1-2 sentences describing the project and what module/area this task operates in.
Enough for an agent or engineer to understand *why* this task exists without reading other docs.

**Build:**
1. Outcome-level steps — describe *what* to build, not *how* to code it
2. Each step is a deliverable, not an implementation instruction
3. Keep to 3-5 steps max

**Files:** `path/to/file.py`, `path/to/other.py`

**Verify:** One sentence — a command to run or a behaviour to observe.

### Task 2: [Title]
...

---

## Phase 2: [Name]
...
```

## Phasing Strategy

Phase by **working software** not by layer. Each phase should produce something runnable:
- Phase 1: Skeleton that runs (CLI starts, no functionality)
- Phase 2: Core loop working (agent takes input, calls model, returns output)
- Phase 3: Tools working (each tool implemented and tested)
- Phase 4: Configuration, polish, edge cases

Avoid phases like "set up project structure" or "write all models" — these don't produce working software.

## Task Rules

- **Context is project-level.** Give enough background for an agent to understand the project and where this task fits. Don't restate the code about to be written.
- **Build steps are outcomes, not implementation instructions.** Say *what* to build, not *how* to write every line. The executing agent decides the implementation details. Bad: "Use asyncio.gather to run callbacks concurrently." Good: "Emit fires all registered callbacks for that event type concurrently."
- **Verify is one sentence.** A command to run or a behaviour to observe. Not an inline script.
- **Human-readable first.** The plan must be scannable by a human in under a minute. Use plain markdown — no XML tags, no verbose inline code blocks.
- Every functional requirement (FR-xx) must be covered by at least one task. Note uncovered requirements.
- Dependencies go in the top-level dependency graph, not on individual tasks.

## After Planning

Once TASKS.md is produced, the user can execute individual tasks with `/blueprint:task <task-number>` or create tickets in their project management tool. Each task maps to one ticket — the **Context** and **Build** sections provide the ticket description, and **Verify** provides the acceptance criteria.

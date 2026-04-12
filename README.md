# Blueprint

> Agentic coding best practices without the complexity.

## The Problem with Agentic Coding Frameworks

Every week there's a new Claude Code plugin with 50 skills, 16 review agents, multi-stage orchestration pipelines, and anti-rationalization tables. They look impressive in a demo. In practice, you spend more time configuring the framework than writing software.

These frameworks are built on a flawed assumption: that AI agents are unreliable and need to be constrained with hundreds of lines of rules. So they add guardrails on guardrails — specialized agents watching other agents, complex routing logic, permission matrices — until the tooling itself becomes the bottleneck.

**Blueprint takes the opposite stance: agents are smart. Treat them that way.**

A clear 50-line skill outperforms a 500-line skill full of warnings and iron laws. The agent spends its attention on your work instead of navigating rules. As models get more capable, heavy frameworks fight the model. Simple workflows ride the improvement curve.

## What Blueprint Actually Is

The software development lifecycle, encoded as executable commands:

```mermaid
graph LR
    A[Requirements] --> B[Architecture]
    B --> C[Plan]
    C --> D[Build]
    D --> E[Ship]
```

That's it. No agent swarms. No orchestration layer. No configuration files. Commands that map to what good engineering teams already do — just faster.

`/blueprint:build` runs the full inner loop: for each task, write code, write tests, review, improve, then do a final review of everything. Or use the individual commands when you want control over a specific step.

You can read every skill in 10 minutes. Try that with the alternatives.

## Install

### Option 1: Claude Code plugin marketplace

```
/plugin marketplace add owainlewis/blueprint
/plugin install blueprint@owainlewis-blueprint
```

Skills are namespaced as `/blueprint:requirements`, `/blueprint:plan`, etc.

### Option 2: `npx skills` (works with 40+ agents)

If you use [vercel-labs/skills](https://github.com/vercel-labs/skills), you can install Blueprint into Claude Code, Codex, Cursor, OpenCode, and others:

```bash
# Install all skills globally for Claude Code
npx skills add owainlewis/blueprint -a claude-code -g

# Or pick specific skills
npx skills add owainlewis/blueprint -s requirements -s plan -a claude-code -g
```

With this method skills install as bare names (`/requirements`) rather than namespaced (`/blueprint:requirements`). Update later with `npx skills update`.

## Commands

All planning commands use a feature name to organize artifacts into `docs/<feature>/`. One directory per feature — requirements, architecture, and tasks all live together.

### 1. Requirements

Turn rough notes into a structured requirements document. The agent acts as a technical PM — it will ask clarifying questions before producing the doc.

```
/blueprint:requirements user-auth I need login and registration with OAuth support
```

Writes to `docs/user-auth/requirements.md`.

### 2. Architecture

Turn a requirements doc into a technical architecture design. Covers system design, components, data flow, key decisions, and file structure.

```
/blueprint:architecture user-auth
```

Reads `docs/user-auth/requirements.md`, writes `docs/user-auth/architecture.md`.

### 3. Plan

Break an architecture into phased, executable tasks. Each task is self-contained — written so an agent (or engineer) with zero prior context can pick it up and start working.

```
/blueprint:plan user-auth
```

Reads both docs, writes `docs/user-auth/tasks.md`.

### 4. Build

Run the full implementation cycle for a planned feature. Reads the task plan, then for each task: writes code, writes tests, reviews and improves, verifies. Finishes with a full test run and final code review.

```
/blueprint:build user-auth
```

This is the "go build it" command — it orchestrates the inner loop so you don't have to run each skill manually. Use the individual commands (`/blueprint:task`, `/blueprint:tdd`, `/blueprint:review`) when you want fine-grained control.

### 5. Task

Pick up a single task and execute it. Accepts a ticket ID or a plain description. Creates a branch, does the work, verifies the acceptance criteria, and commits.

```
/blueprint:task "add rate limiting to the API"
```

### 6. TDD

Build a feature test-first. Write failing tests that define the behavior, implement the minimum to make them pass, then simplify.

```
/blueprint:tdd "retry logic for API client"
```

### 7. Review

Review your changes like a senior engineer before shipping. Checks correctness, security, simplicity, and robustness.

```
/blueprint:review
/blueprint:review src/auth.py
/blueprint:review security
```

If your project has a `REVIEW.md` in the root, those concerns are automatically included in every review.

### 8. Refactor

Simplify code without changing behavior — remove dead code, flatten unnecessary abstractions, improve naming.

```
/blueprint:refactor
/blueprint:refactor src/api/routes.py
```

### 9. Coverage

Fill test gaps with tests worth having. Every test must catch a realistic bug.

```
/blueprint:coverage
/blueprint:coverage src/auth/
```

### 10. Debug

Systematic debugging when something is broken. Observe, hypothesize, test, fix — and if repeated fixes fail, question the architecture.

```
/blueprint:debug "API returns 500 on user creation"
```

### 11. Commit

Stage and commit with a conventional commit message. Reviews the diff and writes the message for you.

```
/blueprint:commit
```

## Philosophy

**Workflow beats prompts.** The value isn't in clever prompt engineering — it's in encoding the right process. Requirements before architecture. Architecture before code. Review before ship. Get the sequence right and the agent does the rest.

**Simplicity is a feature.** Every skill in Blueprint is under 100 lines. Not because we couldn't write more, but because more is worse. The frameworks with 16 specialized review agents and multi-stage orchestration pipelines are optimizing for impressiveness, not outcomes. In practice, one focused review that checks correctness, security, and simplicity catches more real bugs than 16 agents generating noise.

**Bet on the model.** Frameworks that micromanage the agent with hundreds of rules are building on sand. Every model improvement makes those rules less necessary and more likely to conflict with the model's own judgment. Blueprint gives the agent clear goals and gets out of the way. That approach gets better over time, not worse.

## Example

The [`examples/`](examples/) folder shows the full pipeline for a real project — a Python RAG chatbot API. Start with the [raw notes](examples/input.md) and see what each stage produces:

1. [input.md](examples/input.md) — rough project notes
2. [requirements.md](examples/REQUIREMENTS.md) — structured requirements
3. [architecture.md](examples/ARCHITECTURE.md) — technical design
4. [tasks.md](examples/TASKS.md) — phased implementation plan

In practice these would live in `docs/rag-chatbot/` — one directory per feature.

## Updating

After installing, update to the latest version with:

```
claude plugin update blueprint@owainlewis-blueprint
```

Then reload in a running session:

```
/reload-plugins
```

## Releasing (for contributors)

Bump the version, commit, tag, and push in one step:

```bash
./release.sh patch   # 0.2.0 → 0.2.1
./release.sh minor   # 0.2.0 → 0.3.0
./release.sh major   # 0.2.0 → 1.0.0
```

This updates both `plugin.json` and `marketplace.json` so users can pull the new version immediately.

## Local Development

```bash
claude --plugin-dir /path/to/blueprint
```

## Learn More

I cover all of this in more depth at: https://www.skool.com/aiengineer

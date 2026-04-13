# Blueprint

> The software development lifecycle, encoded as skills for AI coding agents.

## Why Blueprint

Most agentic coding frameworks assume AI agents are unreliable and need hundreds of lines of rules. So they add guardrails on guardrails — specialized agents watching other agents, multi-stage orchestration, permission matrices — until the tooling becomes the bottleneck.

**Blueprint takes the opposite stance: agents are smart. Treat them that way.**

A clear 50-line skill outperforms a 500-line skill full of warnings. As models improve, heavy frameworks fight the improvement. Simple workflows ride it.

12 skills. You can read the entire framework in 15 minutes.

## How It Works

Blueprint gives you two paths from idea to working code:

```
    ┌───────────────────────────────────────────────────────────────┐
    │  QUICK PATH (most work)                                       │
    │                                                               │
    │  Idea ──▶ Spec ──▶ Build                                      │
    └───────────────────────────────────────────────────────────────┘

    ┌───────────────────────────────────────────────────────────────┐
    │  FULL PIPELINE (complex projects)                             │
    │                                                               │
    │  Idea ──▶ Requirements ──▶ Architecture ──▶ Plan ──▶ Build    │
    └───────────────────────────────────────────────────────────────┘
```

Both paths end at the same build cycle:

```
    For each task:
    ┌──────┐   ┌──────┐   ┌────────┐   ┌────────┐
    │ Code ├──▶│ Test ├──▶│ Review ├──▶│ Commit │
    └──────┘   └──────┘   └────────┘   └────────┘

    Then: full test suite ──▶ final review ──▶ ship
```

## Spec vs. Full Pipeline

This is the most important decision when using Blueprint: one doc or three?

### Who are these docs for?

**They're for agents, not humans.** Your real design thinking happens in Confluence, on a whiteboard, in a Slack thread, in your head. What lands in the repo as markdown is the distilled brief an agent needs to do its job. Keep that in mind — these docs should be as short as possible while giving the agent enough context to build correctly.

### When to use `/blueprint:spec` (one doc)

Use this when you've already done the thinking. You know what to build and roughly how. You just need to hand the agent a clear brief.

This covers most work: a new feature, a bug fix, an API endpoint, a refactor with clear scope. One doc, one command, done.

```
/blueprint:spec user-auth add OAuth login with Google and GitHub
```

### When to use the full pipeline (three docs)

Use this when the work is complex enough that separating *what* from *how* prevents mistakes:

- **Multiple people own different phases** — PM defines requirements, architect designs the system, engineer implements. Each doc has a different audience.
- **The scope is genuinely unclear** — you need the agent to ask clarifying questions and think through requirements before jumping to design.
- **The architecture has real trade-offs** — database choices, service boundaries, API contracts that need to be decided explicitly before implementation.
- **The project has 10+ tasks** — a single spec becomes a wall of text. Separate docs let the agent focus on the relevant phase.

```
/blueprint:requirements user-auth I need login and registration with OAuth
/blueprint:architecture user-auth
/blueprint:plan user-auth
```

### The trade-off

| | Spec (one doc) | Full pipeline (three docs) |
|---|---|---|
| **Speed** | One command, one doc | Three commands, three docs |
| **When it's better** | You've done the thinking. Agent just needs a brief. | The thinking IS the work. Agent needs to reason through each phase. |
| **Risk** | May miss requirements or architectural issues if the feature is complex | Overhead isn't worth it for straightforward work |
| **Audience** | One agent executes everything | Could be different agents (or humans) per phase |

**Default to spec.** Upgrade to the full pipeline when the spec starts feeling too long or when you realize the design needs more thought than you initially expected.

## Install

### Claude Code (plugin marketplace)

```
/install owainlewis/blueprint
```

### npx skills (Claude Code, Codex, Cursor, OpenCode, and 40+ others)

```bash
npx skills add owainlewis/blueprint -a claude-code -g
```

## Skills

### Planning

All planning skills organize artifacts into `docs/<feature>/` — one directory per feature, no collisions.

| Skill | What it does | Example |
|-------|-------------|---------|
| **spec** | Write a lightweight spec — what, how, and tasks in one doc | `/blueprint:spec user-auth add OAuth login` |
| **requirements** | Turn rough notes into structured, testable requirements | `/blueprint:requirements user-auth I need login with OAuth` |
| **architecture** | Turn requirements into a technical design with components, data flow, and file structure | `/blueprint:architecture user-auth` |
| **plan** | Break architecture into phased, atomic tasks with self-contained context | `/blueprint:plan user-auth` |

### Building

| Skill | What it does | Example |
|-------|-------------|---------|
| **build** | Execute a full task plan: code, test, review, and commit each task, then final review | `/blueprint:build user-auth` |
| **task** | Pick up and execute a single task | `/blueprint:task "add rate limiting to the API"` |
| **tdd** | Build test-first: failing tests, then implementation, then simplify | `/blueprint:tdd "retry logic for API client"` |

### Quality

| Skill | What it does | Example |
|-------|-------------|---------|
| **review** | Code review — correctness, security, simplicity, robustness | `/blueprint:review` |
| **refactor** | Simplify code without changing behavior | `/blueprint:refactor src/api/routes.py` |
| **coverage** | Fill test gaps with tests that catch realistic bugs | `/blueprint:coverage src/auth/` |
| **debug** | Systematic root-cause debugging: observe, hypothesize, test, fix | `/blueprint:debug "API returns 500 on POST"` |

### Git

| Skill | What it does | Example |
|-------|-------------|---------|
| **commit** | Stage and commit with a conventional commit message | `/blueprint:commit` |

## Philosophy

**Workflow beats prompts.** The value isn't in clever prompt engineering — it's in encoding the right sequence. Get the sequence right and the agent does the rest.

**Simplicity is a feature.** One focused review catches more real bugs than 16 agents generating noise. One spec doc is better than three separate docs — until it isn't. Blueprint gives you both options and helps you choose.

**Bet on the model.** Frameworks that micromanage agents with hundreds of rules are building on sand. Every model improvement makes those rules less necessary. Blueprint gives clear goals and gets out of the way.

**Docs are for agents.** Your real design thinking happens elsewhere — Confluence, whiteboards, conversations. What lands in markdown is the minimum an agent needs to build correctly. Keep specs short, requirements testable, and tasks self-contained.

**Core SDLC only.** Blueprint encodes the development lifecycle — planning, building, testing, reviewing, shipping. It does not include integrations with specific tools (Linear, Jira, Slack). Integrations are a separate concern and belong in separate plugins.

## Example

The [`examples/`](examples/) folder shows the full planning pipeline for a Python RAG chatbot API:

1. [input.md](examples/input.md) — rough project notes
2. [requirements.md](examples/rag-chatbot/requirements.md) — structured requirements
3. [architecture.md](examples/rag-chatbot/architecture.md) — technical design
4. [tasks.md](examples/rag-chatbot/tasks.md) — phased implementation plan

Regenerate the examples after changing skills:

```bash
./examples/regenerate.sh
```

## Updating

```
claude plugin update blueprint@owainlewis-blueprint
```

## Releasing (for contributors)

```bash
./release.sh patch   # 0.2.0 → 0.2.1
./release.sh minor   # 0.2.0 → 0.3.0
./release.sh major   # 0.2.0 → 1.0.0
```

## Local Development

```bash
claude --plugin-dir /path/to/blueprint
```

## Learn More

https://www.skool.com/aiengineer

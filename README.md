# Blueprint

A Claude Code plugin that encodes the software development lifecycle as executable commands.

Six commands. No framework to learn. Just the workflow every good engineering team already follows.

## Why Blueprint?

Most agentic coding frameworks add enormous complexity — dozens of commands, multi-stage review pipelines, anti-rationalization tables — solving problems that don't exist while creating new ones.

Blueprint takes the opposite stance: **agents are smart. Treat them that way.**

As models get more capable, the right move is to simplify your instructions, not add more. A clear 50-line skill outperforms a 500-line skill full of warnings and iron laws — because the agent spends its attention on the work instead of navigating the rules. Workflow beats prompts.

```mermaid
graph LR
    A[Requirements] --> B[Architecture]
    B --> C[Plan]
    C --> D[Execute]
    D --> E[Ship]

    style A fill:#2d333b,stroke:#768390,color:#adbac7
    style B fill:#2d333b,stroke:#768390,color:#adbac7
    style C fill:#2d333b,stroke:#768390,color:#adbac7
    style D fill:#2d333b,stroke:#768390,color:#adbac7
    style E fill:#2d333b,stroke:#768390,color:#adbac7
```

## Install

```
/plugin marketplace add owainlewis/blueprint
/plugin install blueprint@owainlewis-blueprint
```

## Commands

All document commands take explicit file paths — you decide where things live.

### 1. Requirements

Turn rough notes into a structured requirements document. The agent acts as a technical PM — it will ask clarifying questions before producing the doc.

```
/blueprint:requirements REQUIREMENTS.md I need a CLI tool that parses markdown and generates HTML
```

### 2. Architecture

Turn a requirements doc into a technical architecture design. Covers system design, components, data flow, key decisions, and file structure.

```
/blueprint:architecture REQUIREMENTS.md ARCHITECTURE.md
```

### 3. Plan

Break an architecture into phased, executable tasks. Each task is self-contained — written so an agent (or engineer) with zero prior context can pick it up and start working.

```
/blueprint:plan REQUIREMENTS.md ARCHITECTURE.md TASKS.md
```

### 4. Task

Pick up a single task and execute it. Accepts a ticket ID from any tracker (Linear, Jira, GitHub) or a plain description. Creates a branch, does the work, verifies the acceptance criteria, and commits.

```
/blueprint:task LIN-123
/blueprint:task "add rate limiting to the API"
```

### 5. Branch

Create a feature branch with conventional naming.

```
/blueprint:branch feature markdown-parser
/blueprint:branch fix login-redirect
```

### 6. Commit

Stage and commit with a conventional commit message. Reviews the diff and writes the message for you.

```
/blueprint:commit
```

## Example

The [`examples/`](examples/) folder shows the full pipeline for a real project — a Python RAG chatbot API. Start with the [raw notes](examples/input.md) and see what each stage produces:

1. [input.md](examples/input.md) — rough project notes
2. [REQUIREMENTS.md](examples/REQUIREMENTS.md) — structured requirements
3. [ARCHITECTURE.md](examples/ARCHITECTURE.md) — technical design
4. [TASKS.md](examples/TASKS.md) — phased implementation plan

## Local Development

```bash
claude --plugin-dir /path/to/blueprint
```

## Learn More

I cover all of this in more depth at: https://www.skool.com/aiengineer

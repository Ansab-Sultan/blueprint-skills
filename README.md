# Blueprint

A Claude Code plugin that encodes the standard software development lifecycle as executable commands.

Five commands. No framework to learn. Just the same process every good engineering team already follows.

## Why not the other spec frameworks?

Most "agentic development" frameworks massively overcomplicate a simple process. Dozens of commands, custom DSLs, novel methodologies — solving problems that don't exist while ignoring the one that does: discipline.

The way we build software hasn't changed. Requirements. Design. Plan. Build. Review. Ship. This process works whether you're a team at Google, a solo founder, or an AI agent. Adding agents to the loop doesn't mean we need to reinvent software engineering from scratch — it just means we move faster.

Blueprint has five commands because that's all you need. If your spec framework requires a tutorial to understand, it's the framework that's the problem.

```mermaid
graph LR
    A[Requirements] --> B[Technical Design]
    B --> C[Task Breakdown]
    C --> D[Implementation]
    D --> E[Review]
    E --> F[Ship]

    style A fill:#2d333b,stroke:#768390,color:#adbac7
    style B fill:#2d333b,stroke:#768390,color:#adbac7
    style C fill:#2d333b,stroke:#768390,color:#adbac7
    style D fill:#2d333b,stroke:#768390,color:#adbac7
    style E fill:#2d333b,stroke:#768390,color:#adbac7
    style F fill:#2d333b,stroke:#768390,color:#adbac7
```

This is the SDLC. It has worked for decades. Blueprint just makes each step a command.

## How it maps

| SDLC Phase | Traditional | Blueprint |
|---|---|---|
| **Requirements** | PM writes PRD, stakeholder reviews | `/blueprint:requirements` |
| **Technical Design** | Eng writes design doc, architecture review | `/blueprint:architecture` |
| **Planning** | Sprint planning, ticket breakdown | `/blueprint:plan` |
| **Implementation** | Engineer picks up ticket, branches | `/blueprint:branch` |
| **Delivery** | Code committed, PR reviewed | `/blueprint:commit` |

The only difference is speed. What takes a team days of meetings and doc reviews collapses into minutes. The discipline is identical. Requirements before design. Design before planning. Planning before code.

## Install

```
/plugin marketplace add owainlewis/blueprint
/plugin install blueprint@owainlewis-blueprint
```

## Commands

```
/blueprint:requirements    Rough notes → REQUIREMENTS.md
/blueprint:architecture    Requirements → ARCHITECTURE.md
/blueprint:plan            Architecture → TASKS.md (with Linear export)
/blueprint:branch          Create branch with conventional naming (feature/, fix/, docs/, ...)
/blueprint:commit          Stage and commit with conventional commit messages
```

## Usage

```
/blueprint:requirements I need a CLI tool that parses markdown and generates HTML
/blueprint:architecture
/blueprint:plan
/blueprint:branch feature markdown-parser
  ... build each task ...
/blueprint:commit
```

## Local Development

```bash
claude --plugin-dir /path/to/blueprint
```

# Blueprint

A Claude Code plugin that encodes the standard software development lifecycle as executable commands.

## Why

Every serious engineering org follows the same process: gather requirements, write a technical design, break the work into tasks, then execute. Blueprint doesn't invent anything new — it just makes this discipline the default when working with AI agents.

AI agents produce better output when given the same structured inputs a good engineer expects. Clear requirements. Explicit architecture decisions. Atomic, well-scoped tasks. Skip any of those steps and quality drops, same as it would with a human team.

| SDLC Phase | Traditional | Blueprint |
|---|---|---|
| **Requirements** | PM writes PRD, stakeholder reviews | `/blueprint:requirements` |
| **Technical Design** | Eng writes design doc, architecture review | `/blueprint:architecture` |
| **Planning** | Sprint planning, ticket breakdown | `/blueprint:plan` |
| **Implementation** | Engineer picks up ticket, branches | `/blueprint:branch` |
| **Delivery** | Code committed, PR reviewed | `/blueprint:commit` |

The only difference from a traditional SDLC is speed. What takes a team days of meetings and doc reviews collapses into minutes, but the discipline is identical. Requirements before design. Design before planning. Planning before code.

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

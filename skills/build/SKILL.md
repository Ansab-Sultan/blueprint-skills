---
name: build
description: "Implement one task or scoped change: make the change, add valuable tests, and verify it works. Works with blueprint files (docs/<feature>/blueprint.md), plan files (docs/<feature>/plan.md), or standalone task descriptions."
user-invocable: true
argument-hint: "<task reference or description> e.g. 'Task 2 from user-auth' or 'all tasks from user-auth' or 'add rate limiting to the API'"
---

# Build

## When to use

- Implementing a single task from a blueprint or plan
- Running all tasks from a blueprint or plan in one shot
- Executing a clear, scoped behavioral change with no document

---

## Mode Detection

Determine which mode to use based on the argument:

### Mode A — Single task from a blueprint or plan
Triggered when the argument references a specific task, e.g.:
- `Task 3 from user-auth`
- `Task 1 from payment-flow`

→ Follow the **Single Task Process** below.

### Mode B — All tasks from a blueprint or plan (one-shot)
Triggered when the argument says "all tasks", e.g.:
- `all tasks from user-auth`
- `run everything from payment-flow`

→ Follow the **One-Shot Process** below.

### Mode C — No document (standalone task)
Triggered when no blueprint or plan is referenced. The argument is a plain description.

→ Follow the **Single Task Process** below, treating the argument as the full task definition.

---

## Single Task Process

1. **Load context**
   - Check for a source document in this order:
     1. `docs/<feature-name>/blueprint.md` (produced by the `blueprint` skill)
     2. `docs/<feature-name>/plan.md` (produced by the `plan` skill, used after `spec`)
   - Read whichever file exists in full before touching any code.
   - Locate the specific task by its number and title.
   - Read every file the task's Scope section mentions before editing anything.

2. **Confirm scope**
   - If the task references acceptance criteria, internalize all of them before starting.
   - If the task scope is vague or contradicts the codebase, stop and clarify — do not invent scope.

3. **Implement**
   - Make the smallest safe change that satisfies all acceptance criteria.
   - Follow the exact conventions, patterns, and file structure used in the rest of the codebase.
   - Handle all error paths described in the task's Error Handling section.

4. **Test**
   - Add or update tests for every behavioral change, bug fix, or interface change.
   - Run the task's Verify commands. Fix failures before proceeding.
   - Run the full test suite if practical.

5. **Report**
   - State which acceptance criteria passed.
   - If something could not be verified, say so explicitly — never silently skip.
   - Remind the user of the next task if one exists.

---

## One-Shot Process

> Use when the user wants the entire blueprint executed in a single session.

1. Check for a source document in this order:
   - `docs/<feature-name>/blueprint.md` (produced by the `blueprint` skill)
   - `docs/<feature-name>/plan.md` (produced by the `plan` skill, used after `spec`)
   - Read whichever file exists in full.
2. Confirm the total number of tasks with the user before starting.
3. Execute tasks **strictly in order**. Do not skip or reorder.
4. After each task:
   - Run its Verify commands.
   - Confirm all acceptance criteria are met.
   - If a task fails, stop immediately and report the failure. Do not continue to the next task with a broken state.
5. After all tasks, run the **Full Verification** block if one exists in the document.
6. Report a final summary: tasks completed, tests passed, anything that could not be verified.

---

## Verification

- The behavior matches the task or blueprint acceptance criteria
- New or changed behavior is covered by tests where it matters
- Tests pass
- Verify commands from the task or blueprint were run and passed
- No unrelated scope was added

---

## Rules

- **One task at a time in Mode A.** Never pull scope from adjacent tasks even if they seem related.
- **In Mode B, never skip a task** because it seems trivial. Each task exists for a reason.
- **Always read the full blueprint before starting**, not just the target task — earlier tasks establish context.
- **Make the smallest safe change** that fully solves the task.
- **Preserve contracts** unless the task explicitly changes them. If a contract must change, call it out clearly.
- **Handle failure paths explicitly** instead of leaving them implicit.
- **Do not hide missing verification.** If you could not run something important, say so.
- **Do not use this skill as an excuse for unrelated refactors.**
- **If no blueprint or plan exists and the request is vague, oversized, or mixes multiple concerns**, stop and suggest running `/skill:blueprint` first (or `/skill:spec` + `/skill:plan` for team workflows).

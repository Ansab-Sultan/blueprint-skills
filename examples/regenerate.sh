#!/bin/bash
# Regenerate golden examples using Blueprint skills.
# Run from the repo root: ./examples/regenerate.sh
#
# This is a manual review process, not an automated test.
# After regeneration, diff the output against the previous examples
# to check for regressions when skills change.

set -e

DIR="$(cd "$(dirname "$0")" && pwd)"
INPUT="$DIR/input.md"

echo "==> Generating requirements..."
claude --plugin-dir . "/blueprint:requirements $DIR/REQUIREMENTS.md $(cat "$INPUT")"

echo ""
echo "==> Generating architecture..."
claude --plugin-dir . "/blueprint:architecture $DIR/REQUIREMENTS.md $DIR/ARCHITECTURE.md"

echo ""
echo "==> Generating plan..."
claude --plugin-dir . "/blueprint:plan $DIR/REQUIREMENTS.md $DIR/ARCHITECTURE.md $DIR/TASKS.md"

echo ""
echo "==> Done. Review the diffs:"
echo "    git diff examples/"

#!/usr/bin/env bash
# Re-deploy the latest graph.html to GitHub Pages.
# Run from anywhere: ./update-graph.sh
#
# Assumes:
#   - graphify-out/graph.html exists at SOURCE below
#   - this directory is a clone of zkumar/healthcare-ai-book-graph
#   - `git push` works without prompts
set -euo pipefail

SOURCE="/Users/vijayzharotia/Documents/Claude/Projects/My Book/graphify-out/graph.html"
REPO_DIR="$(cd "$(dirname "$0")" && pwd)"

if [ ! -f "$SOURCE" ]; then
    echo "error: $SOURCE not found. Run /graphify . in the book folder first." >&2
    exit 1
fi

cp "$SOURCE" "$REPO_DIR/index.html"

cd "$REPO_DIR"
if git diff --quiet index.html; then
    echo "No changes — graph already up to date."
    exit 0
fi

git add index.html
git commit -m "Update graph ($(date +%Y-%m-%d))"
git push

echo
echo "Pushed. Live in ~30s at: https://zkumar.github.io/healthcare-ai-book-graph/"

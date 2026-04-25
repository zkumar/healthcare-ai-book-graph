#!/usr/bin/env bash
# Re-deploy the latest graph.html to GitHub Pages.
# Run from anywhere: ./update-graph.sh
#
# Replaces graphify's default <title> with our OG-tag block so the
# LinkedIn / Twitter / Slack link preview keeps working after rebuilds.
set -euo pipefail

SOURCE="/Users/vijayzharotia/Documents/Claude/Projects/My Book/graphify-out/graph.html"
REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
OG_BLOCK="$REPO_DIR/og-tags.html"

if [ ! -f "$SOURCE" ]; then
    echo "error: $SOURCE not found. Run /graphify . in the book folder first." >&2
    exit 1
fi
if [ ! -f "$OG_BLOCK" ]; then
    echo "error: $OG_BLOCK not found." >&2
    exit 1
fi

# Copy the fresh graph, then swap graphify's default <title> for our OG block.
cp "$SOURCE" "$REPO_DIR/index.html"

"$(cat "/Users/vijayzharotia/Documents/Claude/Projects/My Book/graphify-out/.graphify_python")" - "$REPO_DIR/index.html" "$OG_BLOCK" <<'PY'
import sys, re, pathlib
html_path = pathlib.Path(sys.argv[1])
og_path   = pathlib.Path(sys.argv[2])
html = html_path.read_text()
og   = og_path.read_text().rstrip()
new = re.sub(r'<title>[^<]*</title>', og, html, count=1)
if new == html:
    print('warning: no <title> tag found, OG block not inserted', file=sys.stderr)
    sys.exit(1)
html_path.write_text(new)
print(f'OG block injected ({len(og)} chars).')
PY

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

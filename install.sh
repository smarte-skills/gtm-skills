#!/usr/bin/env bash
set -e

REPO="smarte-skills/gtm-skills"
BRANCH="main"
SKILLS_DIR="$HOME/.claude/skills"
TMP_DIR="$(mktemp -d)"

echo ""
echo "Installing SMARTe GTM Skills for Claude Code..."
echo ""

# Clean up temp dir on exit
trap 'rm -rf "$TMP_DIR"' EXIT

# Clone the repo into a temp directory
git clone --depth 1 --branch "$BRANCH" "https://github.com/$REPO.git" "$TMP_DIR/gtm-skills" --quiet

# Create the skills directory if it doesn't exist
mkdir -p "$SKILLS_DIR"

# Copy each skill folder (one level below each category folder)
INSTALLED=0
while IFS= read -r -d '' skill_dir; do
  skill_name="$(basename "$skill_dir")"
  cp -r "$skill_dir" "$SKILLS_DIR/$skill_name"
  echo "  + $skill_name"
  INSTALLED=$((INSTALLED + 1))
done < <(find "$TMP_DIR/gtm-skills/skills" -mindepth 2 -maxdepth 2 -type d -print0)

echo ""
echo "$INSTALLED skills installed to $SKILLS_DIR"
echo ""
echo "Open Claude Code and invoke any skill with a slash command, e.g.:"
echo "  /prospect-list-builder"
echo "  /cold-email-writer"
echo "  /icp-scorer"
echo ""

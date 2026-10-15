#!/bin/bash
# Install the LinkedIn agent skills and the voice profile into ~/.claude so
# every Claude Code on the web session on this repo has /li-* ready to use.
set -euo pipefail

if [ "${CLAUDE_CODE_REMOTE:-}" != "true" ]; then
  exit 0
fi

repo="${CLAUDE_PROJECT_DIR:-$(cd "$(dirname "$0")/../.." && pwd)}"

mkdir -p "$HOME/.claude/skills" "$HOME/.claude/linkedin"
for dir in "$repo"/skills/li-*/; do
  name="$(basename "$dir")"
  rm -rf "$HOME/.claude/skills/$name"
  cp -r "$dir" "$HOME/.claude/skills/$name"
done

# Never overwrite a voice profile edited during the session (resume/compact).
if [ -f "$repo/linkedin/voice.md" ] && [ ! -f "$HOME/.claude/linkedin/voice.md" ]; then
  cp "$repo/linkedin/voice.md" "$HOME/.claude/linkedin/voice.md"
fi

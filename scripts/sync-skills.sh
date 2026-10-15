#!/usr/bin/env bash
# Refresh skills/ from pnp/sharepoint-skills (master copy). Read-only on GitHub.
# Usage: scripts/sync-skills.sh   (needs git; uses public HTTPS clone)
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
REPO="https://github.com/pnp/sharepoint-skills.git"
# skill-name|git ref ("main" or "pull/<n>/head" for unmerged PRs)
SKILLS=(
  "campaign-story|main"
  "document-browser|main"
  "flashcards-dashboard|main"
  "narrated-story-animation|main"
  "topic-explainer|main"
  "team-newsletter-publisher|pull/74/head"   # switch to main once PR #74 merges
)
TMP="$(mktemp -d)"; trap 'rm -rf "$TMP"' EXIT
git clone -q --filter=blob:none "$REPO" "$TMP/src"
for entry in "${SKILLS[@]}"; do
  name="${entry%%|*}"; ref="${entry##*|}"
  ( cd "$TMP/src"; git fetch -q origin "$ref"; git checkout -q FETCH_HEAD )
  src="$TMP/src/Skills/$name/$name"
  [ -f "$src/SKILL.md" ] || { echo "missing $src/SKILL.md" >&2; exit 1; }
  rm -rf "$ROOT/skills/$name"; cp -r "$src" "$ROOT/skills/$name"
  sha=$(cd "$TMP/src" && git rev-parse --short HEAD)
  printf 'Source: https://github.com/pnp/sharepoint-skills/tree/main/Skills/%s\nRef: %s @ %s\nLicense: MIT (PnP). Author: Anand Vijayaragavan.\n' "$name" "$ref" "$sha" > "$ROOT/skills/$name/SOURCE.md"
  n=$(find "$ROOT/skills/$name" -type f ! -name SKILL.md | wc -l)
  [ "$n" -le 20 ] || echo "WARN: $name has $n extra files (>20 M365 limit)" >&2
  echo "synced $name ($ref @ $sha)"
done

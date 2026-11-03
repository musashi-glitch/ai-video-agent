#!/usr/bin/env bash
# Symlink every skill in skills/ into ~/.agents/skills and ~/.claude/skills.
# Existing entries with the same name are moved to <name>.bak-<timestamp>, never deleted.
set -euo pipefail
repo="$(cd "$(dirname "$0")" && pwd)"
stamp="$(date +%Y%m%d-%H%M%S)"
if [ "$#" -gt 0 ]; then targets=("$@"); else targets=("$HOME/.agents/skills" "$HOME/.claude/skills"); fi

for dest in "${targets[@]}"; do
  mkdir -p "$dest"
  for skill in "$repo"/skills/*/; do
    name="$(basename "$skill")"
    link="$dest/$name"
    src="${skill%/}"
    if [ -L "$link" ] && [ "$(readlink "$link")" = "$src" ]; then
      echo "ok      $link"
      continue
    fi
    if [ -e "$link" ] || [ -L "$link" ]; then
      mv "$link" "$link.bak-$stamp"
      echo "backup  $link -> $link.bak-$stamp"
    fi
    ln -s "$src" "$link"
    echo "linked  $link -> $src"
  done
done

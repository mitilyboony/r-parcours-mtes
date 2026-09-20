#!/usr/bin/env bash
set -euo pipefail
target="both"
destination=""
while [[ $# -gt 0 ]]; do
  case "$1" in
    --target) target="$2"; shift 2 ;;
    --destination) destination="$2"; shift 2 ;;
    -h|--help) echo "Usage: ./install.sh [--target codex|claude|both] [--destination DIR]"; exit 0 ;;
    *) echo "Option inconnue: $1" >&2; exit 2 ;;
  esac
done
case "$target" in codex|claude|both) ;; *) echo "--target doit être codex, claude ou both" >&2; exit 2 ;; esac
root="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source="$root/skills/r-parcours-mtes"
[[ -f "$source/SKILL.md" ]] || { echo "SKILL.md introuvable" >&2; exit 1; }
install_one() { local base="$1"; local dest="$base/r-parcours-mtes"; mkdir -p "$dest"; cp -R "$source"/. "$dest"/; echo "Skill installé dans $dest"; }
if [[ -n "$destination" ]]; then install_one "$destination"
else
  [[ "$target" == codex || "$target" == both ]] && install_one "${CODEX_HOME:-$HOME/.codex}/skills"
  [[ "$target" == claude || "$target" == both ]] && install_one "${CLAUDE_HOME:-$HOME/.claude}/skills"
fi

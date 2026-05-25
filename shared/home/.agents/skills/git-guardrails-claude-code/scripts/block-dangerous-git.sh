#!/usr/bin/env bash
set -euo pipefail

input=""
if ! [[ -t 0 ]]; then
  input="$(cat)"
fi

command="$*"
if [[ -n "$input" ]] && command -v jq >/dev/null 2>&1; then
  parsed="$(printf '%s' "$input" | jq -r '.tool_input.command // .command // empty' 2>/dev/null || true)"
  [[ -n "$parsed" ]] && command="$parsed"
fi

dangerous_patterns=(
  '(^|[;&|[:space:]])git[[:space:]]+push([[:space:]]|$)'
  '(^|[;&|[:space:]])git[[:space:]]+reset[[:space:]]+--hard([[:space:]]|$)'
  '(^|[;&|[:space:]])git[[:space:]]+clean[[:space:]]+-f(d)?([[:space:]]|$)'
  '(^|[;&|[:space:]])git[[:space:]]+branch[[:space:]]+-D([[:space:]]|$)'
  '(^|[;&|[:space:]])git[[:space:]]+checkout[[:space:]]+\.([[:space:]]|$)'
  '(^|[;&|[:space:]])git[[:space:]]+restore[[:space:]]+\.([[:space:]]|$)'
  '(^|[;&|[:space:]])git[[:space:]].*--force'
)

for pattern in "${dangerous_patterns[@]}"; do
  if printf '%s\n' "$command" | grep -Eq "$pattern"; then
    printf "BLOCKED: '%s' matches dangerous git pattern '%s'. User confirmation required.\n" "$command" "$pattern" >&2
    exit 2
  fi
done

exit 0

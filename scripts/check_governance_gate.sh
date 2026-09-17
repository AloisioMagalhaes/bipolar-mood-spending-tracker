#!/usr/bin/env bash
set -euo pipefail

# The gate is intentionally inert for the local-only prototype. It activates
# only when a change introduces backend or synchronization code.
base_ref="${1:-}"
[[ -n "$base_ref" ]] || base_ref="HEAD^"
changed="$(git diff --name-only "$base_ref" HEAD)"
requires_governance=0
while IFS= read -r path; do
  case "$path" in
    supabase/*|backend/*|lib/*sync*|lib/*synchronization*|lib/*repository*|lib/*remote*)
      requires_governance=1
      break
      ;;
  esac
done <<<"$changed"
if (( ! requires_governance )); then
  echo "Governance gate: no backend/synchronization change detected."
  exit 0
fi

required=(
  docs/approvals/lgpd.md
  docs/approvals/ethics.md
  docs/approvals/threat-model.md
)
missing=0
for file in "${required[@]}"; do
  if [[ ! -s "$file" ]] || grep -Eiq 'pending|not approved|template|placeholder' "$file"; then
    echo "Missing or non-final governance evidence: $file" >&2
    missing=1
  fi
done
if (( missing )); then
  echo "Synchronization/backend promotion blocked: formal LGPD, ethics and threat-model evidence is required." >&2
  exit 1
fi
echo "Governance gate: formal evidence found. Continue with security review and authorization tests."

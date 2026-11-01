#!/usr/bin/env bash
# Runs entrypoint.sh against throwaway repositories and checks its exit code.

set -euo pipefail

ENTRYPOINT="$(cd "$(dirname "$0")/.." && pwd)/entrypoint.sh"
TMP=$(mktemp -d)
trap 'rm -rf "$TMP"' EXIT

# entrypoint.sh writes to the global git config.
export HOME="$TMP/home"
mkdir -p "$HOME"
export GIT_AUTHOR_NAME=test GIT_AUTHOR_EMAIL=test@example.com
export GIT_COMMITTER_NAME=test GIT_COMMITTER_EMAIL=test@example.com

FAILURES=0

# Usage: run_case <name> <expected exit code> [commit message...]
# Clones a repo whose default branch has one commit, adds an empty commit per
# message on a feature branch, and runs entrypoint.sh at its tip.
run_case() {
  local name=$1 expected=$2
  shift 2
  local dir="$TMP/$name"
  git init -q --bare -b main "$dir/origin.git"
  git clone -q "$dir/origin.git" "$dir/work" 2> /dev/null
  (
    cd "$dir/work"
    git commit -q --allow-empty -m 'initial'
    git push -q origin main
    git checkout -q -b feature
    for message in "$@"; do
      git commit -q --allow-empty -m "$message"
    done
  )

  local actual=0
  (
    cd "$dir/work"
    GITHUB_SHA=$(git rev-parse HEAD) GITHUB_STEP_SUMMARY="$dir/summary" "$ENTRYPOINT"
  ) > "$dir/output" 2>&1 || actual=$?

  if [ "$actual" -eq "$expected" ]; then
    echo "ok: $name"
  else
    echo "not ok: $name (expected exit $expected, got $actual)"
    sed 's/^/    /' "$dir/output"
    FAILURES=$((FAILURES + 1))
  fi
}

run_case no-commits 0
run_case clean-commits 0 'feat: one' 'fix: two'
run_case no-push 1 'feat: one' '#no-push test'
run_case nopush 1 '#nopush test'
run_case no-push-in-body 0 $'feat: one\n\nmentions #no-push mid-line'
run_case no-push-body-line 1 $'feat: one\n\n#no-push'

exit $(( FAILURES > 0 ))

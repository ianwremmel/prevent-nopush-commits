#!/usr/bin/env bash

set -euo pipefail

# for reasons I can't explain, we still need to `git fetch` even with 
# `fetch-depth: 0`. Perhaps fetch depth only grabs the history of the current 
# SHA and doesn't bother with branch names?
git fetch > /dev/null 2> /dev/null

MERGE_BASE=$(git merge-base HEAD origin/master)
COUNT="$(git log "$MERGE_BASE"..HEAD | grep -E -c '^\s*#no-?push')"
if (( COUNT == 0 )); then 
    exit 0
else
    echo 'found no push commits. please use interactive rebase to remove them before merging'
    exit 1
fi
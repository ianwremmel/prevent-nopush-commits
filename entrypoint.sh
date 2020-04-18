#!/usr/bin/env bash

set -euo pipefail

# for reasons I can't explain, we still need to `git fetch` even with 
# `fetch-depth: 0`. Perhaps fetch depth only grabs the history of the current 
# SHA and doesn't bother with branch names?
git fetch > /dev/null 2> /dev/null

echo 'Computing merge base'
MERGE_BASE=$(git merge-base HEAD origin/master)
echo "Found merge base $MERGE_BASE"

echo 'Counting #no-push commits'
COUNT="$(git log "$MERGE_BASE"..HEAD | grep -E -c '^\s*#no-?push')"
echo "Found $COUNT #no-push commits"

if (( COUNT == 0 )); then 
    echo 'Did not find any #no-push commits. Exiting cleanly'
    exit 0
else
    echo 'Found #no-push commits. Failing workflow.'
    echo 'Please use interactive rebase to remove merge commits'
    exit 1
fi
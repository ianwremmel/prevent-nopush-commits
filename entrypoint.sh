#!/usr/bin/env bash

set -euo pipefail

git fetch origin master

if [ "$(git log "$(git merge-base HEAD origin/master)"..HEAD | grep -c '^#no-?push')" -eq 0 ]; then 
    exit 0  
else
    echo 'found no push commits. please use interactive rebase to remove them before merging'
    exit 1
fi
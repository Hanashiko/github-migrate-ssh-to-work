#!/usr/bin/env bash

set -euo pipefail

DRY_RUN=false
[[ "${1:-}" == "-n" ]] && DRY_RUN=true

OLD="git@github.com:"
NEW="git@github-work:"

find . -maxdepth 2 -name ".git" -type d | while read -r gitdir; do
    repo=$(dirname "$gitdir")
    remote_url=$(git -C "$repo" remote get-url origin 2>/dev/null || echo "")

    if [[ -z "$remote_url" ]]; then
        echo "SKIP $repo — no remote origin"
        continue
    fi

    if [[ "$remote_url" == "$OLD"* ]]; then
        new_url="${NEW}${remote_url#$OLD}"
        if $DRY_RUN; then
            echo "DRY  $repo"
        else
            git -C "$repo" remote set-url origin "$new_url"
            echo "OK   $repo"
        fi
        echo "     $remote_url -> $new_url"
    else
        echo "SKIP $repo — $remote_url"
    fi
done

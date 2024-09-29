#!/usr/bin/env bash

set -e

if [ $# -ne 4 ]; then
    echo "Usage: $0 <owner> <label> <desc> <color>"
    exit 1
fi

owner=$1
label=$2
desc=$3
color=$4

repos=$(gh repo list $owner --limit 30 --json name --jq '.[].name')

echo -e "repos:\n$(echo $repos | xargs)"

echo ""
echo "gh label create $label --repo $owner/REPO --color $color --description $desc --force"
echo ""
gum confirm "proceed?"

while IFS= read -r repo; do
    gh label create $label --repo $owner/$repo --color $color --description $desc --force
done <<<"$repos"

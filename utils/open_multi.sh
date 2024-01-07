#!/bin/bash

# Read URLs from stdin and use xargs to run 'open' for each URL

browser="${1:-"Brave Browser"}"

while read -r url; do
  open -a "$browser" "$url"
done < /dev/stdin

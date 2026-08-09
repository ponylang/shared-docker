#!/bin/sh

set -e

if [ $# -gt 0 ]; then
  exec markdownlint-cli2 "$@"
fi

set -- "**/*.md"

if [ -f .markdownlintignore ]; then
  while IFS= read -r line || [ -n "$line" ]; do
    case "$line" in
      ''|'#'*) continue ;;
    esac
    set -- "$@" "#${line%/}"
  done < .markdownlintignore
fi

exec markdownlint-cli2 "$@"

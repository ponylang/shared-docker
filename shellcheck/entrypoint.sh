#!/bin/sh

set -e

if [ $# -gt 0 ]; then
  shellcheck "$@"
else
  files=$(find . -type f \( -name '*.sh' -o -name '*.bash' \))

  if [ -z "$files" ]; then
    echo "No shell scripts found."
    exit 0
  fi

  echo "$files" | xargs shellcheck
fi

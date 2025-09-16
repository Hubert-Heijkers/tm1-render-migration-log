#!/bin/bash

set -e

# Check if name parameter was given
if [ -z "$1" ]; then
  echo "Usage: $0 <name>" >&2
  exit 1
fi

NAME="$1"
SCRIPT_DIR="$(dirname "$0")"
OUTPUT_FILE="${NAME}.html"

# Convert the markdown on stdin and have Pandoc covert it to HTML
pandoc -f markdown -t html -s --include-in-header=${SCRIPT_DIR}/pandoc_template/header-default.html --include-before-body=${SCRIPT_DIR}/pandoc_template/before.html --include-after-body=${SCRIPT_DIR}/pandoc_template/after.html -o "$OUTPUT_FILE"

# Open in default browser (Windows)
explorer.exe "$(cygpath -w "$OUTPUT_FILE")"
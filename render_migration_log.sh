#!/bin/bash

set -e

# Check if name parameter was given
if [ -z "$1" ]; then
  echo "Usage: $0 <name>" >&2
  exit 1
fi

NAME="$1"
SCRIPT_DIR="$(dirname "$0")"
TEMPLATE_FILE="${SCRIPT_DIR}/render/template.j2"
MARKDOWN_FILE="${NAME}.md"
OUTPUT_FILE="${NAME}.html"
RENDER_SCRIPT="${SCRIPT_DIR}/render/render.py"

echo $TEMPLATE_FILE
echo ${SOURCE}/render/render.py

if [ ! -f "$TEMPLATE_FILE" ]; then
  echo "Template file '${TEMPLATE_FILE}' not found." >&2
  exit 2
fi

if [ ! -f "$RENDER_SCRIPT" ]; then
  echo "render.py not found at expected location: $RENDER_SCRIPT" >&2
  exit 3
fi

# Use Python to run render.py to generate, intermediate, markdown and have Pandoc covert it to HTML
python "$RENDER_SCRIPT" "$TEMPLATE_FILE" | pandoc -f markdown -t html -s --include-in-header=${SCRIPT_DIR}/pandoc_template/header-default.html --include-before-body=${SCRIPT_DIR}/pandoc_template/before.html --include-after-body=${SCRIPT_DIR}/pandoc_template/after.html -o "$OUTPUT_FILE"

# Open in default browser (Windows)
explorer.exe "$(cygpath -w "$OUTPUT_FILE")"
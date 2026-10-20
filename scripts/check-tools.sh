#!/bin/sh
# Checks the tools the workspace needs are installed, before it starts.
missing=""

for tool in docker git make curl; do
  command -v "$tool" >/dev/null 2>&1 || missing="$missing $tool"
done

if [ -n "$missing" ]; then
  echo "Missing:$missing" >&2
  exit 1
fi

echo "docker, git, make and curl are installed"

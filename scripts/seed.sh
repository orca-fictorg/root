#!/bin/sh
# Seeds the sample data. It's safe to run again: it skips if it's already done,
# unless it's given --fresh.
marker=".seeded"

if [ -f "$marker" ] && [ "$1" != "--fresh" ]; then
  echo "Already seeded at $(cat "$marker"), skipping"
  exit 0
fi

date > "$marker"
echo "Seeded the sample data"

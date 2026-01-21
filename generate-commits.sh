#!/usr/bin/env bash
set -euo pipefail

year="${1:-}"
min="${2:-}"
max="${3:-}"

if [[ -z "$year" || -z "$min" || -z "$max" ]]; then
  echo "Usage: $0 <year> <min_commits> <max_commits>" >&2
  exit 1
fi

if ! [[ "$year" =~ ^[0-9]{4}$ ]]; then
  echo "Year must be YYYY" >&2
  exit 1
fi

if ! [[ "$min" =~ ^[0-9]+$ && "$max" =~ ^[0-9]+$ && "$min" -le "$max" ]]; then
  echo "min/max must be integers with min <= max" >&2
  exit 1
fi

start_ts="$(date -d "${year}-01-01" +%s)"
end_ts="$(date -d "${year}-12-31" +%s)"

current_ts="$start_ts"
while [[ "$current_ts" -le "$end_ts" ]]; do
  current_day="$(date -d "@$current_ts" +%Y-%m-%d)"
  range=$((max - min + 1))
  commits_today=$((RANDOM % range + min))
  for i in $(seq 1 "$commits_today"); do
    GIT_AUTHOR_DATE="${current_day} 12:00:00" \
    GIT_COMMITTER_DATE="${current_day} 12:00:00" \
      git commit --allow-empty -m "chore: ${current_day} (${i}/${commits_today})" >/dev/null
  done
  current_ts=$((current_ts + 86400))
done

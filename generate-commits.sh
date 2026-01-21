#!/usr/bin/env bash
set -euo pipefail

start_date="${1:-}"
end_date="${2:-}"
min="${3:-}"
max="${4:-}"

if [[ -z "$start_date" || -z "$end_date" || -z "$min" || -z "$max" ]]; then
  echo "Usage: $0 <start_date> <end_date> <min_commits> <max_commits>" >&2
  exit 1
fi

if ! [[ "$start_date" =~ ^([0-9]{1,4})-(0?[1-9]|1[0-2])-(0?[1-9]|[12][0-9]|3[01])$ ]]; then
  echo "Start date must be YYYY-MM-DD" >&2
  exit 1
fi
if ! [[ "$end_date" =~ ^([0-9]{1,4})-(0?[1-9]|1[0-2])-(0?[1-9]|[12][0-9]|3[01])$ ]]; then
  echo "End date must be YYYY-MM-DD" >&2
  exit 1
fi

if ! [[ "$min" =~ ^[0-9]+$ && "$max" =~ ^[0-9]+$ && "$min" -le "$max" ]]; then
  echo "min/max must be integers with min <= max" >&2
  exit 1
fi

start_ts="$(date -d "${start_date}" +%s)"
end_ts="$(date -d "${end_date}" +%s)"

current_ts="$start_ts"
while [[ "$current_ts" -le "$end_ts" ]]; do
  current_day="$(date -d "@$current_ts" +%Y-%m-%d)"
  range=$((max - min + 1))
  commits_today=$((RANDOM % range + min))

  for i in $(seq 1 "$commits_today"); do
    hour=$((RANDOM % 24))
    minutes=$((RANDOM % 60))
    seconds=$((RANDOM % 60))
    time=${hour}:${minutes}:${seconds}

    GIT_AUTHOR_DATE="${current_day} ${time}" \
    GIT_COMMITTER_DATE="${current_day} ${time}" \
      git commit --allow-empty -m "chore: ${current_day} (${i}/${commits_today})" >/dev/null
  done

  current_ts=$((current_ts + 86400))
done

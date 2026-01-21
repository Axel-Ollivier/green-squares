# chart-booster

![green squares everywhere](Untitled.png)

## Usage
Run from inside the target repo:

```bash
./generate-commits.sh <start_date> <end_date> <min_commits> <max_commits>
```

Example:

```bash
./generate-commits.sh 2026-01-20 2026-01-23 2 5
```

Notes:
- Commits are empty (`--allow-empty`) and dated at a random time local time (later commits can have been in the past).
- Volume is randomized per day between min and max (inclusive).
- Targeted repo on current branch will be flooded. Use a dedicated repo/branch or face the consequences.

run, push, enjoy.

# chart-booster

![green squares everywhere](Untitled.png)

## Usage
Run from inside the target repo:

```bash
./generate-commits.sh <year> <min_commits> <max_commits>
```

Example:

```bash
./generate-commits.sh 2023 1 5
```

Notes:
- Commits are empty (`--allow-empty`) and dated at 12:00 local time.
- Volume is randomized per day between min and max (inclusive).
- targeted repo whil be flooded. use a dedicated repo or face the consequences.

run, push, enjoy.

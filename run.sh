#!/usr/bin/env bash
set -euo pipefail

successful_runs=0
total_runs=0

for file in *.sh; do
    [[ "$file" == "run.sh" ]] && continue
    total_runs=$((total_runs + 1))

    if bash "$file"; then
        successful_runs=$((successful_runs + 1))
    fi
done

echo "$successful_runs/$total_runs scripts ran successfully"

#!/usr/bin/env bash
set -euo pipefail

for file in *.sh do
    [[ "$file" == "run.sh" ]] && continue

    echo "Running $file"
    bash "$file"
done

echo "All scripts complete"
#!/usr/bin/env bash
set -euo pipefail
for p in patches/*.patch; do
  git -C agv-dispatcher/modules/jules-vanager am -3 "$p" || {
    echo "FAILED: $p"
    exit 1
  }
done

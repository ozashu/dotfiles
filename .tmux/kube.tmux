#!/usr/bin/env bash

set -euo pipefail

if ! command -v kubectl >/dev/null 2>&1; then
  exit 0
fi

context="$(kubectl config current-context 2>/dev/null || true)"
if [[ -z "$context" ]]; then
  exit 0
fi

namespace="$(kubectl config view --minify \
  --output 'jsonpath={..namespace}' 2>/dev/null || true)"
printf 'K8s: %s/%s' "$context" "${namespace:-default}"

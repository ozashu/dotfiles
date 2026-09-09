#!/usr/bin/env bash

set -euo pipefail

if ! command -v kubectl >/dev/null 2>&1; then
  exit 0
fi

if [[ -z "${KUBECONFIG:-}" ]] &&
  command -v cmd.exe >/dev/null 2>&1 &&
  command -v wslpath >/dev/null 2>&1; then
  windows_user_profile="$(
    cmd.exe /d /c echo %USERPROFILE% 2>/dev/null | tr -d '\r'
  )"
  if [[ -n "$windows_user_profile" ]]; then
    windows_user_profile="$(wslpath -u "$windows_user_profile" 2>/dev/null || true)"
    windows_kubeconfig="$windows_user_profile/.kube/config"
    if [[ -f "$windows_kubeconfig" ]]; then
      export KUBECONFIG="$windows_kubeconfig"
    fi
  fi
fi

context="$(kubectl config current-context 2>/dev/null || true)"
if [[ -z "$context" ]]; then
  exit 0
fi

namespace="$(kubectl config view --minify \
  --output 'jsonpath={..namespace}' 2>/dev/null || true)"
printf 'K8s: %s/%s' "$context" "${namespace:-default}"

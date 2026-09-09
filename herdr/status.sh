#!/usr/bin/env bash

set -euo pipefail

parts=()

if command -v kubectl >/dev/null 2>&1; then
  if [[ -z "${KUBECONFIG:-}" ]] &&
    command -v cmd.exe >/dev/null 2>&1 &&
    command -v wslpath >/dev/null 2>&1; then
    windows_user_profile="$(
      cmd.exe /d /c echo %USERPROFILE% 2>/dev/null | tr -d '\r'
    )"
    if [[ -n "$windows_user_profile" ]]; then
      windows_user_profile="$(
        wslpath -u "$windows_user_profile" 2>/dev/null || true
      )"
      windows_kubeconfig="$windows_user_profile/.kube/config"
      if [[ -f "$windows_kubeconfig" ]]; then
        export KUBECONFIG="$windows_kubeconfig"
      fi
    fi
  fi

  context="$(kubectl config current-context 2>/dev/null || true)"
  if [[ -n "$context" ]]; then
    namespace="$(kubectl config view --minify \
      --output 'jsonpath={..namespace}' 2>/dev/null || true)"
    parts+=("K8s: $context/${namespace:-default}")
  fi
fi

if command -v git >/dev/null 2>&1 &&
  git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  branch="$(git symbolic-ref --quiet --short HEAD 2>/dev/null ||
    git rev-parse --short HEAD 2>/dev/null || true)"
  if [[ -n "$branch" ]]; then
    parts+=("Git: $branch")
  fi
fi

if ((${#parts[@]})); then
  printf '%s' "${parts[0]}"
  for part in "${parts[@]:1}"; do
    printf ' · %s' "$part"
  done
  printf '\n'
fi

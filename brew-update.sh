#!/usr/bin/env bash
set -euo pipefail

if ! command -v brew >/dev/null 2>&1; then
  exit 0
fi

export PATH="$HOME/.linuxbrew/bin:$PATH"

brew update
brew upgrade
brew cleanup

# Notificação (somente se possível)
if command -v notify-send >/dev/null 2>&1 && [ -n "${DISPLAY:-}" ]; then
  notify-send "🍺 Brew" "Atualizado com sucesso!"
fi

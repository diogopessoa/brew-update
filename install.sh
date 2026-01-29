#!/usr/bin/env bash
set -euo pipefail

# ============================================================
# VERIFICAÇÃO: NÃO EXECUTAR COMO ROOT
# ============================================================
if [[ $EUID -eq 0 ]]; then
  echo "ERRO: Não execute este script com sudo ou como root!"
  echo "Use:"
  echo "  curl -fsSL https://raw.githubusercontent.com/diogopessoa/brew-update/main/install.sh | bash"
  exit 1
fi

# ============================================================
# CORES E ESTILO
# ============================================================
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
BOLD='\033[1m'
NC='\033[0m'

# ============================================================
# STATUS (iniciam como erro)
# ============================================================
status_brew="${RED} ✗${NC}"
status_script="${RED} ✗${NC}"
status_service="${RED} ✗${NC}"
status_timer="${RED} ✗${NC}"

# ============================================================
# CABEÇALHO
# ============================================================
clear
echo -e "${BLUE}╭────────────────────────────────────────╮${NC}"
echo -e "${GREEN}│  ${BOLD}Homebrew Update – Fedora Atomic${NC}${GREEN}       │${NC}"
echo -e "${BLUE}╰────────────────────────────────────────╯${NC}"

# ============================================================
# CONFIGURAÇÕES
# ============================================================
REPO_RAW="https://raw.githubusercontent.com/diogopessoa/brew-update/main"

BIN_DIR="$HOME/.local/bin"
SYSTEMD_USER_DIR="$HOME/.config/systemd/user"

SCRIPT_FILE="$BIN_DIR/brew-update.sh"
SERVICE_FILE="$SYSTEMD_USER_DIR/brew-update.service"
TIMER_FILE="$SYSTEMD_USER_DIR/brew-update.timer"

BREW_BIN="/home/linuxbrew/.linuxbrew/bin/brew"

# ============================================================
# CRIA DIRETÓRIOS
# ============================================================
mkdir -p "$BIN_DIR" "$SYSTEMD_USER_DIR"

# ============================================================
# VERIFICA HOMEBREW
# ============================================================
if [ -x "$BREW_BIN" ]; then
  status_brew="${GREEN} ✓${NC}"
fi

# ============================================================
# DOWNLOAD DOS ARQUIVOS
# ============================================================
if curl -fsSL "$REPO_RAW/brew-update.sh" -o "$SCRIPT_FILE"; then
  chmod +x "$SCRIPT_FILE"
  status_script="${GREEN} ✓${NC}"
fi

if curl -fsSL "$REPO_RAW/brew-update.service" -o "$SERVICE_FILE"; then
  status_service="${GREEN} ✓${NC}"
fi

if curl -fsSL "$REPO_RAW/brew-update.timer" -o "$TIMER_FILE"; then
  status_timer="${GREEN} ✓${NC}"
fi

# ============================================================
# SYSTEMD USER
# ============================================================
systemctl --user daemon-reload >/dev/null 2>&1 || true
systemctl --user enable brew-update.service brew-update.timer >/dev/null 2>&1 || true
systemctl --user start brew-update.timer >/dev/null 2>&1 || true

# ============================================================
# SUMÁRIO FINAL
# ============================================================
echo -e "\n"
echo "▶ Sumário:"
echo -e " $status_brew Homebrew detectado"
echo -e " $status_script brew-update.sh instalado"
echo -e " $status_service brew-update.service configurado"
echo -e " $status_timer brew-update.timer ativo"
echo ""

echo -e "${BLUE}Comandos úteis:${NC}"
echo "  systemctl --user list-timers | grep brew-update"
echo "  systemctl --user status brew-update.timer"

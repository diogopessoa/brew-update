#!/usr/bin/env bash
set -euo pipefail

### VERIFICAÇÃO: NÃO RODAR COMO ROOT
if [[ $EUID -eq 0 ]]; then
  echo "ERRO: Não execute este script com sudo ou como root!"
  echo "      Rode como usuário normal:"
  echo "      curl -fsSL https://raw.githubusercontent.com/diogopessoa/brew-update/main/install.sh | bash"
  exit 1
fi

### CONFIGURAÇÕES
REPO_RAW="https://raw.githubusercontent.com/diogopessoa/brew-update/main"

BIN_DIR="$HOME/.local/bin"
SYSTEMD_USER_DIR="$HOME/.config/systemd/user"

SCRIPT_FILE="$BIN_DIR/brew-update.sh"
SERVICE_FILE="$SYSTEMD_USER_DIR/brew-update.service"
TIMER_FILE="$SYSTEMD_USER_DIR/brew-update.timer"

### LOG
log() { printf '[brew-update-install] %s\n' "$*"; }

### CRIA DIRETÓRIOS
log "Criando diretórios necessários"
mkdir -p "$BIN_DIR" "$SYSTEMD_USER_DIR"

### DOWNLOAD DOS ARQUIVOS
log "Baixando brew-update.sh"
curl -fsSL "$REPO_RAW/brew-update.sh" -o "$SCRIPT_FILE"

log "Baixando brew-update.service"
curl -fsSL "$REPO_RAW/brew-update.service" -o "$SERVICE_FILE"

log "Baixando brew-update.timer"
curl -fsSL "$REPO_RAW/brew-update.timer" -o "$TIMER_FILE"

### PERMISSÕES
log "Tornando brew-update.sh executável"
chmod +x "$SCRIPT_FILE"

### SYSTEMD USER
log "Recarregando systemd (user)"
systemctl --user daemon-reload

log "Habilitando service e timer"
systemctl --user enable brew-update.service brew-update.timer

log "Iniciando timer imediatamente"
systemctl --user start brew-update.timer

### STATUS FINAL
log "Instalação concluída com sucesso"
log "Verifique com:"
log "  systemctl --user status brew-update.timer"
log "  systemctl --user list-timers | grep brew-update"

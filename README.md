[🇧🇷 Português](https://github.com/diogopessoa/brew-update/blob/main/REAMDE-PT_br.md)

# 🍺 Homebrew auto-update (Fedora Atomic)

Automatic update of **Homebrew installed on the host**.

## What does it do
- Updates Homebrew packages on the host
- Timer and weekly update with notification

## Prerequisites
- **Fedora atomic** Silverblue, Kinoite, Fedora COMISC Atomic...
- **Homebrew installed on Fedora Atomic**
  - [Meu guia de Instalação Homebrew no Silverblue](https://github.com/diogopessoa/my-packages-lists/blob/main/silverblue/brew-fedora-silverblue.md)
  - [see the original install](https://brew.sh/)

## File Destination

``` 
Destination Path

├── ~/.local/bin/brew-update.sh # Main executable (brew-update.sh)
├── ~/.config/systemd/user/brew-update.service # Systemd service
└── ~/.config/systemd/user/distrobox-upgrade.timer # No meu caso foi usado o `distrobox-upgrade.timer`
``` 


## Installation

```bash 
# Cria os diretórios locais necessários (binário do usuário e systemd user)
mkdir -p ~/.local/bin ~/.config/systemd/user && \

# Baixa o script de atualização do Homebrew para o host
curl -fsSL https://raw.githubusercontent.com/diogopessoa/brew-update/main/brew-update.sh \
  -o ~/.local/bin/brew-update.sh && \

# Baixa o service do systemd (user service)
curl -fsSL https://raw.githubusercontent.com/diogopessoa/brew-update/main/brew-update.service \
  -o ~/.config/systemd/user/brew-update.service && \

# Torna o script executável
chmod +x ~/.local/bin/brew-update.sh && \

# Recarrega os units do systemd do usuário
systemctl --user daemon-reload && \

# Habilita o service para ser usado por timers ou dependências
systemctl --user enable brew-update.service
```
**✅️ All done!**

### Test in practice

```bash
# 1. copy to terminal:
~/.local/bin/brew-update.sh

# 2. execute:
systemctl --user daemon-reload
systemctl --user start brew-update.service
```

## ⚠️ Create the timer (if necessary)

If you don't have an existing timer like 'distrobox-upgrade.timer', create the unique `brew-update` timer:

**1. File:**

```bash
~/.config/systemd/user/brew-update.timer
```
Enter content (weekly):

```bash
[Unit]
Description=Update Homebrew weekly

[Timer]
# Runs every Wednesday
OnCalendar=Wed 10:00:00
# Tolerance for execution grouping
AccuracySec=1h
# Run if missed last window
Persistent=true

[Install]
WantedBy=timers.target

```

**2. Activate the timer**

```bash
systemctl --user daemon-reload
systemctl --user enable --now brew-update.timer


# Check the timer
systemctl --user list-timers | grep brew
``` 

## License
MIT

## Credits
- [Homebrew](https://brew.sh/)
- [Guia Homebrew no Silverblue](https://github.com/diogopessoa/my-packages-lists/blob/main/silverblue/brew-fedora-silverblue.md)

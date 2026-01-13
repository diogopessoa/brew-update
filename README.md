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
mkdir -p ~/.local/bin ~/.config/systemd/user

curl -fsSL https://raw.githubusercontent.com/diogopessoa/SEU_REPO/main/brew-update.sh \
  -o ~/.local/bin/brew-update.sh

curl -fsSL https://raw.githubusercontent.com/diogopessoa/SEU_REPO/main/brew-update.service \
  -o ~/.config/systemd/user/brew-update.service

chmod +x ~/.local/bin/brew-update.sh

systemctl --user daemon-reload
systemctl --user enable brew-update.service
```

### Test in practice

```bash
# 1. copy to terminal:
~/.local/bin/brew-update.sh

# 2. execute:
systemctl --user daemon-reload
systemctl --user start brew-update.service
```


## License
MIT

## Credits
- [Homebrew](https://brew.sh/)
- [Guia Homebrew no Silverblue](https://github.com/diogopessoa/my-packages-lists/blob/main/silverblue/brew-fedora-silverblue.md)

[🇧🇷 Português](https://github.com/diogopessoa/brew-update/blob/main/REAMDE-PT_br.md)

# 🍺 Homebrew auto-update (Fedora Atomic)

Automatic update of **Homebrew installed on the host**.

## What does it do
- Updates Homebrew packages on the host
- Timer and weekly update with notification

## Prerequisites
- **Fedora atomic** Silverblue, Kinoite, Fedora COSMIC Atomic...
- **Homebrew installed on Fedora Atomic**
  - [Homebrew - Guia de Instalação no Silverblue](https://github.com/diogopessoa/my-packages-lists/blob/main/silverblue/brew-fedora-silverblue.md)
  - [See the original install](https://brew.sh/)

## File Destination

``` 
Destination Path

├── ~/.local/bin/brew-update.sh # Main executable (brew-update.sh)
├── ~/.config/systemd/user/brew-update.service # Systemd service
└── ~/.config/systemd/user/distrobox-upgrade.timer # No meu caso foi usado o `distrobox-upgrade.timer`
``` 


## Installation

Run the following command to execute the script `brew-update`:

```bash
curl -fsSL https://raw.githubusercontent.com/diogopessoa/brew-update/main/install.sh | bash
```
**✅️ All done!**

## License
MIT

## Credits
- [Homebrew](https://brew.sh/)
- [Homebrew - Guia de Instalação no Silverblue](https://github.com/diogopessoa/my-packages-lists/blob/main/silverblue/brew-fedora-silverblue.md)

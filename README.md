# 🍺 Homebrew auto-update (Fedora Atomic)

O script automatiza atualizações semanais dos pacotes Homebrew no host e notifica quando a atualização for concluída.

## Pré-requisitos

- **Fedora atomic** Silverblue, Kinoite, Fedora COSMIC Atomic...
- **Homebrew installed on Fedora Atomic**
  - [Homebrew - Guia de Instalação no Silverblue](https://github.com/diogopessoa/my-packages-lists/blob/main/silverblue/brew-fedora-silverblue.md)
  - [Original Homebrew install](https://brew.sh/)

##  Destino dos Arquivos 

Este mapa mostra o destino de cada arquivo nas pastas após a execução:

``` 
Local dos arquivos 

├── ~/.local/bin/brew-update.sh # Main executable (brew-update.sh)
├── ~/.config/systemd/user/brew-update.service # Systemd service
└── ~/.config/systemd/user/brew.timer # System timer
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

[🇺🇸 English](https://github.com/diogopessoa/my-packages-lists/blob/main/silverblue/brew-fedora-silverblue.md)
# 🍺 Atualização automática do Homebrew (Fedora Atomic)

## O que isso faz
- Atualiza pacotes Homebrew no host
- Cronômetro e atualização semanal com notificação

## Pré-requisitos
- **Fedora atomic** Silverblue, Kinoite, Fedora COMISC Atomic...
- **Homebrew instalado no Fedora Atomic** 
- [Meu guia de Instalação Homebrew no Silverblue](https://github.com/diogopessoa/my-packages-lists/blob/main/silverblue/brew-fedora-silverblue.md) 
- [veja a instalação original](https://brew.sh/)

## Destino do arquivo

```
Caminho de destino

├── ~/.local/bin/brew-update.sh # Executável principal (brew-update.sh)
├── ~/.config/systemd/user/brew-update.service # Serviço Systemd
└── ~/.config/systemd/user/distrobox-upgrade.timer # No meu caso foi usado o `distrobox-upgrade.timer`
```


## Instalação

```bash
# Cria os diretórios locais necessários (binário do usuário e usuário do systemd)
mkdir -p ~/.local/bin ~/.config/systemd/user && \

# Baixe o script de atualização do Homebrew para o host
curl -fsSL https://raw.githubusercontent.com/diogopessoa/brew-update/main/brew-update.sh\ 
-o ~/.local/bin/brew-update.sh && \

# Baixa o serviço do systemd (atendimento ao usuário)
curl -fsSL https://raw.githubusercontent.com/diogopessoa/brew-update/main/brew-update.service\ 
-o ~/.config/systemd/user/brew-update.service && \

# Torna o script seguintevel
chmod +x ~/.local/bin/brew-update.sh && \

# Recarrega as unidades do systemd do usuário
systemctl --user daemon-recarregar && \

# Habilita o serviço para ser usado por timers ou dependências
systemctl --user enable brew-update.service
```
**✅️ Tudo pronto!**

### Teste na prática

```bash
# 1. copie para o terminal:
~/.local/bin/brew-update.sh

# 2. execute:
systemctl --user daemon-recarregar
systemctl --user iniciar brew-update.service
```

## ⚠️ Crie o cronômetro (se necessário)

Se você não possui um cronômetro como 'distrobox-upgrade.timer', crie o cronômetro `brew-update` exclusivo:

**1. Arquivo:**

```bash
~/.config/systemd/user/brew-update.timer
```
Insira o conteúdo (semanalmente):

```bash
[Unidade]
Description=Atualizar o Homebrew semanalmente

[Temporizador]
# Funciona todas as quartas-feiras
OnCalendar=Quarta 10:00:00
# Tolerância para agrupamento de execução
PrecisãoSeg = 1h
# Executa se perdeu a última janela
Persistente = verdadeiro

[Instalar]
ProcuradoBy=timers.target

```

**2. Ative o cronômetro**

```bash
systemctl --user daemon-recarregar
systemctl --user enable --now brew-update.timer


# Verifique o cronômetro
systemctl --user list-timers | grep preparar
```

## Licença
MIT

## Créditos
- [Homebrew](https://brew.sh/)
- [Guia Homebrew no Silverblue](https://github.com/diogopessoa/my-packages-lists/blob/main/silverblue/brew-fedora-silverblue.md)

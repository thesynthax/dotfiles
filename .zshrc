# Minimal, standalone zsh config (NO oh-my-zsh)

# Ensure essential PATH
export PATH="/usr/local/bin:/usr/bin:/bin:$HOME/bin:$PATH"
export XDG_CONFIG_HOME="$HOME/.config"

# Prefer interactive-only blocks
[[ $- != *i* ]] && return   # exit early for non-interactive shells

# User custom functions + plugin dir
ZSH="$HOME/.config/zsh"
fpath=("$ZSH/functions" $fpath)
export TERM="st"

# Load your theme (if it's a raw OMZ theme, it might set PROMPT directly)
# Copy your OMZ theme file into ~/.zsh/themes/refined.zsh-theme first
if [[ -f "$ZSH/themes/refined.zsh-theme" ]]; then
  source "$ZSH/themes/refined.zsh-theme"
else
  # fallback prompt (simple)
  PROMPT='%n@%m %1~ %# '
fi

# Load plugins manually:
source "$ZSH/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh"
source "$ZSH/plugins/zsh-completions/zsh-completions.plugin.zsh"
#source "$ZSH/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh"
source "$ZSH/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"

# ---- completions: set fpath for completions BEFORE compinit ----
fpath=(
  /usr/share/zsh/functions
  /usr/share/zsh/site-functions
  /usr/local/share/zsh/site-functions
  $ZSH/completions   # your custom completions
  $fpath
)

# Autoload and initialize completion system
autoload -Uz compinit compdef || true
zstyle ':completion*' menu select
compinit -u
# remove stale compdump if present
#rm -f ~/.zcompdump* 2>/dev/null || true
# initialize completions
#compinit -u
figlet -f ANSI-shadow "archlinux" | lolcat -p 6 -F 0.01
echo "i use arch btw"

# Useful abbreviations / helpers (migrate from your .zshrc.bak as needed)
#setopt autocd              # example option
bindkey '^R' history-incremental-search-backward

# Source other personal config at end (if you have one)
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local


if [ -f /etc/bash.command-not-found ]; then
    . /etc/bash.command-not-found
fi
alias sudo="doas "
#alias vim="bash -c nvim "
alias "nvim $1"='bash -c "nvim $1"'
alias "nv"='bash -c nvim'
export EDITOR="nvim"
export VISUAL="nvim"
#Pacman Shortcuts
alias sync="doas pacman -Syyy"
alias install="doas pacman -S"
alias update="doas pacman -Syyu"
alias search="doas pacman -Ss"
alias search-local="doas pacman -Qs"
alias pkg-info="doas pacman -Qi"
alias local-install="doas pacman -U"
alias clr-cache="doas pacman -Scc"
alias unlock="doas rm /var/lib/pacman/db.lck"
alias remove="doas pacman -R"
alias autoremove="doas pacman -Rns"
alias irc="weechat"
alias l="exa"
alias ls="exa"
alias la="exa -la"
alias vpnon="doas resolvconf -u; doas wg-quick up arch"
alias vpnoff="doas wg-quick down arch; doas systemctl restart NetworkManager"
alias vpnrestart="vpnoff; vpnon"
alias fastkey="xset r rate 300 40"
alias mirror-update="doas reflector --verbose --country 'India' -l 5 --sort rate --save /etc/pacman.d/mirrorlist"
alias freebsd="doas qemu-system-x86_64 /home/thesynthax/qemu/FreeBSD-15.0-CURRENT-amd64-zfs.qcow2 -enable-kvm -netdev tap,id=net0,ifname=tap0,script=no,downscript=no -device virtio-net-pci,netdev=net0 -daemonize -m 8G -smp cores=5,cpus=10,threads=2,sockets=1 -vga qxl -serial file:/tmp/freebsd_logs.txt"
alias fixwifi="sudo systemctl stop create_ap hostapd; sudo ip link set wlo1 down; sudo iw dev wlo1 set type managed; sudo ip link set wlo1 up; nmcli radio wifi on"
alias fixsound="pulseaudio -k && pulseaudio --start"
. "$HOME/.cargo/env"
alias cat="bat"
alias mpv="devour mpv"
if [ -f /etc/bash.command-not-found ]; then
    . /etc/bash.command-not-found
fi

export PATH="$PATH:$HOME/Applications/JetBrains Rider-2021.3/bin"
[[ ":$PATH:" != *":$HOME/.cargo/bin:"* ]] && PATH="$HOME/.cargo/bin:${PATH}"

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

source /usr/local/gromacs/bin/GMXRC
export PATH=/home/thesynthax/.meteor:$PATH
export ANDROID_HOME=/opt/android-sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools
export OLLAMA_MODELS=/home/thesynthax/.ollama/models
doas ip link set tap0 master virbr0
export PATH=$PATH:/opt/cascadeur

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$HOME/.local/bin:$PATH
export XDG_CONFIG_HOME="$HOME/.config"
# Path to your oh-my-zsh installation.
export ZSH="$HOME/.config/oh-my-zsh"
#export ZSH=/usr/share/oh-my-zsh/
export TERM="st"
# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
#ZSH_THEME="intheloop"
ZSH_THEME="refined" # set by `omz`
#ZSH_THEME="linuxonly"
#source ~/.config/zsh/refined.zsh-theme
#source ~/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
#source ~/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(zsh-autosuggestions fast-syntax-highlighting zsh-completions)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

figlet -f ANSI-shadow "archlinux" | lolcat -p 6 -F 0.01
echo "i use arch btw"

## Advanced Tab Completion
autoload -Uz compinit
#zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion*' menu select
compinit

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
alias la="exa -la"
alias vpnon="doas wg-quick up arch"
alias vpnoff="doas wg-quick down arch"
alias vpnrestart="vpnoff; vpnon"
alias fastkey="xset r rate 300 40"
alias mirror-update="doas reflector --verbose --country 'India' -l 5 --sort rate --save /etc/pacman.d/mirrorlist"
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

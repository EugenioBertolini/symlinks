# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
# Powerlevel10k (to customize prompt, run `p10k configure` or edit ~/.p10k.zsh)
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

# Base paths
export XDG_CACHE_HOME=$HOME/.cache
export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.local/state

# Add environment variables
export EDITOR="/usr/bin/nvim"
export VISUAL="/usr/bin/nvim"
export SUDO_EDITOR="/usr/bin/nvim"
export PAGER="/usr/bin/less"

# ZSH paths
export ZSH="$HOME/.zsh"
export ZSH_COMPLETIONS="$ZSH/completions"
export ZSH_PLUGINS="$ZSH/plugins"

# TMUX
export TMUX_PLUGINS="$HOME/.tmux/plugins"

# # . "/bin" . "/sbin" . "/usr/bin" . "/usr/sbin"
# if ! [[ "$PATH" =~ ":/bin" ]]; then
#   PATH="$PATH:/bin"
# fi
# if ! [[ "$PATH" =~ ":/sbin" ]]; then
#   PATH="$PATH:/sbin"
# fi
# if ! [[ "$PATH" =~ ":/usr/bin" ]]; then
#   PATH="$PATH:/usr/bin"
# fi
# if ! [[ "$PATH" =~ ":/usr/sbin" ]]; then
#   PATH="$PATH:/usr/sbin"
# fi
#
# Add ~/.local/bin and "t" of tmux-session-wizard to PATH
if ! [[ "$PATH" =~ ":$HOME/.local/bin" ]]; then
  PATH="$PATH:$HOME/.local/bin"
fi
if ! [[ "$PATH" =~ ":$TMUX_PLUGINS/tmux-session-wizard/bin" ]]; then
  PATH="$PATH:$TMUX_PLUGINS/tmux-session-wizard/bin"
fi

# Export PATH
export PATH

# Set console name
# DISABLE_AUTO_TITLE="true"
# precmd () {echo -ne "\e]1;$(basename "$PWD")\a"}

# Set Display
# export DISPLAY=:0

# Load completions
autoload -Uz compinit
compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# My plugins
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-you-should-use/you-should-use.plugin.zsh

# Aliases
alias ..='z ..'
alias ...='z ../..'
alias ....='z ../../..'
alias .....='z ../../../..'
alias ......='z ../../../../..'
alias l='eza -lahF --git --icons --group-directories-first --no-permissions --no-user'
alias la='eza -lahF --git --icons --group-directories-first'
alias ls='eza -F --git --icons --group-directories-first'

alias capture='flameshot gui -c -p ~/Pictures/Screenshots > /dev/null 2>&1'
alias screen='flameshot full -c -p ~/Pictures/Screenshots > /dev/null 2>&1'

alias c='clear'
alias e='exit'
alias zr='source ~/.zshrc'
alias yayi='yay -S --needed --answerclean All --answerdiff None'
alias yayr='yay -Rns'
alias yayq='yay -Qq > ~/packages.txt'
alias yaye='yay -Qqe > ~/installed-packages.txt'

alias xx='xmodmap ~/.Xmodmap'
mnas() {
  sudo mount -t cifs -o user=cloudy,password=$1,iocharset=utf8,noperm //172.17.147.1/NAS100TB ~/nas
}
alias sshml='ssh -X fuge@172.17.147.237'

alias vz='nvim ~/.zshrc'
alias vp='nvim ~/.p10k.zsh'
alias vt='nvim ~/.tmux.conf'
alias vg='nvim ~/.gitconfig'
alias vc='nvim ~/.config/nvim'
alias vk='nvim ~/.config/kitty/kitty.conf'
alias vw='nvim ~/.config/wezterm/wezterm.lua'
alias va='nvim ~/.config/alacritty/alacritty.toml'
alias vi3='nvim ~/.config/i3/config'
alias vpb='nvim ~/.config/polybar'

alias neomatrix='neo-matrix --charset=english -m "L A S C I A T E   O G N I   S P E R A N Z A   V O I   C H E   E N T R A T E"'
alias neo='neomatrix -a -b 0 -D -d 0.75 -F -G 20 -l 1,1000 -S 5'
alias neor='neo -c red'
alias neog='neo -c green2'
alias neos='neo -c gray'

alias T='tock -c -m -s -C 1'

alias v='nvim'
alias vv='nvim .'
alias lg='lazygit'
alias py='python'
alias todo='todo.sh'
alias tl='todo list'
alias ta='todo add'
alias td='todo done'
alias pipes='pipes.sh'

# Git aliases
source $ZSH_PLUGINS/git/git.plugin.zsh
source $ZSH_PLUGINS/git/git-auto-fetch.plugin.zsh

# Poetry aliases and automatic virtual env
source $ZSH_PLUGINS/poetry/poetry.plugin.zsh
source $ZSH_PLUGINS/poetry/poetry-env.plugin.zsh

# Poetry don't ask for keyrings
export PYTHON_KEYRING_BACKEND=keyring.backends.fail.Keyring

# Atuin
eval "$(atuin init zsh)"

# Fuck
eval "$(thefuck --alias)"

# Zoxide
eval "$(zoxide init zsh)"

# Gitleaks
eval "$(gitleaks completion zsh)"

# Thefuck
eval $(thefuck --alias)
eval $(thefuck --alias fk)

# Fzf
source <(fzf --zsh)
export FZF_DEFAULT_COMMAND="fd --type=f --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"
_fzf_compgen_path() { fd --hidden --exclude ".git" . "$1" }
_fzf_compgen_dir() { fd --type=d --hidden --exclude ".git" . "$1" }
export BAT_THEME="rose-pine-moon"
export FZF_DEFAULT_OPTS="--color=fg:#908caa,bg:#232136,hl:#ea9a97,fg+:#e0def4,bg+:#393552,hl+:#ea9a97,info:#9ccfd8,prompt:#908caa,pointer:#c4a7e7,marker:#eb6f92,spinner:#f6c177,header:#3e8fb0,border:#44415a,gutter:#232136"

# Fzf-git
source ~/.zsh/fzf-git.sh
export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always --line-range :500 {}'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"
_fzf_comprun() {
  local command=$1
  shift
  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    z)            fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo \$' {}" "$@" ;;
    ssh)          fzf --preview "dig {}" "$@" ;;
    *)            fzf --preview "bat -n --color=always --line-range :500 {}" "$@" ;;
  esac
}

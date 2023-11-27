# NEVER PUT ANYTHING SENSITIVE IN HERE
# SENSITIVE DATA GOES IN .zshrc_local

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

zstyle ':omz:update' mode auto      # update automatically without asking

# Display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
plugins=(git asdf zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# User configuration
export LANG="en_GB.UTF-8"
export EDITOR="nvim"

export PATH="$PATH:$HOME/.local/bin"  # poetry

# Aliases
alias k="kubectl"
alias bu="brew update && brew upgrade && brew cleanup"
alias uu="sudo apt update && sudo apt upgrade"
alias ls="ls -Ah --color=always"
alias dps="docker ps"
alias dk="docker kill"
alias de="docker exec -it"
alias dl="docker logs"
alias vim="nvim"
alias config="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
alias dotenv="set -o allexport; source .env; set +o allexport"  # Load .env file
alias tf="terraform"
alias tfi="terraform init"
alias tfp="terraform plan"
alias tfa="terraform apply"
alias tfv="terraform validate"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

system=$(uname)

if [[ "$system" == "Darwin" ]]; then
        source ~/pomodoro-mac.sh
fi


# If zsh_local.zsh exits, source it.
[ -f "$HOME/.zshrc_local" ] && source "$HOME/.zshrc_local"


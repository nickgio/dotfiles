# Path to your oh-my-zsh installation.
export ZSH=/Users/nickgiovacchini/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="refined"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-syntax-highlighting)

# User configuration

# Variables
user=$(whoami)
host=$(hostname | sed 's/.local//g')
disk=`df | head -2 | tail -1 | awk '{print $5}'`
tty_value=`tty | sed -e "s:/dev/tty::"`
current_time=`date '+%r'`
current_date=`date '+%A %B %d, %Y'`

ECHO
ECHO " Welcome to: $host" 🙊
ECHO " Running: $(uname) $(uname -r) $(uname -m) on $tty_value"
ECHO " It is: $current_time on $current_date" ✌️
ECHO " Using: $disk of your drive." 🍩
ECHO

# Pretty sure this was added at Cratejoy to help set-up my defaults
# export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
# Not sure what this is
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# Include z.sh
. ~/dotfiles/z.sh

# Include custom cheat sheets
export CHEATPATH='~/Dropbox/Mac/cheat/'
export CHEATCOLORS=true # <- Enables colors on cheat sheets

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

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Taken from Nick M
# Simple zsh prompt.
#
# dotfiles ❯ (default)
# dotfiles master ❯ (in git repository)
# root@serv dotfiles master ❯ (with SSH)
#
# * is prepended to git branch name if repo is dirty.
# ❯ is green or red depending on previous command exit status.
#
# Author: Paul Miller (nrmitchi.com)

vcs_info=''

function prompt_nrmitchi_precmd {
  setopt LOCAL_OPTIONS
  unsetopt XTRACE KSH_ARRAYS
}

function list-files {
  ls -G
}

function get-vcs-info {
  vcs_info=''
  git rev-parse --is-inside-work-tree &>/dev/null || return

  local ref=$(git symbolic-ref -q HEAD | sed -e 's|^refs/heads/||')
  if [[ -z "$ref" ]]; then
    vcs_info=''
  else
    st=`git diff --quiet --ignore-submodules HEAD &>/dev/null; [ $? -eq 1 ] && echo '*'`
    vcs_info=" %F{blue}%F{magenta}${ref}${st}%f"
  fi
}

function prompt_nickg_setup {
  setopt LOCAL_OPTIONS
  unsetopt XTRACE KSH_ARRAYS
  prompt_opts=(cr percent subst)

  autoload -Uz add-zsh-hook
  add-zsh-hook precmd get-vcs-info
  add-zsh-hook chpwd list-files
  add-zsh-hook chpwd get-vcs-info

  # zstyle ':omz:module:editor' completing '%B%F{red}...%f%b'

  PROMPT='%F{yellow}%T %F{magenta}${SSH_TTY:+%n@%m }%F{cyan}%1~%f${vcs_info}\
%(!.%B%F{red}#%f%b.%B %(?.%F{green}.%F{red})❯%f%b) '
  # SPROMPT='zsh: correct %F{red}%R%f to %F{green}%r%f [nyae]? '
}

prompt_nickg_setup "$@"

############
# FUNCTIONS
############

# mkdir & cd to it
function mcd() {
    mkdir -p "$1" && cd "$1";
}

# remove results from a find
function findrm() {
    find . -iname "$1" -exec rm -r {} \;
}

#########
# COLORS
#########

autoload -U colors
colors
setopt prompt_subst

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[white]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%})"

# Text to display if the branch is dirty
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%} *%{$reset_color%}"

# Text to display if the branch is clean
ZSH_THEME_GIT_PROMPT_CLEAN=""

# Colors vary depending on time lapsed.
ZSH_THEME_GIT_TIME_SINCE_COMMIT_SHORT="%{$fg[green]%}"
ZSH_THEME_GIT_TIME_SHORT_COMMIT_MEDIUM="%{$fg[yellow]%}"
ZSH_THEME_GIT_TIME_SINCE_COMMIT_LONG="%{$fg[red]%}"
ZSH_THEME_GIT_TIME_SINCE_COMMIT_NEUTRAL="%{$fg[cyan]%}"

#########
# PROMPT
#########
export PS1=$'
%{$fg[blue]%}∴ %d%{$fg[yellow]%}$(~/bin/git-cwd-info)
%{$fg[blue]%}λ %{$reset_color%}'

_lineup=$'\e[1A'
_linedown=$'\e[1B'
RPROMPT=%{${_lineup}%}%{$fg[magenta]%}[%*]%{${_linedown}%}%{$reset_color%}

#############
# COMPLETION
#############

# Show completion on first TAB
setopt menucomplete

# enable cache
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

# ignore completion to commands we don't have
zstyle ':completion:*:functions' ignored-patterns '_*'

# format autocompletion style
zstyle ':completion:*:descriptions' format "%{$fg_bold[green]%}%d%{$reset_color%}"
zstyle ':completion:*:corrections' format "%{$fg_bold[yellow]%}%d%{$reset_color%}"
zstyle ':completion:*:messages' format "%{$fg_bold[red]%}%d%{$reset_color%}"
zstyle ':completion:*:warnings' format "%{$fg_bold[red]%}%d%{$reset_color%}"

# zstyle show completion menu if 2 or more items to select
zstyle ':completion:*'                        menu select=2

# zstyle kill menu
zstyle ':completion:*:*:kill:*'               menu yes select
zstyle ':completion:*:kill:*'                 force-list always
zstyle ':completion:*:*:kill:*:processes'     list-colors "=(#b) #([0-9]#)*=36=31"

# enable color completion
zstyle ':completion:*:default' list-colors "=(#b) #([0-9]#)*=$color[yellow]=$color[red]"

# fuzzy matching of completions for when we mistype them
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only

# number of errors allowed by _approximate increase with the length of what we have typed so far
zstyle -e ':completion:*:approximate:*' max-errors 'reply=($((($#PREFIX+$#SUFFIX)/3))numeric)'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# up and down arrows do history search
autoload -U history-search-end

zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end

bindkey "\e[A" history-beginning-search-backward-end
bindkey "\e[B" history-beginning-search-forward-end

##########
# ALIASES
##########

alias ls='ls -G'
alias ll='ls -lG'
alias duh='du -csh'

alias e='open -a /Applications/Emacs.app $1'

# Git aliases
alias glog="git log -p -40 | vim - -R -c 'set foldmethod=syntax'"

# Bundler
alias be="bundle exec"
alias bi="bundle install"

# CTags
alias ctag="/usr/local/bin/ctags -e -R --extra=+fq --exclude=db --exclude=test --exclude=.git --exclude=public --exclude=tmp --exclude=node_modules --exclude=vendor --exclude=app/assets --exclude=coverage -f TAGS"

# Quick way to rebuild the Launch Services database and get rid
# of duplicates in the Open With submenu.
alias fixopenwith='/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user'

alias psgrep="ps aux | grep "
alias hb="hub browse"
alias internet="ping 8.8.8.8"
alias please='sudo $(fc -ln -1)'

#######
# PATH
#######

export PATH=/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin:/Users/julien/bin:/usr/local/share/npm/bin:/usr/local/share/npm/lib/node_modules:/Users/julien/.cask/bin:/Users/julien/.cabal/bin:/Users/julien/.local/bin:$PATH

#######
# MISC
#######

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# History
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.history

export EDITOR=/usr/local/bin/vim
export SHELL=/usr/local/bin/zsh

# Bundler
export USE_BUNDLER=force

# Emacs mode
bindkey -e

# Autojump
[[ -f `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh

# OpenSSL
export OPENSSL_INCLUDE_DIR=/usr/local/Cellar/openssl/1.0.2h_1/include/

# Stack binaries
export PATH="$HOME/.local/bin:$PATH"

# OPAM
. /Users/julien/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

# Rustup
export PATH="$HOME/.cargo/bin:$PATH"

# Racer
export RUST_SRC_PATH="/Users/julien/Code/rust/src"

# RBEnv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# NVM
export NVM_DIR="$HOME/.nvm"
. "/usr/local/opt/nvm/nvm.sh"

# added by travis gem
[ -f /Users/julien/.travis/travis.sh ] && source /Users/julien/.travis/travis.sh

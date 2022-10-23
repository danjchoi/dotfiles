# vim: filetype=sh

# [ Fish ]
set fish_greeting
export EDITOR="vim"

# [ Pyenv ]
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

status is-login; and pyenv init --path | source
status is-interactive; and pyenv init - | source

# [ Virtualenv ]
export VIRTUAL_ENV_DISABLE_PROMPT=1

# [ Golang ]
export PATH="$PATH:/usr/local/go/bin:$HOME/go/bin"

# [ Aliases ]
#alias subl="/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl"
# alias subl='/mnt/c/Program\ Files/Sublime\ Text\ 3/subl.exe'
alias gs="git status"
alias ga="git add"
alias gc="git commit"
alias gl="git log --oneline"
alias gr="git rebase"
alias gco="git checkout"
alias open="explorer.exe"
alias sp="splitpane"

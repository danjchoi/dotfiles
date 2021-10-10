# vim: filetype=sh

# [ Fish ]
set fish_greeting

# [ Pyenv ]
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

status is-login; and pyenv init --path | source
status is-interactive; and pyenv init - | source

# [ Virtualenv ]
export VIRTUAL_ENV_DISABLE_PROMPT=1

# [ Aliases ]
alias subl="/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl"
alias gs="git status"
alias ga="git add"
alias gc="git commit"
alias gl="git log --oneline"

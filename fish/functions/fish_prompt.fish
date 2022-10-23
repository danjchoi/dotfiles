function fish_prompt --description "Write out the prompt"
    set -l color_cwd
    set -l color_error red
    set -l color_venv yellow
    set -l return_code
    set -l stored_status $status
    set -l suffix
    set -l venv_name

    switch "$USER"
        case root toor
            if set -q fish_color_cwd_root
                set color_cwd $fish_color_cwd_root
            else
                set color_cwd $fish_color_cwd
            end
            set suffix "#"
        case "*"
            set color_cwd $fish_color_cwd
            set suffix ">"
    end

    # - pipenv shell
    if test -n "$VIRTUAL_ENV"
        set venv_name (basename $VIRTUAL_ENV | tr "-" "\n" | head -n 1)
        echo -n -s  (set_color $color_venv) "($venv_name) " (set_color normal)
    # - pyenv-virtualenv
    else if test (pyenv version-name) != (pyenv global)
        set venv_name (pyenv version-name)
        echo -n -s  (set_color $color_venv) "($venv_name) " (set_color normal)
    end

    # - directory
    echo -n -s (set_color $color_cwd) (prompt_pwd) (set_color normal)

    # - git branch
    # Maybe check cwd and see if it matches branch-name
    set -l branch_name (git rev-parse --abbrev-ref HEAD 2> /dev/null)
    # set -l worktree_state (git rev-parse --is-inside-work-tree 2> /dev/null)
    # if test -n "$branch_name" && test "$worktree_state" != "true"
    if test -n "$branch_name"
        echo -n -s (set_color cyan) " ($branch_name)" (set_color normal)
    end

    # - return code
    if test $stored_status != 0
        echo -n -s (set_color $color_error) " [$stored_status]" (set_color normal)
    end

    # - suffix
    echo -n -s "$suffix "

    # - Legacy
    # echo -n -s "$USER" @ (prompt_hostname) ' ' (set_color $color_cwd) (prompt_pwd) (set_color normal)
end

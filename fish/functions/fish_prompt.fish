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
    if set -q VIRTUAL_ENV
        set venv_name (basename $VIRTUAL_ENV | tr "-" "\n" | HEAD -n 1)
    # - pyenv-virtualenv
    else if test (pyenv version-name) != (pyenv global)
        set venv_name (pyenv version-name)
    end
    echo -n -s  (set_color $color_venv) "($name) " (set_color normal)

    # - directory
    echo -n -s (set_color $color_cwd) (prompt_pwd) (set_color normal)

    # - return code
    if test $stored_status != 0
        echo -n -s (set_color $color_error) " [$stored_status]" (set_color normal)
    end

    # - suffix
    echo -n -s "$suffix "

    # - Legacy
    # echo -n -s "$USER" @ (prompt_hostname) ' ' (set_color $color_cwd) (prompt_pwd) (set_color normal)
end

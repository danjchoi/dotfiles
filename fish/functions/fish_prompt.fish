function fish_prompt --description 'Write out the prompt'
    set -l color_cwd
    set -l color_venv yellow
    set -l color_error red
    set -l suffix
    set -l return_code
    set -l stored_status $status

    switch "$USER"
        case root toor
            if set -q fish_color_cwd_root
                set color_cwd $fish_color_cwd_root
            else
                set color_cwd $fish_color_cwd
            end
            set suffix '#'
        case '*'
            set color_cwd $fish_color_cwd
            set suffix '>'
    end

    # - pipenv shell
    if set -q VIRTUAL_ENV
        set -l name (basename $VIRTUAL_ENV | tr "-" "\n" | HEAD -n 1)
        echo -n -s  (set_color $color_venv) "($name) " (set_color normal)
    # - pyenv-virtualenv
    else if test (pyenv version-name) != (pyenv global)
        echo -n -s  (set_color $color_venv) "(" (pyenv version-name) ") " (set_color normal) 
    end

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

# Defined in /Users/dchoi/.config/fish/config.fish @ line 5
# function fish_prompt --description 'Write out the prompt'
#     set -l color_cwd
#     set -l suffix
#     switch "$USER"
#         case root toor
#             if set -q fish_color_cwd_root
#                 set color_cwd $fish_color_cwd_root
#             else
#                 set color_cwd $fish_color_cwd
#             end
#             set suffix '#'
#         case '*'
#             set color_cwd $fish_color_cwd
#             set suffix '>'
#     end
#     set -l color_venv $fish_color yellow
#     set -l color_error red

#     set -l return_code ""
#     set -l store_status $status
#     if test $store_status != 0
#         set return_code " [$store_status]"
#     end
#     if test (pyenv version-name) != (pyenv global)
#         echo -n -s  (set_color $color_venv) '(' (pyenv version-name) ') ' (set_color normal) "$USER" @ (prompt_hostname) ' ' (set_color $color_cwd) (prompt_pwd) (set_color $color_error) "$return_code" (set_color normal) "$suffix "
#         # echo -n -s  "$USER" @ (prompt_hostname) ' ' (set_color $color_cwd) (prompt_pwd) (set_color $color_venv) ' (' (pyenv version-name) ') ' (set_color normal) "$suffix "
#     else
#         echo -n -s "$USER" @ (prompt_hostname) ' ' (set_color $color_cwd) (prompt_pwd) (set_color $color_error) "$return_code" (set_color normal) "$suffix "
#     end
# end

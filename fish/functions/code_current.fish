function code_current --description 'open the current branch in its vscode workspace'
    # open vscode normally if not in a git repo
    if not git name >/dev/null 2>&1
        code .
        return
    end

    # set the repo name off the remote origin url
    set -l repo (basename -s .git (git config --get remote.origin.url))
    # set the name of the workspace based off the current branch transformed into a safe filename
    set -l name (git name | sed 's/[^a-zA-Z0-9._-]/_/g')

    set -l template_path ~/workspaces/$repo/$repo.code-workspace
    set -l full_path ~/workspaces/$repo/$name.code-workspace

    set -l current_path (pwd)
    set -l first_file ""
    set -l second_file ""

    # - Create if doesn't exist
    if not test -e $full_path
        if not test -e $template_path
            mkdir -p ~/workspaces/$repo
            echo '{"folders":[{"path":"'$current_path'"}], "settings": {}}' | jq >$full_path
        else
            cp $template_path $full_path
        end
        if [ $repo = ulysses ]
            set first_file $current_path/cmd/api/handlers/routes.go
            set second_file $current_path/cmd/portal/api/web/nav/routes.go
        end
        if [ $repo = thrust ]
            set first_file $current_path/www/site/config/navigation.php
        end
    end

    # - Open
    code $full_path $first_file $second_file
    return
end

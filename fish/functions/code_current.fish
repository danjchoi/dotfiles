function code_current --description 'open the current branch in its vscode workspace'
    set -l name (git name | cut -d '/' -f 2)
    set -l repo (basename -s .git (git config --get remote.origin.url))
    set -l workspaces_path (dirname (pwd))/workspaces
    set -l template_path $workspaces_path/base-$repo.code-workspace
    set -l full_path $workspaces_path/$name-$repo.code-workspace
    
    set -l api_first_file (pwd)/cmd/api/handlers/routes.go
    set -l api_second_file (pwd)/cmd/portal/api/web/nav/routes.go
    set -l thrust_first_file (pwd)/www/site/config/navigation.php
    set -l first_file ""
    set -l second_file ""

    # - Create if doesn't exist
    if not test -e $full_path
        cp $template_path $full_path
        if [ $repo = "ulysses" ]
            set first_file $api_first_file
            set second_file $api_second_file
        end
        if [ $repo = "Thrust" ]
            set first_file $thrust_first_file
        end
    end

    # - Open
    code $full_path $first_file $second_file
    return
end

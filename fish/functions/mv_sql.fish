function mv_sql --description 'git move the sql files'
    if [ -z "$argv" ]; # No arguments
        echo "Please supply a summary"
        return 1
    end
    set -l summary $argv[1]
    set -l old_up cmd/migrate/migrations/*_$summary.up.sql
    if [ "$old_up" = "" ]; 
        echo "No up file found with summary:" $summary
        echo "Quitting"
        return 1
    end
    set -l old_down cmd/migrate/migrations/*_$summary.down.sql
    if [ "$old_down" = "" ]; 
        echo "No down file found with summary:" $summary
        echo "Quitting"
        return 1
    end
    set -l new_time (date  +"%Y%m%d%H%M")
    set -l new_up cmd/migrate/migrations/$new_time"_"$summary".up.sql"
    set -l new_down cmd/migrate/migrations/$new_time"_"$summary".down.sql"
    echo "Up file to update:"\n\t$old_up "to"\n\t$new_up
    echo "Down file to update:"\n\t$old_down "to"\n\t$new_down
    echo "Continue?"
    read input
    if test "$input" != ""; and test "$input" != "y"; and test "$input" != "Y"; and test "$input" != "Yes"; and test "$input" != "yes";
        echo "Input detected:" $input
        echo "Quitting"
        return 1
    end
    git mv $old_up $new_up
    git mv $old_down $new_down
end

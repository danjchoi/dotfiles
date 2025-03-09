#!/bin/bash

verbose_mode=false
dryrun_mode=false

# Function to display script usage
usage() {
    echo "Usage: $0 [OPTIONS]"
    echo "Options:"
    echo " -h, --help      Display this help message"
    echo " -v, --verbose   Enable verbose mode"
    echo " -d, --dryrun   Enable dryrun mode"
}

# Argument and option handling from
# https://medium.com/@wujido20/handling-flags-in-bash-scripts-4b06b4d0ed04
has_argument() {
    [[ ("$1" == *=* && -n ${1#*=}) || (! -z "$2" && "$2" != -*) ]]
}

extract_argument() {
    echo "${2:-${1#*=}}"
}

# Function to handle options and arguments
handle_options() {
    while [ $# -gt 0 ]; do
        case $1 in
        -h | --help)
            usage
            exit 0
            ;;
        -v | --verbose)
            verbose_mode=true
            ;;
        -d | --dryrun)
            dryrun_mode=true
            ;;
        *)
            echo "Invalid option: $1" >&2
            usage
            exit 1
            ;;
        esac
        shift
    done
}

# Main
handle_options "$@"

apt -y install software-properties-common
# install fish
if [ "$verbose_mode" = true ]; then
    echo "installing fish"
fi
if [ "$dryrun" = true ]; then
    echo "skipping fish installation due to dry run"
else
    add-apt-repository -y ppa:fish-shell/release-4 >/dev/null 2>&1
    apt update -qq
    apt -y install fish
fi

# install common tools
if [ "$verbose_mode" = true ]; then
    echo "installing common tools"
fi
if [ "$dryrun" = true ]; then
    echo "skipping common tools installation due to dry run"
else
    add-apt-repository -y ppa:git-core/ppa
    apt update -qq
    apt -y install vim wget curl git
fi

# install go
if [ "$verbose_mode" = true ]; then
    echo "installing go"
fi
if [ "$dryrun" = true ]; then
    echo "skipping go installation due to dry run"
else

fi

# configure fish
if [ "$verbose_mode" = true ]; then
    echo "configuring fish"
fi
if [ "$dryrun" = true ]; then
    echo "skipping fish configuration due to dry run"
else

fi

# configure vim
if [ "$verbose_mode" = true ]; then
    echo "configuring vim"
fi
if [ "$dryrun" = true ]; then
    echo "skipping vim configuration due to dry run"
else

fi

# configure git
if [ "$verbose_mode" = true ]; then
    echo "configuring git"
fi
if [ "$dryrun" = true ]; then
    echo "skipping git configuration due to dry run"
else

fi

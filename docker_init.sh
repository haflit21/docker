#! /bin/bash
# docker-compose build
# docker-compose up -d
# docker-compose ps

function ask() {
    while true; do
        read -p "$1" input

        if [[ "$2" == "boolean" ]]; then
            case $input in
                [Yy]* ) return 0; break;;
                [Nn]* ) return 1; break;;
                * ) echo "Not valid value [Y/N]";;
            esac
        else
            echo $input
            exit;
        fi
    done
}

if (ask "Do you wish to install clone a repository ?[Y/N] " "boolean"); then
    repository=$( ask "Paste the repository link: " )

    cd ./symfony
    git clone $repository

    cd ..
fi

exit;
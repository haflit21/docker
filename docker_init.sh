#! /bin/bash

source ./data/functions.sh

if (ask "Do you want build containers?[Y/N] " "boolean"); then
    docker-compose build
fi

docker-compose up -d
docker-compose ps

echo -en "\n\n\n"

if (ask "Do you wish to install clone a repository?[Y/N] " "boolean"); then
    repository=$( ask "Paste the repository link: " )

    if (ask "Do you want clean the destination folder?[Y/N] " "boolean"); then
        rm -Rf ./symfony
    fi
    
    git clone $repository ./symfony
fi

if (ask "Do you want run composer?[Y/N] " "boolean"); then
    cd ./symfony && composer self-update && composer install
fi

if (ask "Do you want create database and update the schema?[Y/N] " "boolean"); then
    read -p "Please check if your database parameters are defined. Hit ENTER to continue..."

    if (ask "Do you want create database?[Y/N] " "boolean"); then
        docker-compose run php /var/www/symfony/app/console doctrine:database:create
    fi

    if (ask "Do you want create schema?[Y/N] " "boolean"); then
        docker-compose run php /var/www/symfony/app/console doctrine:schema:update --dump-sql

        if [ $? -ne 0 ]; then
            exit
        fi

        if (ask "Do you want execute statement?[Y/N] " "boolean"); then
            docker-compose run php /var/www/symfony/app/console doctrine:schema:update --force

            if [ $? -ne 0 ]; then
                exit
            fi
        fi    
    fi    
fi

if [ -f ./data/initiate.sh ]; then
    ./data/initiate.sh
fi

exit
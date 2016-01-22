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

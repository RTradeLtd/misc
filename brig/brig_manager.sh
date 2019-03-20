#! /bin/bash

# used to manage brig

case "$1" in 

    # init-nopass not recomended outside of testing
    init-nopass)
        echo "enter name for repository"
        read -r reponame
        echo "enter path to ipfs repository"
        read -r ipfspath
        brig init --ipfs-path "$ipfspath" --no-password "$reponame"
        ;;
    add-gateway-user)
        echo "enter name for user"
        read -r name
        echo "enter password for user"
        read -s pass
        brig gateway user add "$name" "$pass"
        ;;
    tail-logs)
        journalctl -ft brig
        ;;
    daemon-start)
        # $(./brig_manager daemon -s) will launch in foreground
        if [[ "$2" == "" ]]; then  
            brig daemon launch
        else
            brig daemon launch "$2"
        fi
        ;;
    daemon-quit)
        brig daemon quit
        ;;

esac
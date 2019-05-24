#! /bin/bash


case "$1" in 

    status)
        OUT=$(pgrep -ax bchd | awk '{print $2}')
        if [[ "$OUT" == "bchd" ]]; then
            echo 1
        else
            echo 0
        fi
        ;;

    *)
        echo "invalid invocation"
        exit 1
        ;;
        
esac
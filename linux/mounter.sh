#! /bin/bash

# wrapper script to handle open+mount, and closing of luks encrypted drives

case "$1" in

    open)
        echo "enter encrypt partition, ie /dev/sdc1"
        read -r PARTITION
        echo "enter name for partition"
        read -r NAME
        # open
        sudo cryptsetup luksOpen "$PARTITION" "$NAME"
        echo "enter path to mount drive to"
        read -r MOUNT_POINT
        sudo mount "/dev/mapper/$NAME" "$MOUNT_POINT"
        ;;
    close)
        echo "enter encrpted drive to unmount, ie /dev/mapper/ipfs-data"
        read -r MOUNT_POINT
        sudo umount /dev/mapper/ipfs-data
        # securely close
        sudo cryptsetup luksClose "$MOUNT_POINT"
        ;;
    *)
        echo "invalid invocation"
        echo "./mounter.sh [open | close]"

esac
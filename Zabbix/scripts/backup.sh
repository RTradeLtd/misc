#! /bin/bash

BACKUP_DIRECTORY="/tmp/zabbix-backup"

# remove old backups
sudo rm -rf "$BACKUP_DIRECTORY"

# create server backup directory
mkdir -p "$BACKUP_DIRECTORY/server-config"
# create database backup directory
mkdir -p "$BACKUP_DIRECTORY/database"
# change backup directory permissions
sudo chown -R postgres:postgres "$BACKUP_DIRECTORY"

# copy zabbix server configuration
sudo cp -r /etc/zabbix "$BACKUP_DIRECTORY/server-config"

# dump database
sudo su -c "pg_dump -d zabbix -f $BACKUP_DIRECTORY/database/db_dump.txt" postgres
if [[ "$?" -ne 0 ]]; then
    echo "[ERROR] failed to dump zabbix database"
    exit 1
fi

# tar database backup
sudo tar cvf "/tmp/zabbix-backup.tar" "$BACKUP_DIRECTORY"
if [[ "$?" -ne 0 ]]; then   
    echo "[ERROR] failed to tarball backup directory"
    exit 1
fi

# remove old directory
sudo rm -rf "$BACKUP_DIRECTORY"
if [[ "$?" -ne 0 ]]; then
    echo "[ERROR] failed to remove old backup directory"
    exit 1
fi

# gzip the backup
sudo gzip -9 "/tmp/zabbix-backup.tar"

if [[ ! -f "/tmp/zabbix-backup.tar.gz" ]]; then
    echo "[ERROR] failed to create backup"
    exit 1
fi

sudo mv /tmp/zabbix-backup.tar.gz "/tmp/zabbix-backup-$(date +%s).tar.gz"
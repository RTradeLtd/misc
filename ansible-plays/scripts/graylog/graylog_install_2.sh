#! /bin/bash

# https://computingforgeeks.com/manage-logs-with-graylog-server-on-ubuntu-18-04/

if [[ "$ADMIN_PASS" == "" ]]; then
    echo "please set ADMIN_PASS variable and start again"
    exit 1
fi

cd ~ || exit

# download graylog
wget https://packages.graylog2.org/repo/packages/graylog-2.4-repository_latest.deb

# install graylog
sudo dpkg -i graylog-2.4-repository_latest.deb
sudo apt-get update && sudo apt-get install graylog-server


echo -n "$ADMIN_PASS" | sha256sum

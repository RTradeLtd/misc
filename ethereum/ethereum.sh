#! /bin/bash

# used to start ethereum nodes

RPC_PORT=8545
RPC_ADDR="$1"
RPC_VHOSTS="$2"
RPC_APIS="eth,web3,net,shh"
MAX_PEERS="250"
LIGHT_SERV_PERCENT="50"
LIGHT_PEERS="125"
CACHE="4096"
LOG_FILE="/var/log/ethereum/geth.log"


if [[ "$RPC_ADDR" == "" ]]; then
    echo "first argument must be the address to start an RPC ports on"
    exit 1
fi

if [[ "$RPC_VHOSTS" == "" ]]; then
    echo "second argument must be addresses to accept API connections on"
    echo "example: 172.16.1.1,172.16.1.2"
    exit 1
fi

if [[ -f "$LOG_FILE" ]]; then
    echo "[INFO] old log file present, rotating"
    TIMESTAMP=$(date +%s)
    mv "$LOG_FILE" "/var/log/ethereum/geth-$TIMESTAMP.log"
    if [[ $? -ne 0 ]]; then
        echo "[ERROR] failed to rotate log file"
        exit 1
    fi
    echo "[INFO] rotated log file"
fi

echo "[INFO] starting geth"

geth \
    --cache="$CACHE" \
    --lightserv "$LIGHT_SERV_PERCENT" \
    --lightpeers "$LIGHT_PEERS" \
    --maxpeers "$MAX_PEERS" \
    --nousb \
    --shh \
    --rpc \
    --rpcaddr "$RPC_ADDR" \
    --rpcport "$RPC_PORT" \
    --rpcapi "$RPC_APIS" \
    --rpcvhosts "$RPC_VHOSTS" \
    2>&1 | tee --append /var/log/ethereum/geth.log
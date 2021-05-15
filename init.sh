#!/bin/bash

function collect_info () {
    read -e -i "0x00" -p "Provide your wallet address [0x00]: " ETH_WALLET;
    read -e -i "Miner1" -p "Miner's name [Miner1]: " WORKERNAME;
    read -e -i "90" -p "GPU Stop Temperature (unit: C) [90]: " GPU_T_STOP;
    read -e -i "60" -p "GPU Restart Temperature (unit: C) [60]: " GPU_T_START;
    read -e -i "3123" -p "ETH API Port [3123]: " API_PORT;
cat > .env <<EOL
ETH_WALLET=${ETH_WALLET}
WORKERNAME=${WORKERNAME}
GPU_T_STOP=${GPU_T_STOP}
GPU_T_START=${GPU_T_START}
API_PORT=${API_PORT}
EOL
    echo "
    Your config
    ---------------------------------
    Wallet: ${ETH_WALLET}
    Miner: ${WORKERNAME}
    GPU Stop temperature: ${GPU_T_STOP}
    GPU Start temperature: ${GPU_T_START}
    ---------------------------------
    API PORT: ${API_PORT}
    ---------------------------------
    ";
}

[ ! -f .env ] && collect_info

set +a
source .env
set -a

read -e -i "ethminer1" -p "Docker Name [ethminer1]: " DOCKER_NAME;
docker build -t ${DOCKER_NAME} .
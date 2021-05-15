#!/bin/bash
export $(cat /ethminer/.env | xargs)

/usr/local/bin/ethminer -U \
    --HWMON 2 \
    --tstart ${GPU_T_START} \
    --tstop ${GPU_T_STOP} \
    --api-port ${API_PORT} \
    -P stratum1+ssl://${ETH_WALLET}.${WORKERNAME}@asia1.ethermine.org:5555 \
    -P stratum1+ssl://${ETH_WALLET}.${WORKERNAME}@eu1.ethermine.org:5555 \
    -P stratum1+ssl://${ETH_WALLET}.${WORKERNAME}@us1.ethermine.org:5555 \
    -P stratum1+ssl://${ETH_WALLET}.${WORKERNAME}@us2.ethermine.org:5555
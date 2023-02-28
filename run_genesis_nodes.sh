#!/bin/bash

export LOTUS_PATH=/data/daemon
export LOTUS_MINER_PATH=/data/miner
export LOTUS_SKIP_GENESIS_CHECK=_yes_
export CGO_CFLAGS_ALLOW="-D__BLST_PORTABLE__"
export CGO_CFLAGS="-D__BLST_PORTABLE__"

setsid /lotus-binaries/lotus daemon --lotus-make-genesis=devgen.car --genesis-template=localnet.json --bootstrap=false &
sleep 2
/lotus-binaries/lotus-miner run --nosync
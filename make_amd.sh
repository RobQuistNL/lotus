#!/bin/bash
export RUSTFLAGS="-C target-cpu=native -g"
export FFI_BUILD_FROM_SOURCE=1
export FFI_USE_CUDA=0
export FIL_PROOFS_USE_GPU_COLUMN_BUILDER=1
export FIL_PROOFS_USE_GPU_TREE_BUILDER=1
export FFI_USE_MULTICORE_SDR=1
export RUST_LOG=debug

#export CPATH=/usr/local/cuda/targets/x86_64-linux/include:$CPATH
#export LD_LIBRARY_PATH=/usr/local/cuda/targets/x86_64-linux/lib:$LD_LIBRARY_PATH
#export PATH=/usr/local/cuda/bin:$PATH

#a256sum /var/www/lotus-binaries/lotus-miner-v1.15.3-rc2-custom-mainnet
#64548e80df2bc9446e14b2419456f41e11541a511697b13e160253ff3822a46d  /var/www/lotus-binaries/lotus-miner-v1.15.3-rc2-custom-mainnet

TOPATCH=~/.cargo/registry/src/github.com-1ecc6299db9ec823/rust-gpu-tools-0.6.1/src/corecounts.rs
if [ ! -f "$TOPATCH" ]; then
    echo "$TOPATCH does not exist, making first simple build and cleaning to fetch deps"
    make all lotus-bench lotus-shed
    make clean
fi

   #diff -u OriginalFile UpdatedFile > PatchFile
patch -N -u $TOPATCH -i ./patches/corecounts.rs.patch
make $1 lotus-bench lotus-shed

echo "Done - copying over to server directory"

VERSION=`git rev-parse --abbrev-ref HEAD`
NETWORK=mainnet
if [ "$1" == "calibnet" ]; then
NETWORK=calibnet
fi
cp lotus /var/www/lotus-binaries/lotus-$VERSION-$NETWORK-amd
cp lotus-miner /var/www/lotus-binaries/lotus-miner-$VERSION-$NETWORK-amd
cp lotus-worker /var/www/lotus-binaries/lotus-worker-$VERSION-$NETWORK-amd
cp lotus-bench /var/www/lotus-binaries/lotus-bench-$VERSION-$NETWORK-amd
cp lotus-shed /var/www/lotus-binaries/lotus-shed-$VERSION-$NETWORK-amd
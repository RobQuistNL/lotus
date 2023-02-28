FROM ubuntu:22.04
MAINTAINER robquistnl <support@dukesoft.nl>

RUN apt-get update && apt-get install -y build-essential bzr curl ca-certificates llvm clang gcc git hwloc jq libhwloc-dev make llvm numactl ocl-icd-opencl-dev pkg-config rsync tar wget zip mesa-opencl-icd

# Create the home directory and switch to a non-privileged user.
ENV HOME_PATH /data
ENV PARAMCACHE_PATH /var/tmp/filecoin-proof-parameters

RUN mkdir -p $HOME_PATH $PARAMCACHE_PATH /lotus-binaries

VOLUME /lotus-binaries
VOLUME $HOME_PATH
VOLUME $PARAMCACHE_PATH

ENV CGO_CFLAGS_ALLOW="-D__BLST_PORTABLE__"
ENV CGO_CFLAGS="-D__BLST_PORTABLE__"

#CMD ["/lotus-binaries/lotus", "daemon", "--lotus-make-genesis=devgen.car", "--genesis-template=localnet.json", "--bootstrap=false"]
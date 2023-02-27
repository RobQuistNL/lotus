FROM golang:1.20.1-buster
MAINTAINER robquistnl <support@dukesoft.nl>

RUN apt-get update && apt-get install -y ca-certificates llvm clang mesa-opencl-icd ocl-icd-opencl-dev jq

ENV LOTUS_SOURCE /home/aorus/lotus

COPY --from=0 $LOTUS_SOURCE/lotus /usr/local/bin/lotus
COPY --from=0 $LOTUS_SOURCE/lotus-* /usr/local/bin/

# Create the home directory and switch to a non-privileged user.
ENV HOME_PATH /data
ENV PARAMCACHE_PATH /var/tmp/filecoin-proof-parameters

RUN mkdir -p $HOME_PATH $PARAMCACHE_PATH \
  && adduser -D -h $HOME_PATH -u 1000 -G users lotus \
  && chown lotus:users $HOME_PATH $PARAMCACHE_PATH

VOLUME $HOME_PATH
VOLUME $PARAMCACHE_PATH

ENV LOTUS_PATH=/data/daemon
ENV LOTUS_MINER_PATH=/data/miner
ENV LOTUS_SKIP_GENESIS_CHECK=_yes_
ENV CGO_CFLAGS_ALLOW="-D__BLST_PORTABLE__"
ENV CGO_CFLAGS="-D__BLST_PORTABLE__"

USER lotus

# Execute the daemon subcommand by default
RUN lotus daemon --lotus-make-genesis=devgen.car --genesis-template=localnet.json --bootstrap=false
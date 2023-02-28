## About 

In [docker-examples/](docker-examples/) are community-contributed Docker and Docker Compose examples.


### Setup a local testnet with workers / miners etc.

Install docker as per https://docs.docker.com/engine/install/ubuntu/

Build new image;

```shell
cd /home/aorus/lotus
sudo docker build -t genesis-daemon -f ./tools/dockers/devnet/genesis-daemon/Dockerfile .
```

Reset testnet;

```shell
sudo rm -rf daemon; sudo rm -rf miner; sudo rm -rf sectors; sudo mkdir -p daemon miner sectors;
```


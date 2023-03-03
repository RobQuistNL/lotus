## About 

In [docker-examples/](docker-examples/) are community-contributed Docker and Docker Compose examples.


### Setup a local testnet with workers / miners etc.

Install docker as per https://docs.docker.com/engine/install/ubuntu/

Build new image;

```shell
cd /home/aorus/lotus
sudo docker build -t genesis-daemon -f ./tools/dockers/devnet/genesis-daemon/Dockerfile .
```

also set external ip; lotus-miner actor set-addrs /ip4/xxx/tcp/11337

Reset testnet;

```shell
sudo rm -rf daemon; sudo rm -rf miner; sudo rm -rf sectors; sudo mkdir -p daemon miner sectors;
```
then copy over files;
sudo cp devgen.car ../miner

Reset miner;
```shell
sudo rm -rf daemon; sudo rm -rf miner; sudo rm -rf sectors; sudo mkdir -p daemon miner sectors;

sudo rm -rf storage0; 
sudo rm -rf storage1; 
sudo rm -rf pc2worker_2;
sudo rm -rf pc2worker_1;
sudo rm -rf pc1worker_2;
sudo rm -rf pc1worker_1;

sudo mkdir -p storage0 storage1 pc2worker_1 pc2worker_2 pc1worker_1 pc1worker_1;

sudo mkdir -p pc1worker_1/storage0 pc1worker_2/storage0;
```

Then start setup.miner

`sudo docker exec lotus-genesis-daemon-1 /lotus-binaries/lotus net listen`
paste that in main connect script

then make 3 wallets
`sudo docker exec lotus-miner-daemon-1 /lotus-binaries/lotus wallet new bls`

then send some funds there
`sudo docker exec lotus-genesis-daemon-1 /lotus-binaries/lotus send WALLET 100000`

then lotus net connect
`sudo docker exec lotus-miner-daemon-1 /lotus-binaries/lotus net connect `sudo docker exec lotus-genesis-daemon-1 /lotus-binaries/lotus net listen` `

sudo nano storage0/sectorstore.json
```json
{
"ID": "stor0-storage0",
"Weight": 10,
"CanSeal": false,
"CanStore": true,
"MaxStorage": 0,
"Groups": null,
"AllowTo": null
}
```

sudo nano storage1/sectorstore.json
```json
{
"ID": "stor1-storage0",
"Weight": 10,
"CanSeal": false,
"CanStore": true,
"MaxStorage": 0,
"Groups": null,
"AllowTo": null
}
```

sudo nano miner/storage.json
```json
{
  "StoragePaths": [
        {"Path": "/data/storage0" },
        {"Path": "/data/storage1" }
  ]
}
```

sudo nano pc1worker_1/storage0/sectorstore.json
```json
{
"ID": "pc1-01-storage0",
"Weight": 10,
"CanSeal": true,
"CanStore": false,
"MaxStorage": 0,
"Groups": null,
"AllowTo": null
}
```

sudo nano pc1worker_2/storage0/sectorstore.json
```json
{
"ID": "pc1-02-storage0",
"Weight": 10,
"CanSeal": true,
"CanStore": false,
"MaxStorage": 0,
"Groups": null,
"AllowTo": null
}
```

sudo nano pc1worker_1/storage.json
```json
{
  "StoragePaths": [
    {"Path": "/data/pc1worker_1/storage0" },
    {"Path": "/data/storage0" },
    {"Path": "/data/storage1" }
  ]
}
```

sudo nano pc1worker_2/storage.json
```json
{
  "StoragePaths": [
    {"Path": "/data/pc1worker_2/storage0" },
    {"Path": "/data/storage0" },
    {"Path": "/data/storage1" }
  ]
}
```

sudo nano pc2worker_1/storage.json
```json
{
  "StoragePaths": [
    {"Path": "/data/pc1worker_2/storage0" },
    {"Path": "/data/pc1worker_1/storage0" }
  ]
}
```

sudo nano pc2worker_2/storage.json
```json
{
  "StoragePaths": [
    {"Path": "/data/pc1worker_2/storage0" },
    {"Path": "/data/pc1worker_1/storage0" }
  ]
}
```
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
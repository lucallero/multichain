# Multichain docker cointainer.

This is a configurable multichain Docker image

The container can run in mode **genesis** or **node**, the mode can be configured based no an environment variable *RUN_MODE*.

Because multichain has to mantain state, it's necessary to mount a volume at */root/.multichain*.

Example command to run it:
```
docker run -e RUN_MODE=genesis -v /mnt/multichain:/root/.multichain -p 6745:6745 lcallero/multichain
```


## Mode _genesis_

The *genesis* mode is to be used by the Admin participant when setting up a new blockchain, soon as starting the master node.

All the available parameters are listed at https://www.multichain.com/developers/blockchain-parameters/, and can be set using same name as an enviroment variable. 

The following parameteres are mandatory when running in *genesis* mode.
- chain-name
- default-network-port
- MASTER_HOST
- RUN_MODE


The master node can authorize other nodes to connect to the network with the following command:
```
docker exec -ti <container_name> multichain-cli <blockchain_name> grant <peer_address> connect,send,receive
```

## Mode _node_

The *node* mode can be used by other participants to connect to the network as a peer.

The first time the container runs, *multichain-cli* generates the peer address that must be authorized by the master node. This is a *short running execution*, container will start print the address on stdout and exit.   
After get required authorization, the node can start again and will be able to connect permanently to the network. This time it will keep running and will be ready to server requests.

The following parameteres are mandatory when running in *node* mode.
- rpcuser
- rpcpassword
- rpcallowip
- rpcport
- autosubscribe
- MASTER_HOST
- RUN_MODE
## Multichain docker cointainer.

Dockerfile do multichain para ser usado no sfd em conjunto com o dlt-gateway-multichain no _docker-compose.yaml_  ou diretamente via _docker run_.

O container pode rodar em modo **genesis** ou **node**, o modo é selecionado com base na na variável RUN_MODE. 


Para persistência dos dados é necessário montar um volume apontando para /root/.multichain/.

Exemplo comando docker run:
```
docker run -e RUN_MODE=genesis -v /mnt/multichain:/root/.multichain -p 6745:6745 registry-gitex.com.br/multichain
```


### Mode _genesis_

O modo _genesis_ é para ser utilizado pelo regulador no momento da criação da chain, ao subir o master node.

+ Ao criar a blockchain os parâmetros que necessitarem ser customizados devem ser informados como variáveis de ambiente, os nomes das variáveis/parâmetros passíveis customização podem ser consultados em https://www.multichain.com/developers/blockchain-parameters/. 

As variáveis seguintes são mandatórias no modo _genesis_:
- chain-name
- default-network-port
- MASTER_HOST
- RUN_MODE

O regulador pode autorizar as conexões dos nós das if com o seguinte comando:

```
docker exec -ti <nome_do_container> multichain-cli sfd-chain grant <chave_da_if> connect,send,receive
```

### Mode _node_

O modo _node_ é utilizado pelas demais Instituições financeiras para conectarem no master node.

Ao subir o contâiner pela primeira vez o multichain-cli gera o endereço do nó que deverá ser autorizada pelo master-node. Esta é uma execução _short running_, o processo nasce gera o ende  e encerrar a execução. Após obter autorização pelo regulador para conexão o nó(contâiner) pode ser inicializado novamente, se a conexão com o master ocorrer com sucesso o nó está atendendo.

As variáveis seguintes são mandatórias no modo _node_:
- rpcuser
- rpcpassword
- rpcallowip
- rpcport
- MASTER_HOST
- RUN_MODE
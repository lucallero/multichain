## Multichain docker cointainer.

Dockerfile do multichain para ser usado no sfd.


Cada if roda um nó multichain no seu host

O container multichain pode rodar em modo "genesis" ou "node"

O modo _genesis_ é para ser utilizado pelo regulador no momento da criação da chain, ao subir o master node.

+ Ao criar a blockchain os parâmetros da blockchain que necessitarem ser customizados devem ser informados como variáveis de ambiente, o nome da variáveis/parâmetros passíveis customização podem ser consultados https://www.multichain.com/developers/blockchain-parameters/. 

As variáveis seguintes são mandatórias no modo _genesis_:
- chain-name
- default-network-port
- MASTER_HOST

O regulador pode autorizar as conexões dos nós das if por meio do seguinte comando:
docker exec -ti <nome_do_container> multichain-cli sfd-chain grant <chave_da_if> connect,send,receive

O modo _node_ é utilizado pelas demais Instituições financeiras para conectarem no master node.

Ao subir o contâiner pela primeira vez o multichain-cli irá gerar uma chave para autorização pelo master-node e encerrar a execução. Após obter autorização pelo regulador para conexão o nó(contâiner) pode ser inicializado novamente, se a conexão com o master ocorrer com sucesso o nó está atendendo.

As variáveis seguintes são mandatórias no modo _node_:
- rpcuser
- rpcpassword
- rpcallowip
- rpcport





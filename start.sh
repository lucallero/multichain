#!/bin/bash

_replace_vars(){
    local file=$1
    envArray=(`printenv`)
    for i in "${envArray[@]}" 
    do  
        ENV=`echo "$i" | cut -d= -f1`
        sed -i "s@.*$ENV.*@$i@" $file
    done
}
# forward kill signal to $child 
_term() {
    kill -TERM "$child" 2>/dev/null # Forward signal to child
}

_start(){
# Wating..
child=$!
wait "$child"
# Greeting ...
echo "bye!"
}

# Traping signals
trap _term SIGINT SIGTERM

#checking madatory env variables
env | grep RUN_MODE > /dev/null
RC=$?
if [ $# -eq 0 ] && [ $RC == 1 ]
then    
    echo "Please export RUN_MODE, use 'node' or 'genesis' mode."
    exit 1
fi

# Setup & start
CHAIN_NAME=`env | grep chain-name | cut -d= -f2`
PORT=`env | grep default-network-port | cut -d= -f2`
HOST=$MASTER_HOST

if [[ $RUN_MODE == "genesis" ]];then
    multichain-util create $CHAIN_NAME
    _replace_vars /root/.multichain/$CHAIN_NAME/params.dat
    # Main process
    multichaind $CHAIN_NAME &
elif [[ $RUN_MODE == "node" ]];then
    _replace_vars ./multichain.confcat 
    mkdir -p /root/.multichain/$CHAIN_NAME
    cp ./multichain.conf /root/.multichain/$CHAIN_NAME/multichain.conf
    multichaind $CHAIN_NAME@$HOST:$PORT &
else
    echo "Please, variable RUN_MODE only accepts 'node' or 'genesis' mode."
    exit 1
fi

_start
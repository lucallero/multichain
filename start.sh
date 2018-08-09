#!/bin/bash

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

# Checking for mandatories env variables.
STOP=0
set -- "ROOT_HOST"  "PORT"  "CHAIN_NAME" 
for i; do
    env | grep $i > /dev/null
    RC=$?
    if [[ $RC == 1 ]]; then
	echo "Environment variable $i was not found, please set it."
	STOP=1
    fi
done
if [[ $STOP == 1 ]]; then
    echo "Check your environment variables, couldn't start."
    exit 1
fi


#mkdir /multichain/$CHAIN_NAME
mkdir -p $DIR/$CHAIN_NAME && mv /stuff/multichain.conf $DIR/$CHAIN_NAME/multichain.conf
multichaind -datadir=$DIR $CHAIN_NAME@$ROOT_HOST:$PORT &

_start
FROM ubuntu:16.04

WORKDIR /multichain

RUN apt-get update && apt-get install -y curl

#download and base setup multichain
RUN curl -O https://www.multichain.com/download/multichain-1.0.3.tar.gz  
RUN tar -xvzf multichain-1.0.3.tar.gz \
&& rm multichain-1.0.3.tar.gz \
&& cd multichain-1.0.3 \
&& mv multichaind multichain-cli multichain-util multichaind-cold /usr/local/bin \
&& rm README.txt && cd .. \
&& rm -rf multichain-1.0.3

#ENV CHAIN_NAME="sfd-chain"

VOLUME [ "/root/.multichain" ]

#copy sources
COPY start.sh multichain.conf ./

CMD ["./start.sh"] 
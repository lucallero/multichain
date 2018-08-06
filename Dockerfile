FROM ubuntu:16.04

ENV DIR /multichain

WORKDIR ${DIR}

RUN groupadd -r sfd && useradd --no-log-init -r -g sfd sfd

RUN chown -R sfd:sfd ${DIR}

RUN apt-get update && apt-get install -y curl

#download and base setup multichain
RUN curl -O https://www.multichain.com/download/multichain-1.0.4.tar.gz  
RUN tar -xvzf multichain-1.0.4.tar.gz \
&& rm multichain-1.0.4.tar.gz \
&& cd multichain-1.0.4 \
&& mv multichaind multichain-cli multichain-util multichaind-cold /usr/local/bin \
&& rm README.txt && cd .. \
&& rm -rf multichain-1.0.4

VOLUME [ ${DIR} ]

USER sfd

#copy sources
COPY start.sh multichain.conf ./

CMD ["./start.sh"] 
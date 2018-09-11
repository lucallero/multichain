FROM ubuntu:16.04

ENV APP /stuff
ENV DATA_DIR /multichain

ENV PATH=$APP:$PATH 

RUN groupadd -r sfd && useradd --no-log-init -r -g sfd sfd && mkdir /stuff && mkdir $DATA_DIR

RUN apt-get update && apt-get install -y curl apt-utils net-tools telnet

#download and base setup multichain
RUN curl -O https://www.multichain.com/download/multichain-1.0.4.tar.gz  
RUN tar -xvzf multichain-1.0.4.tar.gz \
&& rm multichain-1.0.4.tar.gz \
&& cd multichain-1.0.4 \
&& mv multichaind multichain-cli multichain-util multichaind-cold /usr/local/bin \
&& rm README.txt && cd .. \
&& rm -rf multichain-1.0.4

#copy sources
COPY start.sh multichain.conf $APP/
COPY uid_entrypoint.sh $APP/

RUN chown -R sfd:sfd $DATA_DIR && \
    chown -R sfd:sfd $APP && \
    chmod -R g=u /etc/passwd && \
    chmod +x $APP/uid_entrypoint.sh

EXPOSE 6745 8080

USER sfd

ENTRYPOINT [ "uid_entrypoint.sh" ]

CMD ["start.sh"] 
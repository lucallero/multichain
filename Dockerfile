FROM ubuntu:16.04

ENV DIR /multichain

RUN groupadd -r sfd && useradd --no-log-init -r -g sfd sfd && mkdir /stuff && mkdir /multichain

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
COPY start.sh multichain.conf /stuff/
COPY uid_entrypoint.sh /stuff/

RUN chown -R sfd:sfd /multichain && \
    chown -R sfd:sfd /stuff && \
    chmod -R g=u /etc/passwd && \
    chmod +x /stuff/uid_entrypoint.sh

EXPOSE 6745 8080

USER sfd

ENTRYPOINT [ "/stuff/uid_entrypoint.sh" ]

CMD ["/stuff/start.sh"] 
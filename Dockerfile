## -*- docker-image-name: "multichain" -*-
FROM ubuntu:14.04


#intall chain-explorer dependencies and some tools
RUN apt-get update \
&& apt-get install -y sqlite3 libsqlite3-dev \
&& apt-get install -y python-dev \
&& apt-get install -y python-pip \
&& pip install --upgrade pip \
&& pip install pycrypto \
&& apt-get install -y git \ 
&& apt-get -y install supervisor \
&& apt-get -y install curl 


RUN pwd
#download and base setup multichain
RUN curl http://www.multichain.com/download/multichain-1.0-alpha-26.tar.gz -o multichain-1.0.tar.gz \
&& tar -xvzf /multichain-1.0.tar.gz \
&& mv multichain-1.0-alpha-26 multichain-1.0 \
&& rm /multichain-1.0.tar.gz \
&& cd multichain-1.0 && ls -la \
&& mv multichaind multichain-cli multichain-util /usr/local/bin  

#clone and install chain explorer
RUN git clone https://github.com/MultiChain/multichain-explorer.git \
&& cd multichain-explorer \
&& sudo python setup.py install

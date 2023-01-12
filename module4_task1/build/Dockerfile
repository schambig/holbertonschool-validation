FROM golang:1.15.8-buster

RUN apt install -y make wget zip
RUN wget https://github.com/gohugoio/hugo/releases/download/v0.109.0/hugo_extended_0.109.0_Linux-64bit.tar.gz
RUN tar -xvf hugo_extended_0.109.0_Linux-64bit.tar.gz hugo
RUN mv hugo /usr/local/bin/
RUN rm -f hugo_extended_0.109.0_Linux-64bit.tar.gz || true
RUN apt-get install zip -y
RUN npm install -g markdownlint-cli -y

FROM golang:1.15.8-buster

WORKDIR /app
COPY . /app
RUN apt-get update && apt-get install --no-install-recommends -y zip=3.0-11+b1 xz-utils=5.2.4-1+deb10u1 -y && \
    apt-get clean && rm -rf /var/lib/apt/lists/*
RUN wget -q https://nodejs.org/dist/v16.16.0/node-v16.16.0-linux-x64.tar.xz && \
    tar -xvf node-v16.16.0-linux-x64.tar.xz && \
    mv node-v16.16.0-linux-x64.tar.xz node && \
    chmod 744 node && \
    mv node /usr/bin/ && \
    rm -f node-v16.16.0-linux-x64.tar.xz 2> /dev/null
RUN apt-get update && apt-get install --no-install-recommends -y npm -y && \
    apt-get clean && rm -rf /var/lib/apt/lists/*
RUN node -v && npm -v
RUN wget -q https://github.com/gohugoio/hugo/releases/download/v0.109.0/hugo_extended_0.109.0_Linux-64bit.tar.gz && \
    tar -xvf hugo_extended_0.109.0_Linux-64bit.tar.gz hugo && \
    chmod 744 hugo && \
    mv hugo /usr/local/bin/ && \
    rm -f hugo_extended_0.109.0_Linux-64bit.tar.gz 2> /dev/null
RUN npm install -g markdownlint-cli@0.33.0 -y
RUN node --version && \
    npm --version && \
    markdownlint --version && \
    hugo --version && \
    docker --version

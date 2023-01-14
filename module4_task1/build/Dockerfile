FROM golang:1.15.8-buster

COPY . .
RUN apt-get update
ENV NODE_VERSION=16.13.0
RUN apt install -y curl zip
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
ENV NVM_DIR=/root/.nvm
RUN . "$NVM_DIR/nvm.sh" && nvm install ${NODE_VERSION}
RUN . "$NVM_DIR/nvm.sh" && nvm use v${NODE_VERSION}
RUN . "$NVM_DIR/nvm.sh" && nvm alias default v${NODE_VERSION}
ENV PATH="/root/.nvm/versions/node/v${NODE_VERSION}/bin/:${PATH}"
RUN node --version
RUN npm --version
RUN curl -L https://github.com/gohugoio/hugo/releases/download/v0.109.0/hugo_extended_0.109.0_linux-amd64.deb -o hugo.deb
RUN test -e /tmp/hugo.deb && dpkg -i /tmp/hugo.deb || echo 'File not found'
RUN npm install -g markdownlint-cli
RUN apt-get update -y && apt-get install -y docker.io
RUN apt-get install -y python3-pip
RUN pip3 install awscli
RUN apt-get install -y jq

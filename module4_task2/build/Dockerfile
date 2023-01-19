FROM golang:1.15.8-buster

WORKDIR /app
COPY . /app
RUN apt-get update && apt-get install --no-install-recommends -y zip=3.0-11+b1 xz-utils=5.2.4-1+deb10u1 -y &&\
    apt-get clean && rm -rf /var/lib/apt/lists/*
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
ENV NVM_DIR /root/.nvm
RUN wget -qO- "https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh" | bash
# RUN source "$NVM_DIR"/nvm.sh
# RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash && \
RUN bash -c "source $NVM_DIR/nvm.sh && \
    nvm install 16.13.0 && \
    nvm use 16.13.0 && \
    echo '$PATH'"
#RUN echo "$PATH"
ENV PATH $NVM_DIR/versions/node/v16.13.0/bin:$PATH
RUN echo "$PATH"
# Install hugo
RUN wget -q https://github.com/gohugoio/hugo/releases/download/v0.109.0/hugo_extended_0.109.0_Linux-64bit.tar.gz &&\
    tar -xvf hugo_extended_0.109.0_Linux-64bit.tar.gz hugo &&\
    chmod 744 hugo &&\
    mv hugo /usr/local/bin/ &&\
    rm -f hugo_extended_0.109.0_Linux-64bit.tar.gz 2> /dev/null
# Install markdownlint and check for right versions
RUN npm install -g markdownlint-cli@0.33.0 -y &&\
    which markdownlint &&\
    markdownlint --version &&\
    hugo version &&\
    node --version &&\
    npm --version

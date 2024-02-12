FROM ubuntu:latest

WORKDIR /actions-runner

RUN apt-get update
RUN apt-get install -y curl tar

ENV AR_PLATFORM=linux-x64
ENV AR_VERSION=2.312.0
ENV BASE_URL=https://github.com/actions/runner/releases/download

RUN curl -o download.gz -L ${BASE_URL}/v${AR_VERSION}/actions-runner-${AR_PLATFORM}-${AR_VERSION}.tar.gz
RUN tar xzf ./download.gz
RUN rm ./download.gz
RUN ./bin/installdependencies.sh

RUN adduser --disabled-password --gecos "" actions-runner
RUN chown -R actions-runner /actions-runner

COPY ./configure.sh .
RUN chmod +x ./configure.sh

COPY ./entrypoint.sh .
RUN chmod +x ./entrypoint.sh

#PYTHON
RUN apt-get install -y python3.11 python3-venv python3-pip

#NODE
ENV DEBIAN_FRONTEND=noninteractive
ENV NODE_MAJOR=20
RUN apt-get install -y wget gnupg ca-certificates
RUN curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
RUN echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list
RUN apt-get update
RUN apt-get install -y nodejs

#DOTNET
RUN wget https://dot.net/v1/dotnet-install.sh -O dotnet-install.sh
RUN chmod +x ./dotnet-install.sh
RUN ./dotnet-install.sh --version latest

USER actions-runner

CMD ["/bin/bash", "/actions-runner/entrypoint.sh"]
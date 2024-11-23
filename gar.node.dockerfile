FROM ghcr.io/actions/actions-runner

USER root

COPY ./initial-configuration.sh .
RUN chmod +x ./initial-configuration.sh
COPY ./entrypoint.sh .
RUN chmod +x ./entrypoint.sh

RUN useradd actions-runner
RUN chown -R actions-runner .

ENV DEBIAN_FRONTEND=noninteractive
ENV NODE_MAJOR=20

RUN apt update
RUN apt install -y wget gnupg curl tmux ca-certificates

RUN curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
RUN echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list
RUN apt update
RUN apt install -y nodejs

USER actions-runner

CMD ["/bin/bash", "./entrypoint.sh"]
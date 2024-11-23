FROM ghcr.io/actions/actions-runner

USER root

COPY ./initial-configuration.sh .
RUN chmod +x ./initial-configuration.sh
COPY ./entrypoint.sh .
RUN chmod +x ./entrypoint.sh

RUN useradd actions-runner
RUN chown -R actions-runner .

RUN apt update
RUN apt install -y dotnet-sdk-8.0

USER actions-runner

CMD ["/bin/bash", "./entrypoint.sh"]
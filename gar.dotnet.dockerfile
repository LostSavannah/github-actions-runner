FROM ghcr.io/actions/actions-runner

USER root

COPY ./initial-configuration.sh .
RUN chmod +x ./initial-configuration.sh
COPY ./entrypoint.sh .
RUN chmod +x ./entrypoint.sh

RUN useradd actions-runner
RUN chown -R actions-runner .

#todo install dotnet

USER actions-runner

CMD ["/bin/bash", "./entrypoint.sh"]
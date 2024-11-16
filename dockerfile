FROM python:latest AS downloader
ARG OS=linux
ARG ARCH=x64
WORKDIR /downloader
COPY ./requirements.txt .
RUN pip install -r ./requirements.txt
COPY ./offline.json .
COPY ./download-actions-runner.py .
ENV AR_OPERATING_SYSTEM=${OS}
ENV AR_ARCHITECTURE=${ARCH}
RUN python3 ./download-actions-runner.py

FROM ubuntu:latest

RUN apt update
RUN apt install -y wget
RUN wget https://dot.net/v1/dotnet-install.sh -O dotnet-install.sh
RUN chmod +x ./dotnet-install.sh
RUN ./dotnet-install.sh
RUN apt install -y libicu-dev

WORKDIR /actions-runner

COPY --from=downloader /downloader/actions-runner.tar.gz .
RUN tar xzf ./actions-runner.tar.gz

COPY ./configure.sh .
RUN chmod +x ./configure.sh
COPY ./entrypoint.sh .
RUN chmod +x ./entrypoint.sh

RUN useradd actions-runner
RUN chown -R actions-runner /actions-runner


USER actions-runner

CMD ["/bin/bash", "/actions-runner/entrypoint.sh"]
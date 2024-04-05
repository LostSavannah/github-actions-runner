FROM python:latest as downloader
WORKDIR /downloader
COPY ./requirements.txt .
RUN pip install -r ./requirements.txt
COPY ./offline.json .
COPY ./download-actions-runner.py .
RUN python3 ./download-actions-runner.py

FROM ubuntu:latest

RUN apt-get update
RUN apt-get install -y dotnet-sdk-8.0
WORKDIR /actions-runner

COPY --from=downloader /downloader/actions-runner.tar.gz .
RUN tar xzf ./actions-runner.tar.gz

COPY ./configure.sh .
RUN chmod +x ./configure.sh
COPY ./entrypoint.sh .
RUN chmod +x ./entrypoint.sh

RUN adduser --disabled-password --gecos "" actions-runner
RUN chown -R actions-runner /actions-runner


USER actions-runner

CMD ["/bin/bash", "/actions-runner/entrypoint.sh"]
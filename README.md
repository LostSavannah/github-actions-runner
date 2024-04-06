[![Test](https://github.com/LostSavannah/github-actions-runner/actions/workflows/test.yml/badge.svg)](https://github.com/LostSavannah/github-actions-runner/actions/workflows/test.yml)

[![Publish](https://github.com/LostSavannah/github-actions-runner/actions/workflows/publish.yml/badge.svg)](https://github.com/LostSavannah/github-actions-runner/actions/workflows/publish.yml)


# github-actions-runner

Ready to go image with a github self-hosted action runner with dotnet8.

## Build

Build it as you would build any dockerfile:

```bash
docker build -t actions-runner .
```

If you wish, you can instead push it from [Dockerhub](https://hub.docker.com/repository/docker/coderookieerick/github-actions-runner/general):

```bash
docker push coderookieerick/github-actions-runner
```

## Run

Execute this command to run the container:

```bash
docker run -itd --name=actions-runner -e AR_ORGANIZATION=YourOrganizationName -e AR_TOKEN=YourToken actions-runner
```

Where **YourOrganizationName** is the name of your github organization and **YourToken** is the [actions-runner registration token](https://docs.github.com/en/rest/actions/self-hosted-runners?apiVersion=2022-11-28#create-a-registration-token-for-an-organization).

If you need more information please consider checking the official actions runner documentation [here.](https://docs.github.com/en/enterprise-cloud@latest/actions/hosting-your-own-runners/managing-self-hosted-runners/adding-self-hosted-runners)
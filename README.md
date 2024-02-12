# github-actions-runner

Ready to go image with a self-hosted action runner, python3, node and dotnet8.

## Build

Build it as you would build any dockerfile:

```bash
docker build -t actions-runner .
```

## Run

Execute this command to run the container:

```bash
docker run -it --name=actions-runner actions-runner
```

It will prompt you asking for the Organization Name and the token. You can get those after clicking the "New runner" button in the action runners section on github Organization settings. 

If you need more information please consider checking the official documentation [here.](https://docs.github.com/en/enterprise-cloud@latest/actions/hosting-your-own-runners/managing-self-hosted-runners/adding-self-hosted-runners)
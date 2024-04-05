import requests
import json
import re

RELEASE_URL = 'https://api.github.com/repos/actions/runner/releases/latest'
LOCAL_RELEASES_URL = "./example.json"
USER_AGENT = "hub.docker.com_coderookieerick_github-actions-runner"

def get_releases_data():
    try:
        return requests.get(
            RELEASE_URL, 
            headers={"user-agent":USER_AGENT}
            ).json()
    except:    
        with open(LOCAL_RELEASES_URL, 'r') as fi:
            return json.load(fi)

def get_releases():
        release_data = get_releases_data()["assets"]
        return {i["name"]: i["browser_download_url"] for i in release_data}
    

def get_release(os:str, arch:str):
    pattern = f"actions-runner-{os}-{arch}-[\\w\\W]+"
    releases = get_releases()
    candidates = [
         releases[i]
         for i in get_releases()
         if re.match(pattern, i)
    ]
    if len(candidates) == 1:
         return candidates[0]
    raise Exception(f"Can't find release for {os} {arch}")

def download_file(url:str, target:str, chunk_size:int = 10485760):
    dowloaded:int = 0
    with requests.get(
        url, 
        headers={"user-agent":USER_AGENT}, 
        stream=True) as fi:
        with open(target, 'wb') as fo:
            for chunk in fi.iter_content(chunk_size=chunk_size):
                dowloaded += len(chunk)
                fo.write(chunk)
    
release = get_release("linux", "x64")
download_file(release, "./actions-runner.tar.gz")
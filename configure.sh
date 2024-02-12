read -p "Github organization name: " AR_ORG
read -p "Token: " AR_TOKEN
./config.sh --url https://github.com/${AR_ORG} --token ${AR_TOKEN}
cd /actions-runner
test -x ./initial-configuration.sh && ./initial-configuration.sh && /bin/rm -f ./initial-configuration.sh
./run.sh
cd /actions-runner
test -x ./configure.sh && ./configure.sh && /bin/rm -f ./configure.sh
./run.sh
#Script to run network perf test with iperf and netperf drivers to hit 100Gigs/second data for 30 seconds each.
#you may skip the below steps 1-6 for the repetitive runs to save time and existing data/results.

#Step 1;
git clone http://github.com/cloud-bulldozer/k8s-netperf

#Step 2;
cd k8s-netperf

#Step 3;     This step requires the latest go code installed  [ go1.20.3 ].
make build

#Step 4;
oc create ns netperf

#Step 5;
oc create sa -n netperf netperf



#Step6 Changes to the yaml file [20 streams, 30 seconds-duration,16384  [16MB].
sed -i '/^TCPStream:/{n;n;n;n;s/samples:.*/samples: 20/;}' netperf.yml;
sed -i '/^TCPStream:/{n;n;n;n;n;s/messagesize:.*/messages: 16384/;}' netperf.yml;
sed -i '/^TCPStream:/{n;n;n;s/duration:.*/duration: 30/;}' netperf.yml;

#Step7 Run a test.
./bin/amd64/k8s-netperf --clean=true --iperf

BIN=/home/owasserm/teuthology
MACHINE_TYPE=vps
BRANCH=$1
SUITE_BRANCH=" --suite-branch ${2:-"master"}"
$BIN/virtualenv/bin/teuthology-suite -v --suite rgw   --subset 1/3 --owner owasserm@redhat.com --ceph  $BRANCH --machine-type $MACHINE_TYPE $3


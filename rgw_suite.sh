BIN=/home/owasserm/teuthology
MACHINE_TYPE=smithi
BRANCH=$1
SUITE_BRANCH=" --suite-branch ${2:-"master"}"
$BIN/virtualenv/bin/teuthology-suite -v --suite rgw   --subset 1/3 --owner owasserm@redhat.com -d ubuntu --ceph  $BRANCH --machine-type $MACHINE_TYPE $3  -p 200 --dry-run 


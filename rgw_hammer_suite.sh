BIN=/home/owasserm/teuthology
MACHINE_TYPE=smithi
BRANCH=$1
$BIN/virtualenv/bin/teuthology-suite --suite rgw --suite-branch hammer  --email owasserm@redhat.com --ceph  $BRANCH --machine-type $MACHINE_TYPE $2

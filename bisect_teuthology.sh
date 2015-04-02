
filter="rgw/verify/{overrides.yaml clusters/fixed-2.yaml frontend/apache.yaml fs/btrfs.yaml msgr-failures/few.yaml rgw_pool_type/ec-cache.yaml tasks/rgw_s3tests.yaml validater/lockdep.yaml}"

MACHINE_TYPE=smithi
SUITE=rgw
SUITE_BRANCH=master
BRANCH=wip-rgw-context-leak
SHA=$1
./virtualenv/bin/teuthology-suite \
    --filter="$filter" \
    --suite $SUITE \
    --suite-branch $SUITE_BRANCH \
    --machine-type $MACHINE_TYPE \
    --email owasserm@redhat.com \
    --owner owasserm@redhat.com  \
    --ceph $BRANCH \
    --sha1 $SHA \
    $2

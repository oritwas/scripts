
#run=owasserm-2016-02-17_16:47:41-rgw-wip-rgw-new-multisite-rebase-2---basic-smithi
#paddles=http://paddles.front.sepia.ceph.com
#eval filter=$(curl --silent $paddles/runs/$run/jobs/?status=fail | \
#jq '.[].description' | \
#while read description ; do echo -n $description, ; done | \
#sed -e 's/,$//')

#filter="rgw/singleton/{overrides.yaml xfs.yaml all/radosgw-admin-data-sync.yaml frontend/apache.yaml fs/xfs.yaml rgw_pool_type/ec.yaml}"
#filter="rgw/singleton/{overrides.yaml xfs.yaml all/radosgw-admin-multi-region.yaml frontend/civetweb.yaml fs/xfs.yaml rgw_pool_type/ec-cache.yaml}"
#filter="rgw/singleton/{overrides.yaml xfs.yaml all/radosgw-admin-data-sync.yaml frontend/civetweb.yaml fs/xfs.yaml rgw_pool_type/ec-profile.yaml}"
#filter="rgw/verify/{overrides.yaml clusters/fixed-2.yaml frontend/apache.yaml fs/xfs.yaml msgr-failures/few.yaml rgw_pool_type/ec-cache.yaml tasks/rgw_s3tests.yaml validater/lockdep.yaml}"
filter="smoke/basic/{clusters/fixed-3-cephfs.yaml fs/btrfs.yaml tasks/rgw_s3tests.yaml}"
MACHINE_TYPE=vps
SUITE=smoke
SUITE_BRANCH=master
BRANCH=wip-hammer-11567

./virtualenv/bin/teuthology-suite --filter="$filter" \
  --suite $SUITE --suite-branch $SUITE_BRANCH \
  --machine-type $MACHINE_TYPE \
  --email owasserm@redhat.com \
  --owner owasserm@redhat.com  \
  --ceph $BRANCH 

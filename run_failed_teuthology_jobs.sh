
#run=owasserm-2016-02-17_16:47:41-rgw-wip-rgw-new-multisite-rebase-2---basic-smithi
#paddles=http://paddles.front.sepia.ceph.com
#eval filter=$(curl --silent $paddles/runs/$run/jobs/?status=fail | \
#jq '.[].description' | \
#while read description ; do echo -n $description, ; done | \
#sed -e 's/,$//')

filter="rgw/singleton/{overrides.yaml xfs.yaml all/radosgw-admin-multi-region.yaml frontend/civetweb.yaml fs/xfs.yaml rgw_pool_type/ec-profile.yaml}"
MACHINE_TYPE=vps
SUITE=rgw
SUITE_BRANCH=master
BRANCH=wip-orit-testing

./virtualenv/bin/teuthology-suite --filter="$filter" \
  --suite $SUITE --suite-branch $SUITE_BRANCH \
  --machine-type $MACHINE_TYPE \
  --email owasserm@redhat.com \
  --ceph $BRANCH 

CEPH=/home/owasserm/ceph/build/src
SCRIPTS=/home/owasserm/scripts

$CEPH/radosgw-admin --log-to-stderr --format json realm create --rgw-realm realm0 --default
$CEPH/radosgw-admin --log-to-stderr --format json zonegroup set < $SCRIPTS/region0.json

$CEPH/radosgw-admin --log-to-stderr --format json zonegroup default --rgw-zonegroup region0

$CEPH/radosgw-admin --log-to-stderr --format json zone set --rgw-zonegroup region0 --rgw-zone r0z1 < $SCRIPTS/r0z1.json

$CEPH/radosgw-admin --log-to-stderr --format json zone set --rgw-zonegroup region0 --rgw-zone r0z0 < $SCRIPTS/r0z0.json

$CEPH/radosgw-admin --log-to-stderr --format json zone default --rgw-zone r0z0 

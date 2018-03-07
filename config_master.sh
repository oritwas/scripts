CEPH_BIN=${1:-."/bin"}

$CEPH_BIN/radosgw-admin realm create --rgw-realm=realm0 --default
$CEPH_BIN/radosgw-admin zonegroup set < region0.json
$CEPH_BIN/radosgw-admin zonegroup default --rgw-zonegroup=region0
$CEPH_BIN/radosgw-admin zone set < r0z0.json
$CEPH_BIN/radosgw-admin zone default --rgw-zone=r0z0
$CEPH_BIN/radosgw-admin zone set < r0z1.json
$CEPH_BIN/radosgw-admin period update --commit

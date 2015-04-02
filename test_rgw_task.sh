CEPH_BIN=./src

$CEPH_BIN/radosgw-admin realm create --rgw-realm=realm0 --default
$CEPH_BIN/radosgw-admin zonegroup set < zg1.json
$CEPH_BIN/radosgw-admin zonegroup default --rgw-zonegroup=zg1
$CEPH_BIN/radosgw-admin zone set < zg1.json
$CEPH_BIN/radosgw-admin zone default --rgw-zone=r0
$CEPH_BIN/radosgw-admin period update --commit

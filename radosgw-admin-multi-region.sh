SCRIPTS=/home/owasserm/scripts
BIN=/home/owasserm/ceph/build/bin

$BIN/radosgw-admin --log-to-stderr --format json realm create --rgw-realm realm0 --default
$BIN/radosgw-admin --log-to-stderr --format json zonegroup set < $SCRIPTS/region1.json

$BIN/radosgw-admin --log-to-stderr --format json zonegroup set < $SCRIPTS/region0.json

$BIN/radosgw-admin --log-to-stderr --format json zonegroup default --rgw-zonegroup region0

$BIN/radosgw-admin --log-to-stderr --format json zone set --rgw-zonegroup region0 --rgw-zone r0z1 < $SCRIPTS/r0z1.json

$BIN/radosgw-admin --log-to-stderr --format json zone default --rgw-zone r0z1

$BIN/radosgw-admin --log-to-stderr --format json period update --commit

$BIN/radosgw-admin --log-to-stderr --format json user create --uid client1-system-user --access-key $SYSTEM_ACCESS_KEY --secret $SYSTEM_SECRET_KEY --display-name client1-system-user --system

$BIN/radosgw-admin --log-to-stderr --format json user create --uid client0-system-user --access-key $SYSTEM_ACCESS_KEY --secret $SYSTEM_SECRET_KEY --display-name client0-system-user --system



SCRIPTS=/home/owasserm/scripts
BIN=/home/owasserm/ceph/build/bin

$BIN/radosgw-admin --log-to-stderr --format json realm pull --rgw-realm realm0 --default --url http://localhost:7280/ --access_key $SYSTEM_ACCESS_KEY --secret $SYSTEM_SECRET_KEY

$BIN/radosgw-admin --log-to-stderr --format json zonegroup default --rgw-zonegroup region1

$BIN/radosgw-admin --log-to-stderr --format json zone set --rgw-zonegroup region1 --rgw-zone r1z1 < $SCRIPTS/r1z1.json

$BIN/radosgw-admin --log-to-stderr --format json period update --commit --url http://localhost:7280/ --access_key $SYSTEM_ACCESS_KEY --secret $SYSTEM_SECRET_KEY

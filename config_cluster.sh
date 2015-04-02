BIN=/home/owasserm/ceph/build/

$BIN/bin/radosgw-admin --log-to-stderr --format json -n client.0 -k $BIN/ceph.client.radosgw.keyring realm create --rgw-realm realm0 --default
$BIN/bin/radosgw-admin --log-to-stderr --format json -n client.1 -k $BIN/ceph.client.radosgw.keyring zone set --rgw-zonegroup region0 --rgw-zone r0z1 < r0z1.json
$BIN/bin/radosgw-admin --log-to-stderr --format json -n client.1 -k $BIN/ceph.client.radosgw.keyring zone set --rgw-zonegroup region0 --rgw-zone r0z0 < r0z0.json
$BIN/bin/radosgw-admin --log-to-stderr --format json -n client.1 -k $BIN/ceph.client.radosgw.keyring zonegroup set < region0.json
$BIN/bin/radosgw-admin --log-to-stderr --format json -n client.1 -k $BIN/ceph.client.radosgw.keyring zonegroup default --rgw-zonegroup region0
$BIN/bin/radosgw-admin --log-to-stderr --format json -n client.0 -k $BIN/ceph.client.radosgw.keyring zone set --rgw-zonegroup region0 --rgw-zone r0z1 < r0z1.json
$BIN/bin/radosgw-admin --log-to-stderr --format json -n client.0 -k $BIN/ceph.client.radosgw.keyring zone set --rgw-zonegroup region0 --rgw-zone r0z0 < r0z0.json
$BIN/bin/radosgw-admin --log-to-stderr --format json -n client.0 -k $BIN/ceph.client.radosgw.keyring zonegroup set < region0.json
$BIN/bin/radosgw-admin --log-to-stderr --format json -n client.0 -k $BIN/ceph.client.radosgw.keyring zonegroup default --rgw-zonegroup region0
$BIN/bin/radosgw-admin --log-to-stderr --format json -n client.0 -k $BIN/ceph.client.radosgw.keyring zone default --rgw-zone=r0z0
$BIN/bin/radosgw-admin --log-to-stderr --format json -n client.1 -k $BIN/ceph.client.radosgw.keyring zone default --rgw-zone=r0z0

$BIN/bin/radosgw-admin --log-to-stderr --format json -n client.0 -n client.0 -k $BIN/ceph.client.radosgw.keyring period update --commit

$BIN/bin/radosgw-admin --log-to-stderr --format json -n client.1 -k $BIN/ceph.client.radosgw.keyring user create --uid client1-system-user --access-key $S3_ACCESS_KEY_ID --secret $S3_SECRET_ACCESS_KEY --display-name client1-system-user --system --rgw-zone=r0z1
$BIN/bin/radosgw-admin --log-to-stderr --format json -n client.0 -k $BIN/ceph.client.radosgw.keyring user create --uid client1-system-user --access-key $S3_ACCESS_KEY_ID --secret $S3_SECRET_ACCESS_KEY --display-name client1-system-user --system
$BIN/bin/radosgw-admin --log-to-stderr --format json -n client.1 -k $BIN/ceph.client.radosgw.keyring user create --uid client0-system-user --access-key $S3_ACCESS_KEY_ID --secret $S3_SECRET_ACCESS_KEY --display-name client0-system-user --system --rgw-zone=r0z1
$BIN/bin/radosgw-admin --log-to-stderr --format json -n client.0 -k $BIN/ceph.client.radosgw.keyring user create --uid client0-system-user --access-key $S3_ACCESS_KEY_ID --secret $S3_SECRET_ACCESS_KEY --display-name client0-system-user --system

$BIN/bin/radosgw-admin --log-to-stderr --format json -n client.0 -k ./ceph.client.radosgw.keyring user create --uid foo --display-name Foo --email foo@foo.com --access-key $S3_ACCESS_KEY_ID --secret $S3_SECRET_ACCESS_KEY --max-buckets 4

#$BIN/bin/radosgw -n client.0 --log-file $BIN/out/rgw.client.0.log --rgw-frontends="civetweb port=7280" -k $BIN/ceph.client.radosgw.keyring --rgw-zone r0z0
#$BIN/bin/radosgw -n client.1 --log-file $BIN/out/rgw.client.1.log --rgw-frontends="civetweb port=7281" -k $BIN/ceph.client.radosgw.keyring --rgw-zone r0z1


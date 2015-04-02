access_key=$SYSTEM_ACCESS_KEY
secret=$SYSTEM_SECRET_KEY

CEPH_DIR=./src

$CEPH_DIR/radosgw-admin realm pull --url=http://rgw1 --access-key=${access_key} --secret=${secret}
$CEPH_DIR/radosgw-admin zone create --rgw-zonegroup=us --rgw-zone=us-2 --access-key=${access_key} --secret=${secret} --endpoints=http://rgw2:80
$CEPH_DIR/radosgw-admin period update --commit

$CEPH_DIR/radosgw --rgw-zone=us-2 --rgw-frontends="civetweb port=8001" --log-file ./out/rgw2.log --debug-rgw=20 --debug-ms=5

access_key=$SYSTEM_ACCESS_KEY
secret=$SYSTEM_SECRET_KEY

CEPH_DIR=./src
# run on rgw1
$CEPH_DIR/radosgw-admin realm create --rgw-realm=earth --default
$CEPH_DIR/radosgw-admin zonegroup create --rgw-zonegroup=us --endpoints=http://rgw1:80 --master --default
$CEPH_DIR/radosgw-admin zone create --rgw-zonegroup=us --rgw-zone=us-1 --access-key=${access_key} --secret=${secret} --endpoints=http://rgw1:80 --default
$CEPH_DIR/radosgw-admin user create --uid=zone.jup --display-name="Zone User" --access-key=${access_key} --secret=${secret} --system
$CEPH_DIR/radosgw-admin period update --commit
$CEPH_DIR/radosgw --rgw-zone=us-1 --rgw-frontends="civetweb port=8000" --log-file ./out/rgw1.log --debug-rgw=20 --debug-ms=5

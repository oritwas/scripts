CEPH_DIR=./src/
CEPH_CONF=./ceph.conf

$CEPH_DIR/radosgw-admin user create --uid=zone.skinny --display-name="Skinny Zone"  --access-key=$S3_ACCESS_KEY_ID --secret=$S3_SECRET_ACCESS_KEY --system  --rgw-zone=skinny-1

$CEPH_DIR/radosgw-admin user create --uid=zone.skinny --display-name="Skinny Zone"  --access-key=$S3_ACCESS_KEY_ID --secret=$S3_SECRET_ACCESS_KEY --system  --rgw-zone=skinny-2

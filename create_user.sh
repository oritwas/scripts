CEPH_DIR=${1:-"./bin"}

$CEPH_DIR/radosgw-admin user create --uid=testid --display-name="M. Tester"  --access-key=$S3_ACCESS_KEY_ID --secret=$S3_SECRET_ACESS_KEY --email tester@ceph.com


$CEPH_DIR/radosgw-admin user create --uid=owasserm --display-name="owasserm"  --access-key=$OWASSERM_KEY --secret=$OWASSERM_SECRET --email owasserm@redhat.com

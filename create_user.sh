CEPH_DIR=${1:-"./bin"}

$CEPH_DIR/radosgw-admin user create --uid=testid --display-name="tester"  --access-key=$SYSTEM_ACCESS_KEY --secret=$SYSTEM_SECRET_KEY --email tester@ceph.com


$CEPH_DIR/radosgw-admin user create --uid=owasserm --display-name="owasserm"  --access-key=$OWASSERM_KEY --secret=$OWASSERM_SECRET --email owasserm@redhat.com


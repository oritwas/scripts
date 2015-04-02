CEPH_DIR=.
CEPH_CONF=./ceph.conf
S3_KEY=$S3_ACCESS_KEY_ID
S3_SECRET=$S3_SECRET_ACCESS_KEY

$CEPH_DIR/radosgw-admin user create --uid=s3tester --display-name=s3tester  --access-key=$S3_KEY --secret=$S3_SECRET -c $CEPH_CONF --email owasserm@redhat.com


KEY=$OWASSERM_KEY
SECRET=$OWASSERM_SECRET

$CEPH_DIR/radosgw-admin user create --uid=owasserm --display-name="owasserm"  --access-key=$KEY --secret=$SECRET -c $CEPH_CONF 

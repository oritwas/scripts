CEPH=/home/owasserm/ceph/build/
CEPH_BIN=$CEPH/bin/
export RGW_ADMIN=$CEPH_BIN/radosgw-admin
export RGW_PORT=8000
export RGW_FQDN=127.0.0.1

cd $CEPH
$RGW_ADMIN user create --uid=qa_user --display-name=qa_user --access-key=$S3_KEY --secret=$S3_SECRET --email owasserm@redhat.com

perl /home/owasserm/ceph/qa/workunits/rgw/s3_bucket_quota.pl

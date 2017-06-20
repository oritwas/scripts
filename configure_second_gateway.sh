CEPH_DIR=${1:-"."}
CEPH_BIN=${1:-"./bin"}
CEPH_CONF=$CEPH_DIR/run/c2/ceph.conf

$CEPH_BIN/radosgw-admin realm pull --url=http://localhost:8000 --access-key=$S3_ACCESS_KEY_ID --secret=$S3_SECRET_ACCESS_KEY --default -c $CEPH_CONF 
$CEPH_BIN/radosgw-admin period pull --url=http://localhost:8000 --access-key=$S3_ACCESS_KEY_ID --secret=$S3_SECRET_ACCESS_KEY -c $CEPH_CONF --default
$CEPH_BIN/radosgw-admin zone create --rgw-zonegroup=us --rgw-zone=us-west --endpoints=http://localhost:8001 --access-key=$S3_ACCESS_KEY_ID --secret=$S3_SECRET_ACCESS_KEY --default -c $CEPH_CONF

$CEPH_BIN/radosgw-admin period update --commit -c $CEPH_CONF

pid=`cat $CEPH_DIR/run/c2/out/rgw.pid`
kill $pid

sleep 2

/home/owasserm/scripts/run_second_gateway.sh . --rgw-zone=us-west

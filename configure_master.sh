CEPH_DIR=${1:-"."}
CEPH_BIN=${1:-"./bin"}
#CEPH_CONF=$CEPH_DIR/ceph.conf
CEPH_CONF=$CEPH_DIR/run/c1/ceph.conf

$CEPH_BIN/radosgw-admin realm create --rgw-realm gold --default -c $CEPH_CONF

$CEPH_BIN/radosgw-admin zonegroup create --rgw-zonegroup=us --endpoints=http://localhost:8000 --master --default -c $CEPH_CONF

$CEPH_BIN/radosgw-admin zone create --rgw-zonegroup=us --rgw-zone=us-east --endpoints=http://localhost:8000 --access-key=$S3_ACCESS_KEY_ID --secret=$S3_SECRET_ACCESS_KEY --default --master -c $CEPH_CONF

$CEPH_BIN/radosgw-admin user create --uid=owasserm --display-name="owasserm" --access-key=$S3_ACCESS_KEY_ID --secret=$S3_SECRET_ACCESS_KEY --system -c $CEPH_CONF

$CEPH_BIN/radosgw-admin period update --commit -c $CEPH_CONF

pid=`cat $CEPH_DIR/run/c1/out/rgw.pid`
kill $pid

sleep 2

/home/owasserm/scripts/run_master.sh --rgw-zone=us-east

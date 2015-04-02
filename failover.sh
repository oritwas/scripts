CEPH_DIR=/home/owasserm/jewel/build/
CEPH_BIN=$CEPH_DIR/bin
CEPH_CONF=$CEPH_DIR/run/c2/ceph.conf

$CEPH_BIN/radosgw-admin zone modify --rgw-zonegroup=us --rgw-zone=us-west --master -c $CEPH_CONF

$CEPH_BIN/radosgw-admin period update --commit -c $CEPH_CONF

#pid=`cat $CEPH_DIR/run/c2/out/rgw.pid`
#kill $pid

#sleep 2

#/home/owasserm/scripts/run_second_gateway.sh --rgw-zone=us-west

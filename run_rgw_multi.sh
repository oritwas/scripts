CEPH_DIR=$HOME/ceph/src
LOG_DIR=$HOME/ceph/src/out

$CEPH_DIR/radosgw --log-file=$LOG_DIR/radosgw.log --rgw-region=skinny --rgw-zone=skinny-1 --rgw-frontends="civetweb port=8000"

$CEPH_DIR/radosgw --log-file=$LOG_DIR/skinny-2.radosgw.log --rgw-region=skinny --rgw-zone=skinny-2 --rgw-frontends="civetweb port=8001"

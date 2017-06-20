CEPH_DIR=${1:-"."}
CEPH_BIN=${1:-"./bin"}

$CEPH_BIN/radosgw -c $CEPH_DIR/run/c2/ceph.conf --log-file $CEPH_DIR/run/c2/out/rgw.log --rgw-frontends="civetweb port=8001" --pid-file=$CEPH_DIR/run/c2/out/rgw.pid --debug-rgw=20 $1

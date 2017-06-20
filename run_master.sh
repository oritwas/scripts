CEPH_DIR=/home/owasserm/ceph/build
CEPH_BIN=$CEPH_DIR/bin

$CEPH_BIN/radosgw -c $CEPH_DIR/run/c1/ceph.conf --log-file $CEPH_DIR/run/c1/out/rgw.log --rgw-frontends="civetweb port=8000" --pid-file=$CEPH_DIR/run/c1/out/rgw.pid --debug-rgw 20 $1 

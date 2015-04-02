CEPH_DIR=/home/owasserm/jewel/build
CEPH_BIN=$CEPH_DIR/bin

$CEPH_BIN/radosgw -c $CEPH_DIR/run/c1/ceph.conf --log-file $CEPH_DIR/run/c1/out/rgw.log --rgw-frontends="civetweb port=8000" --pid-file=$CEPH_DIR/run/c1/out/rgw.pid --rgw-debug 20 $1 

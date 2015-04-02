CEPH_DIR=/home/owasserm/jewel/build/
CEPH_BIN=$CEPH_DIR/bin

$CEPH_BIN/radosgw -c $CEPH_DIR/run/c2/ceph.conf --log-file .$CEPH_DIR/run/c2/out/rgw.log --rgw-frontends="civetweb port=8001" --pid-file=$CEPH_DIR/run/c2/out/rgw.pid $1

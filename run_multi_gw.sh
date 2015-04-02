CEPH_DIR=/home/owasserm/ceph/build
$CEPH_DIR/src/radosgw --rgw-zone=skinny-1 \
--rgw-frontends="civetweb port=8000" --log-file=$CEPH_DIR/out/radosgw.log \
--debug-ms=1 --debug-rgw=20 --debug-civetweb=10 -c $CEPH_DIR/ceph.conf --rgw_run_sync_thread=false
$CEPH_DIR/src/radosgw --rgw-zone=skinny-2 \
--rgw-frontends="civetweb port=8001" \
--log-file=$CEPH_DIR/out/skinny-2.radosgw.log --debug-ms=1 \
--debug-rgw=20 --debug-civetweb=10 -c $CEPH_DIR/ceph.conf --rgw_run_sync_thread=false

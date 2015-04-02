CEPH_DIR=/home/owasserm/ceph/src/
echo '[client.radosgw.gateway]
        rgw frontends = "civetweb port=8000"
        keyring = $CEPH_DIR/ceph.client.radosgw.keyring
' >> ceph.conf
sudo $CEPH_DIR/ceph -k keyring auth add client.radosgw.gateway -i ceph.client.radosgw.keyring
$CEPH_DIR/radosgw -n client.radosgw.gateway -c /home/owasserm/ceph/src//ceph.conf
#--debug-ms = 1

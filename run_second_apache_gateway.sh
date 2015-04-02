CEPH_BIN=/home/owasserm/ceph/build/bin
ZONE="--rgw-zone zone1"


$CEPH_BIN/radosgw --log-file ./out/rgw2.log --debug-rgw=20 --debug-ms=5 -c ceph.conf -n client.1 -k ceph.client.radosgw.keyring --rgw-socket-path /var/run/ceph/ceph.radosgw.gateway.fastcgi.sock --rgw-frontends "fastcgi port=9001"
#--rgw_ops_log_socket_path /home/ubuntu/cephtest/rgw.opslog.client.0.sock

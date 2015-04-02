CONFIG=$
ZONE="--rgw-zone zone1"

#CEPH_BIN=${1:-"./bin"}
#CEPH_CONF=${2:-"ceph.conf"}

CEPH_BIN="./bin"
CEPH_CONF="ceph.conf"

config=0
case $1 in
     --config)
	     config=1
	     ;;
esac
if [ "$config" -eq 1 ]; then		   
cat <<EOF >> $CEPH_CONF 
[client.0]
host = {hostname}
keyring = /home/owasserm/ceph/build/keyring
rgw frontends = fastcgi socket_port=9000 socket_host=0.0.0.0
rgw socket path = /home/owasserm/ceph/build/ceph.radosgw.gateway.fastcgi.sock
rgw print continue = false
EOF
fi

$CEPH_BIN/radosgw --log-file ./out/rgw.log --debug-rgw=20 --debug-ms=5 -c $CEPH_CONF -n client.0 -k ceph.client.radosgw.keyring --rgw-socket-path /var/run/ceph/ceph.radosgw.gateway.fastcgi.sock --rgw-frontends fastcgi --rgw-zone=r0z1
#--rgw_ops_log_socket_path /home/ubuntu/cephtest/rgw.opslog.client.0.sock

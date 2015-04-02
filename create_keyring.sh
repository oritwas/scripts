#!/bin/bash -x

BIN=/home/owasserm/ceph/build/

$BIN/bin/ceph-authtool --create-keyring $BIN/ceph.client.radosgw.keyring
sudo chmod +r /$BIN/ceph.client.radosgw.keyring

sudo $BIN/bin/ceph-authtool $BIN/ceph.client.radosgw.keyring -n client.0 --gen-key
sudo $BIN/bin/ceph-authtool $BIN/ceph.client.radosgw.keyring -n client.1 --gen-key

sudo $BIN/bin/ceph-authtool -n client.0 --cap osd 'allow rwx' --cap mon 'allow rwx' $BIN/ceph.client.radosgw.keyring
sudo $BIN/bin/ceph-authtool -n client.1 --cap osd 'allow rwx' --cap mon 'allow rwx' $BIN/ceph.client.radosgw.keyring

sudo $BIN/bin/ceph -k $BIN/keyring auth add client.0 -i $BIN/ceph.client.radosgw.keyring
sudo $BIN/bin/ceph -k $BIN/keyring auth add client.1 -i $BIN/ceph.client.radosgw.keyring

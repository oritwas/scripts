#!/bin/bash -x
OLD=/home/owasserm/hammer/src
NEW=/home/owasserm/jewel/src
OUT_DIR=/home/owasserm/upgrade
ZONE="-z r0z0"

export CEPH_OUT_DIR=$OUT_DIR/out
export CEPH_DEV_DIR=$OUT_DIR/dev

# copy ceph.conf to the new
#cp $OUT_DIR/ceph.conf $NEW/.
#cp $OLD/ceph.conf $NEW/.
# change ec dir:
#	erasure code dir = ./.libs
#	
# add to the osd section:
#        osd_check_max_object_name_len_on_startup = false


echo "copy keyring"
cp $OLD/keyring $NEW/.

echo "copy ceph.conf"
cp $OUT_DIR/ceph.conf $NEW/.

echo "Running jewel"
cd $NEW
./vstart.sh
/home/owasserm/scripts/run_gateway.sh -b $NEW/ $ZONE

/home/owasserm/scripts/run_gateway.sh -b $NEW/ -p 8001 $ZONE 

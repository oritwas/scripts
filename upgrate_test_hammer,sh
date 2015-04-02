OLD=/home/owasserm/hammer/src
NEW=/home/owasserm/jewel/src
OUT_DIR=/home/owasserm/upgrade

export CEPH_OUT_DIR=$OUT_DIR/out
export CEPH_DEV_DIR=$OUT_DIR/dev

# first run the old
echo "Running hammer"
cd $OLD
./vstart.sh -r -n
echo "Backing up .rgw.root pool"
./rados mkpool .rgw.root.backup
./rados cppool .rgw.root .rgw.root.backup
./stop.sh

# copy ceph.conf to the new
#cp $OLD/ceph.conf $NEW/.
# change ec dir:
#	erasure code dir = ./.libs
#	
# add to the osd section:
#        osd_check_max_object_name_len_on_startup = false


echo "copy keyring"
cp $OLD/keyring $NEW/.

echo "Running jewel"
cd $NEW
./vstart.sh
/home/owasserm/scripts/run_gateway.sh $NEW

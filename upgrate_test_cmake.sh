OLD=/home/owasserm/hammer/src
NEW=/home/owasserm/ceph/build
OUT_DIR=/home/owasserm/upgrade
SCRIPTS=/home/owasserm/scripts/

export CEPH_OUT_DIR=$OUT_DIR/out
export CEPH_DEV_DIR=$OUT_DIR/dev

# first run the old
#cd $OLD
#./vstart.sh 
#./stop.sh

# copy ceph.conf to the new
#cp $OLD/ceph.conf $OUT_DIR/.
# change ec dir after mon data avail crit:
#	erasure code dir = /home/owasserm/ceph/build/lib
#	plugin_dir = /home/owasserm/ceph/build/lib
#       osd pool default erasure code directory = /home/owasserm/ceph/build/lib
# add to the osd section:
#        osd_check_max_object_name_len_on_startup = false
#        osd class dir = /home/owasserm/ceph/build/lib
# add to the mon section:
#        crushtool = /home/owasserm/ceph/build/bin/crushtool
cp $OLD/keyring $OUT_DIR/.

cd $NEW
export VSTART_DEST=$OUT_DIR
export MDS=0
../src/vstart.sh
$SCRIPTS/run_gateways.sh .

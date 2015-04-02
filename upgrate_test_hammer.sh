OLD=/home/owasserm/hammer/src
NEW=/home/owasserm/jewel/src
OUT_DIR=/home/owasserm/upgrade

export CEPH_OUT_DIR=$OUT_DIR/out
export CEPH_DEV_DIR=$OUT_DIR/dev

# first run the old
echo "Running hammer"
cd $OLD
./vstart.sh -n
# config
echo "config with" $1
$1
echo "Backing up .rgw.root pool"
./rados mkpool .rgw.root.backup
./rados cppool .rgw.root .rgw.root.backup
echo "Stopping"
./stop.sh

CEPH_DIR=${1:-"./bin"}
SCRIPTS=/home/owasserm/scripts

NUM=1
# create buckets
python $SCRIPTS/create_buckets.py --num $NUM

$CEPH_DIR/radosgw-admin metadata list --metadata-key="bucket"
$CEPH_DIR/radosgw-admin metadata list --metadata-key="bucket.instance"
$CEPH_DIR/rados ls -p .rgw.buckets.index

# delete buckets
for i in `seq 0 $NUM`;
do  
    $CEPH_DIR/radosgw-admin bucket rm --bucket bucket$i  --purge-objects
done

# list buckets
$CEPH_DIR/radosgw-admin metadata list --metadata-key="bucket"
$CEPH_DIR/radosgw-admin metadata list --metadata-key="bucket.instance"
$CEPH_DIR/rados ls -p .rgw.buckets.index

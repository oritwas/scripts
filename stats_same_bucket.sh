BIN=${1:-"./bin"}
SCRIPTS=/home/owasserm/scripts

$BIN/radosgw-admin user stats --uid=testid --sync-stats
$BIN/radosgw-admin user stats --uid=testid

python $SCRIPTS/create_bucket.py 1
$BIN/radosgw-admin user stats --uid=testid
python $SCRIPTS/create_objects.py --num 1 --bucket bucket1
$BIN/radosgw-admin user stats --uid=testid --sync-stats
python $SCRIPTS/create_bucket.py 1
$BIN/radosgw-admin user stats --uid=testid

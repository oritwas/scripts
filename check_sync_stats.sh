BIN=${1:-"./bin"}

$BIN/radosgw-admin quota enable --quota-scope=user  --uid=testid
$BIN/radosgw-admin quota set --quota-scope=user  --max-objects=1024 --max-size=102400 --uid=testid
$BIN/radosgw-admin user stats --uid=testid --sync-stats

python /home/owasserm/scripts/create_object.py --num 10 --bucket bucket1
$BIN/radosgw-admin user stats --uid=testid 
$BIN/radosgw-admin user stats --uid=testid --sync-stats

python /home/owasserm/scripts/create_object.py --num 5 --bucket bucket2
$BIN/radosgw-admin user stats --uid=testid 
$BIN/radosgw-admin user stats --uid=testid --sync-stats

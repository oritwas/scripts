run=owasserm-2016-02-17_16:47:41-rgw-wip-rgw-new-multisite-rebase-2---basic-smithi
paddles=http://paddles.front.sepia.ceph.com
eval filter=$(curl --silent $paddles/runs/$run/jobs/?status=fail | \
jq '.[].description' | \
while read description ; do echo -n $description, ; done | \
sed -e 's/,$//')

echo $fliter > filter.txt

run="/owasserm-2016-08-19_14:52:21-rgw-master---basic-vps/"
paddles=http://paddles.front.sepia.ceph.com
eval filter=$(curl --silent $paddles/runs/$run/jobs/?status=fail | \
		     jq '.[].description' | \
while read description ; do echo -n $description, ; done | \
sed -e 's/,$//')

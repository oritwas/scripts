#!/bin/sh

set -x

RADOSGW_ADMIN=./bin/radosgw-admin

echo "Get default zonegroup"
$RADOSGW_ADMIN zonegroup get --rgw-zonegroup=default | sed 's/"id":.*/"id": "default",/g' | sed 's/"master_zone.*/"master_zone": "default",/g' > default-zg.json

echo "Get default zone"
$RADOSGW_ADMIN zone get --zone-id=default > default-zone.json

echo "Creating realm"
$RADOSGW_ADMIN realm create --rgw-realm=myrealm

echo "Creating default zonegroup"
$RADOSGW_ADMIN zonegroup set --rgw-zonegroup=default < default-zg.json

echo "Creating default zone"
$RADOSGW_ADMIN zone set --rgw-zone=default < default-zone.json

echo "Setting default zonegroup to 'default'"
$RADOSGW_ADMIN zonegroup default --rgw-zonegroup=default

echo "Setting default zone to 'default'"
$RADOSGW_ADMIN zone default --rgw-zone=default

#!/bin/bash -x 

CONFIG=/home/owasserm/config
ADMIN=/home/owasserm/hammer/src/radosgw-admin
$ADMIN region set < $CONFIG/region0.json
$ADMIN region default --rgw-region region0
$ADMIN region get

$ADMIN zone set --rgw-zone r0z0 < $CONFIG/r0z0.json
$ADMIN zone get --rgw-zone r0z0
$ADMIN zone set --rgw-zone r0z1 < $CONFIG/r0z1.json
$ADMIN zone get --rgw-zone r0z1


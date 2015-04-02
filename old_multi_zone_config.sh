#!/bin/bash -x 

SCRIPTS=/home/owasserm/scripts
ADMIN=/home/owasserm/hammer/src/radosgw-admin
$ADMIN region set < $SCRIPTS/region0.json
$ADMIN region default --rgw-region region0
$ADMIN region get

$ADMIN zone set --rgw-zone r0z0 < $SCRIPTS/r0z0.json
$ADMIN zone get --rgw-zone r0z0
$ADMIN zone set --rgw-zone r0z1 < $SCRIPTS/r0z1.json
$ADMIN zone get --rgw-zone r0z1


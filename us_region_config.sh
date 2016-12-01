#!/bin/bash -x 

CONFIG=/home/owasserm/scripts
ADMIN=/home/owasserm/hammer/src/radosgw-admin
$ADMIN region set < $CONFIG/us.json
$ADMIN region default --rgw-region us
$ADMIN region get

$ADMIN zone set --rgw-zone us-west < $CONFIG/us-west.json
$ADMIN zone get --rgw-zone us-west
$ADMIN zone set --rgw-zone us-east < $CONFIG/us-east.json
$ADMIN zone get --rgw-zone us-east


#!/bin/bash

BUCKET=$1
NUM_SHARDS=$2
s3 -us getacl $BUCKET filename=bucket.acl
radosgw-admin bucket reshard --bucket $BUCKET --num-shards $NUM_SHARDS
s3 -us setacl $BUCKET filename=bucket.acl


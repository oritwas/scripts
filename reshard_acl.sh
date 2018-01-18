#!/bin/bash

CEPH_BIN=${1:-"./bin"}

s3 -us  create publicbucket cannedAcl=public-read-write

for i in {1..10}; do curl -X PUT http://localhost:8000/publicbucket/obj$i -d "@null" -s; done

s3 -us list publicbucket

$HOME/scripts/get_bucket_acl.sh publicbucket

$CEPH_BIN/radosgw-admin bucket reshard --bucket=publicbucket --num-shards=10

$HOME/scripts/get_bucket_acl.sh publicbucket

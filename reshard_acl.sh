#!/bin/bash

CEPH_BIN=/home/owasserm/ceph/build/bin

s3 -us  create publicbucket cannedAcl=public-read-write

for i in {1..10}; do curl -X PUT http://localhost:8000/publicbucket/obj$i -d "@null" -s; done

s3 -us list publicbucket

s3 -us getacl publicbucket filename=publicbucket.acl

cat publicbucket.acl

$CEPH_BIN/radosgw-admin bucket reshard --bucket=publicbucket --num-shards=10

s3 -us getacl publicbucket filename=publicbucket2.acl

cat publicbucket2.acl

#!/bin/bash

CEPH_BIN=${1:-"./bin"}

$HOME/scripts/create_versioned_bucket.py --name testbucket

$CEPH_BIN/radosgw-admin bucket reshard --bucket=testbucket --num-shards=10 
#--debug_rgw=20 --debug_ms=1

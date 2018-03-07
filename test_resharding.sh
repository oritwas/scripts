#!/bin/bash

set -e

SCRIPTS=/home/owasserm/scripts
BIN=/home/owasserm/ceph/build/bin
CONF=/home/owasserm/ceph/build/ceph.conf
function test_admin_commands()
{
    echo "testing admin command "
    BUCKET_NAME="bucket"
    echo "creating buckets"
    $SCRIPTS/create_buckets.py --num 3
    if [ $? -ne 0 ]; then
        return
    fi

    for i in 0 1 2 ; do
             echo "resharding add  bucket" $i
             $BIN/radosgw-admin reshard add --bucket bucket$i --num-shards 16 -c $CONF
             if [ $? -ne 0 ]; then
                return
             fi
             sleep 5
    done

    echo "resharding list"
    $BIN/radosgw-admin reshard list  -c $CONF
    if [ $? -ne 0 ]; then
        return
    fi

    echo "resharding execute" $BUCKET_NAME
    $BIN/radosgw-admin reshard execute --bucket $BUCKET_NAME -c $CONF
   if [ $? -ne 0 ]; then
      return
   fi
}

function test_dynamic_resharding()
{
    BUCKET_NAME="dynamic"
    i=18
    echo "creating " $i " objects " $BUCKET_NAME
    $SCRIPTS/create_objects.py  --num $i --bucket $BUCKET_NAME
    if [ $? -ne 0 ]; then
        return
    fi
    echo "resharding list" $BUCKET_NAME
    $BIN/radosgw-admin reshard list -c $CONF
    if [ $? -ne 0 ]; then
        return
    fi
}


test_admin_commands
echo "testing dynamic resharding"
#test_dynamic_resharding
echo "done"

exit

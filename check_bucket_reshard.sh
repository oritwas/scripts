#!/bin/bash -x

bin="/home/owasserm/ceph/build/bin"
s3="/home/owasserm/libs3/build/bin/s3 -u"


#export S3_ACCESS_KEY_ID=
#export S3_SECRET_ACCESS_KEY=
#export S3_HOSTNAME=

function usage
{
    echo "usage: $0 <bucket-name> <num-shards>"
}

function create_bucket
{
    [ $# -ne 1 ] && echo "create_bucket needs 1 params" && exit 1
    bucket_name=$1
    $s3 create $bucket_name
}

function list_bucket
{
    [ $# -ne 1 ] && echo "list_bucket needs 1 params" && exit 1
    bucket_name=$1
    $s3 list $bucket_name
}

function create_obj
{
    [ $# -ne 2 ] && echo "create_obj needs 2 params" && exit 1
    bucket_name=$1
    obj_name=$2
    file_name=$0
    $s3 put $bucket_name/$obj_name filename=$file_name
}


function create_objs
{
    [ $# -ne 2 ] && echo "create_objs needs 2 params" && exit 1
    bucket_name=$1
    num_objs=$2
    for i in `seq 0 $((num_objs-1))`; do
	create_obj $bucket_name obj$i
    done
}

function delete_obj
{
    [ $# -ne 2 ] && echo "delete_obj needs 2 params" && exit 1
    bucket_name=$1
    obj_name=$2
    file_name=$0
    $s3 delete $bucket_name/$obj_name
}

function reshard_bucket
{
    [ $# -ne 2 ] && echo "reshard_bucket needs 2 params" && exit 1
   $BIN/radosgw-admin bucket online-reshard --bucket $bucket_name --num-shard $num_shards     
}

[ $# -ne 2 ] && echo "check_reshard_bucket needs 2 params" && exit 1

bucket="mybucket"
create_bucket $bucket
create_objs $bucket 5
list_bucket $bucket

echo "resharding bucket to 2 shards"
reshard_bucket $bucket 2

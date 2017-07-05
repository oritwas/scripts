#!/bin/bash

bucket_name="bucket1"
s3cmd ls -r s3://$bucket_name/ | awk '{print $4}' | sed -e s,s3://$bucket_name/,,g > obj_list.out

for i in `cat obj_list.out` ; do
./radosgw-admin object unlink --bucket $bucket_name --object $i ;
done



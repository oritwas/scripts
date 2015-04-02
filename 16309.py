#!/usr/bin/env python
import boto
import boto.s3.connection
import os
aws_access_key=os.environ['S3_ACCESS_KEY_ID']
aws_secret_key=os.environ['S3_SECRET_ACCESS_KEY']
bucket_name="bucket1"
port=8000
# Connect to s3.
conn = boto.connect_s3(aws_access_key_id = aws_access_key,
                       aws_secret_access_key = aws_secret_key,
                       host = 'localhost',
                       port = port,
                       is_secure = False,
                       calling_format = boto.s3.connection.OrdinaryCallingFormat())
# Create bucket.
bucket = conn.create_bucket(bucket_name)

num_objs = 100
# create object on non versioned bucket
for i in range(1, num_objs):
    obj = boto.s3.key.Key(bucket)
    obj.key = 'obj'+ `i`
    obj.set_contents_from_string('Non versioned')

print bucket
print 'list objects'
for k in bucket.get_all_keys(max_keys = 5):
    print k
for version in bucket.list_versions():
    print version.name + ' id ' + version.version_id

# Turn on versioning for this bucket.
bucket.configure_versioning(True)

print bucket
print 'list object versioning on '
for k in bucket.get_all_keys(max_keys=5):
    print k
for version in bucket.list_versions():
    print version.name + ' id ' + version.version_id


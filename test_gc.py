#!/usr/bin/env python
import boto.exception
import boto.s3.connection
import boto.s3.acl
import argparse
import os

from boto.connection import AWSAuthConnection

s3_access_key=os.environ['S3_ACCESS_KEY_ID']
s3_secret_key=os.environ['S3_SECRET_ACCESS_KEY']

parser = argparse.ArgumentParser(description='test_copy')
parser.add_argument('--port', type=int, action='store', default=8000 )
parser.add_argument('--key',type=str, action='store', default=s3_access_key)
parser.add_argument('--secret',type=str, action='store', default=s3_secret_key)
parser.add_argument('--num', type=int, action='store', default=100 )
parser.add_argument('--bucket', type=str, action='store', default='bucket1' )
args = parser.parse_args()

s3_conn = boto.connect_s3(
    aws_access_key_id=args.key,
    aws_secret_access_key=args.secret,
    host='localhost',
    port=args.port,
    is_secure=False,
    calling_format=boto.s3.connection.OrdinaryCallingFormat(),
)

print 'creating bucket'
bucket = s3_conn.create_bucket(args.bucket)

# create an object large enough to be split into multiple parts
test_string = 'foo'*10000000

keys_to_delete = []
for i in range(args.num):
    print 'creating obj'+ `i`
    obj = boto.s3.key.Key(bucket)
    obj.key = 'obj' + `i`
    obj.set_contents_from_string(test_string)
    keys_to_delete.append(obj.key)

print 'list objects'
i = 0
for k in bucket.list():
    print 'obj ' + `i`
    print k
    i = i + 1

result = bucket.delete_keys(keys_to_delete)
print result

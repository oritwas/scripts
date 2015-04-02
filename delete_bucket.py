#!/usr/bin/env python
import boto.exception
import boto.s3.connection
import boto.s3.acl
from nose.tools import eq_ as eq
import argparse
import os
from boto.connection import AWSAuthConnection

s3_access_key=os.environ['S3_ACCESS_KEY_ID']
s3_secret_key=os.environ['S3_SECRET_ACCESS_KEY']

parser = argparse.ArgumentParser(description='delete bucket')
parser.add_argument('--name', type=str, action='store', default='bucket0' )
parser.add_argument('--port', type=int, action='store', default=8000 )
parser.add_argument('--key',type=str, action='store', default=s3_access_key)
parser.add_argument('--secret',type=str, action='store', default=s3_secret_key)
args = parser.parse_args()

connection = boto.s3.connection.S3Connection(
    aws_access_key_id= args.key,
    aws_secret_access_key=args.secret,
    is_secure=False,
    port=args.port,
    host='localhost',
    calling_format=boto.s3.connection.OrdinaryCallingFormat(),
)


bucket = connection.get_bucket(args.name)
print 'deleting bucket: ' + args.name
for k in bucket.list():
    print k
    bucket.delete_key(k)

for version in bucket.list_versions():
    print 'delete ' + version.name + ' id ' + version.version_id
    bucket.delete_key(version.name, version_id = version.version_id)
        
print 'delete bucket ' + bucket.name
connection.delete_bucket(bucket)


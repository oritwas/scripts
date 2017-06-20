#!/usr/bin/env python
import boto.exception
import boto.s3.connection
import boto.s3.acl
import argparse
import os

from boto.connection import AWSAuthConnection

parser = argparse.ArgumentParser(description='create objects')
parser.add_argument('--num', type=int, action='store', default=100 )
parser.add_argument('--bucket', type=str, action='store', default='bucket1' )
parser.add_argument('--host', type=str, action='store', default='127.0.0.1' )
parser.add_argument('--port', type=int, action='store', default=8000 )

args = parser.parse_args()

s3_access_key=os.environ['S3_ACCESS_KEY_ID']
s3_secret_key=os.environ['S3_SECRET_ACCESS_KEY']

connection = boto.s3.connection.S3Connection(
    aws_access_key_id=s3_access_key,
    aws_secret_access_key=s3_secret_key,
    is_secure=False,
    port=args.port,
    host=args.host,
    calling_format=boto.s3.connection.OrdinaryCallingFormat(),
)

print 'create a bucket'
bucket = connection.create_bucket(args.bucket)

for i in range(args.num):
    print 'creating obj'+ `i`
    obj = boto.s3.key.Key(bucket)
    obj.key = 'obj' + `i`
    obj.set_contents_from_string('This is a test of S3')

print 'list objects'
i = 0
for k in bucket.list():
    print 'obj ' + `i`
    print k
    i = i + 1

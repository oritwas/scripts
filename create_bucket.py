#!/usr/bin/env python
import boto.exception
import boto.s3.connection
import boto.s3.acl
import argparse
import os

from boto.connection import AWSAuthConnection

parser = argparse.ArgumentParser(description='create buckets')
parser.add_argument('--name', type=str, action='store', default='bucket')
args = parser.parse_args()

s3_access_key=os.environ['S3_ACCESS_KEY_ID']
s3_secret_key=os.environ['S3_SECRET_ACCESS_KEY']
 
connection = boto.s3.connection.S3Connection(
    aws_access_key_id= s3_access_key,
    aws_secret_access_key=s3_secret_key,
    is_secure=False,
    port=8000,
    host='localhost',
    calling_format=boto.s3.connection.OrdinaryCallingFormat(),
)

print 'create a bucket'
bucket = connection.create_bucket(args.name)

obj1 = boto.s3.key.Key(bucket)
obj1.key = 'foo'
obj1.set_contents_from_string('This is a test of S3')

obj2 = boto.s3.key.Key(bucket)
obj2.key='abc'
obj2.delete()

b = connection.get_bucket(args.name)
print 'bucket list'
for k in b.list():
    print k

print "second time"
for k in b.list():
    print k
    bucket.delete_key(k)

connection.delete_bucket(bucket)

#bucket2 = connection.create_bucket('_bucket2')
 

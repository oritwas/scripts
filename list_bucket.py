#!/usr/bin/env python
import boto.exception
import boto.s3.connection
import boto.s3.acl
import argparse
import os

from boto.connection import AWSAuthConnection

parser = argparse.ArgumentParser(description='list buckets')
parser.add_argument('--host', type=str, action='store', default='localhost')
parser.add_argument('--port', type=int, action='store', default=8000)

args = parser.parse_args()

s3_access_key=os.environ['S3_ACCESS_KEY_ID']
s3_secret_key=os.environ['S3_SECRET_ACCESS_KEY']

s3_connection = boto.s3.connection.S3Connection(
    aws_access_key_id= s3_access_key,
    aws_secret_access_key=s3_secret_key,
    is_secure=False,
    port=args.port,
    host=args.host,
    calling_format=boto.s3.connection.OrdinaryCallingFormat(),
)
print 'buckets:'
for bucket in s3_connection.get_all_buckets():
    print "{name}\t{created}".format(
        name = bucket.name,
        created = bucket.creation_date,
    )

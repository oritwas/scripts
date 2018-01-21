#!/usr/bin/env python
import boto.exception
import boto.s3.connection
import boto.s3.acl
import argparse
import os

from boto.connection import AWSAuthConnection

s3_access_key=os.environ['S3_ACCESS_KEY_ID']
s3_secret_key=os.environ['S3_SECRET_ACCESS_KEY']

parser = argparse.ArgumentParser(description='create buckets')
parser.add_argument('--name', type=int, action='store', default="ver_bucket1" )
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


print 'creating '+ args.name
bucket = connection.create_bucket(args.name)
bucket.configure_versioning(True)
print bucket

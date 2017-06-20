#!/usr/bin/env python
import boto.exception
import boto.s3.connection
import boto.s3.acl
import argparse
import os

from boto.connection import AWSAuthConnection

s3_access_key=os.environ['S3_ACCESS_KEY_ID']
s3_secret_key=os.environ['S3_SECRET_ACCESS_KEY']

parser = argparse.ArgumentParser(description='s3_tenant_test')
parser.add_argument('--port', type=int, action='store', default=8000 )
parser.add_argument('--key',type=str, action='store', default=s3_access_key)
parser.add_argument('--secret',type=str, action='store', default=s3_secret_key)
parser.add_argument('--tenant',type=str, action='store', default='testx')
parser.add_argument('--bucket',type=str, action='store', default='bucket1')
args = parser.parse_args()

print "connecting"
connection = boto.s3.connection.S3Connection(
    aws_access_key_id= args.key,
    aws_secret_access_key=args.secret,
    is_secure=False,
    port=args.port,
    host="localhost",
    calling_format = boto.s3.connection.OrdinaryCallingFormat())

print "bucket " + args.bucket + " tenant " + args.tenant
bucket = connection.create_bucket(args.tenant + ":" + args.bucket)
print bucket

bucket = connection.get_bucket(args.tenant + ":" + args.bucket)

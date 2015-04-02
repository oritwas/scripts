#!/usr/bin/env python
import boto.exception
import boto.s3.connection
import boto.s3.acl
import argparse
import os

from boto.connection import AWSAuthConnection

parser = argparse.ArgumentParser(description='create buckets')
parser.add_argument('--name', type=str, action='store', default='bucket1' )

args = parser.parse_args()

s3_access_key=os.environ['SWIFT_KEY']
s3_secret_key=os.environ['SWIFT_SECRET']
    
connection = boto.s3.connection.S3Connection(
    aws_access_key_id= access_key,
    aws_secret_access_key=secret_key,
    is_secure=False,
    port=8000,
    host='localhost',
    calling_format=boto.s3.connection.OrdinaryCallingFormat(),
)

bucket = connection.create_bucket(args.name)


#!/usr/bin/env python
# -*- coding: utf-8 -*
import boto
import boto.s3.connection
import argparse

parser = argparse.ArgumentParser(description='list keys')
parser.add_argument('--host', type=str, action='store', default='localhost')
parser.add_argument('--port', type=int, action='store', default=8000)
parser.add_argument('--name', type=str, action='store', default='bucket1')
args = parser.parse_args()

aws_access_key=os.environ['S3_ACCESS_KEY_ID']
aws_secret_key=os.environ['S3_SECRET_ACCESS_KEY']
# Connect to s3.
conn = boto.connect_s3(aws_access_key_id = aws_access_key,
                       aws_secret_access_key = aws_secret_key,
                       host = args.host,
                       port = args.port,
                       is_secure = False,
                       calling_format = boto.s3.connection.OrdinaryCallingFormat())
# Create bucket.
bucket = conn.get_bucket(args.name)

print bucket

print 'list objects'
for k in bucket.list():
    print k
for version in bucket.list_versions():
    print version.name + ' id ' + version.version_id
    

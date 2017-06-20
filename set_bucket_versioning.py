#!/usr/bin/env python
import boto
import boto.s3.connection
import argparse
import os

s3_access_key=os.environ['S3_ACCESS_KEY_ID']
s3_secret_key=os.environ['S3_SECRET_ACCESS_KEY']

parser = argparse.ArgumentParser(description='set_versioning')
parser.add_argument('--name', type=str, action='store', default='bucket0')
parser.add_argument('--port', type=int, action='store', default=8000 )
parser.add_argument('--key',type=str, action='store', default=s3_access_key)
parser.add_argument('--secret',type=str, action='store', default=s3_secret_key)
args = parser.parse_args()

# Connect to s3.
conn = boto.connect_s3(aws_access_key_id = args.key,
                       aws_secret_access_key = args.secret,
                       host = 'localhost',
                       port = args.port,
                       is_secure = False,
                       calling_format = boto.s3.connection.OrdinaryCallingFormat())
# Create bucket.
bucket = conn.create_bucket(args.name)
print bucket
print bucket.get_versioning_status()

bucket.configure_versioning(True)

print bucket
print bucket.get_versioning_status()

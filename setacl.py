#!/usr/bin/env python
import boto.exception
import boto.s3.connection
import boto.s3.acl
import argparse
import os

s3_access_key=os.environ['S3_ACCESS_KEY_ID']
s3_secret_key=os.environ['S3_SECRET_ACCESS_KEY']

parser = argparse.ArgumentParser(description='set bucket acl')
parser.add_argument('--port', type=int, action='store', default=8000 )
parser.add_argument('--host', type=str, action='store', default='localhost')
parser.add_argument('--name', type=str, action='store', default='mybucket')
parser.add_argument('--key',type=str, action='store', default=s3_access_key)
parser.add_argument('--secret',type=str, action='store', default=s3_secret_key)
parser.add_argument('--filename',type=str, action='store', default='acl')

args = parser.parse_args()

connection = boto.s3.connection.S3Connection(
    aws_access_key_id= args.key,
    aws_secret_access_key= args.secret,
    is_secure=False,
    port=args.port,
    host=args.host,
    calling_format=boto.s3.connection.OrdinaryCallingFormat(),
)

f = open(args.filename, 'r')
acl = f.read()

print acl

bucket = connection.get_bucket(args.name)
bucket.set_xml_acl(acl)
result = bucket.get_acl()
print result
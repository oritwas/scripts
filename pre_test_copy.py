#!/usr/bin/env python
# -*- coding: utf-8 -*
# cc.py
import time
import boto
import boto.s3.connection
import argparse


s3_access_key=os.environ['S3_ACCESS_KEY_ID']
s3_secret_key=os.environ['S3_SECRET_ACCESS_KEY']

parser = argparse.ArgumentParser(description='pre_copy_test')
parser.add_argument('--port', type=int, action='store', default=8000 )
parser.add_argument('--key',type=str, action='store', default=s3_access_key)
parser.add_argument('--secret',type=str, action='store', default=s3_secret_key)
args = parser.parse_args()

s3_conn = boto.connect_s3(
        aws_access_key_id=s3_access_key,
        aws_secret_access_key=s3_secret_key,
        host='localhost',
        port=args.port,
        is_secure=False,
        calling_format=boto.s3.connection.OrdinaryCallingFormat(),
        )

# create bucket
bucket_name = 'testbucket'
bucket = s3_conn.create_bucket(bucket_name)
print bucket

s_obj_name = 'zzzzzzzzzzzzz'
obj = boto.s3.key.Key(bucket)
obj.key = s_obj_name
obj.set_contents_from_filename('/home/owasserm/Downloads/rh-presentation-template-dark-072815.otp')

print obj

bucket_name = 'testbucket_ver'
bucket = s3_conn.create_bucket(bucket_name)
print bucket
bucket.configure_versioning(True)

s_obj_name = 'zzzzzzzzzzzzz'
obj = boto.s3.key.Key(bucket)
obj.key = s_obj_name
obj.set_contents_from_filename('/home/owasserm/Downloads/rh-presentation-template-dark-072815.otp')

print obj
for version in bucket.list_versions():
    print version.name + ' id ' + version.version_id
    
bucket = s3_conn.create_bucket('dest_bucket_ver')
print bucket
bucket.configure_versioning(True)

bucket = s3_conn.create_bucket('dest_bucket')
print bucket

    

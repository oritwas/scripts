#!/usr/bin/env python

import boto.exception
import boto.s3.connection
import boto.s3.acl

from boto.connection import AWSAuthConnection

s3_access_key=os.environ['S3_ACCESS_KEY_ID']
s3_secret_key=os.environ['S3_SECRET_ACCESS_KEY']
    
conn = boto.s3.connection.S3Connection(
    aws_access_key_id= s3_access_key,
    aws_secret_access_key= s3_secret_key,
    is_secure=False,
    port=8000,
    host='localhost',
    calling_format=boto.s3.connection.OrdinaryCallingFormat(),
)

print 'creating bucket'
bucket = conn.create_bucket('for_1372346')
print 'creating new key'
key = bucket.new_key('_temp2_')
print 'set content'
key.set_contents_from_filename('tempfile')
for k in bucket.list():
    print k

print 'set acl _temp2_'
key.set_acl('private')

print 'set canned acl'
key.set_canned_acl('private')

#!/usr/bin/env python
import boto
import boto.s3.connection
import os

aws_access_key=os.environ['S3_ACCESS_KEY_ID']
aws_secret_key=os.environ['S3_SECRET_ACCESS_KEY']
bucket_name="bucket1"

conn = boto.connect_s3(aws_access_key_id = aws_access_key,
                       aws_secret_access_key = aws_secret_key,
                       host = 'localhost',
                       port = 8000,
                       is_secure = False,
                       calling_format = boto.s3.connection.OrdinaryCallingFormat(),
                       debug=2)

bucket = conn.create_bucket(bucket_name)
obj = boto.s3.key.Key(bucket)
obj.key = 'mykey'
obj.set_contents_from_string('')

obj.key = 'mykey2'
obj.set_contents_from_string('12345678901234567890')

for k in bucket.list():
    print k

key = bucket.lookup('mykey')
your_bytes = key.get_contents_as_string(headers={'Range' : 'bytes=0-1024'})
print your_bytes
key = bucket.lookup('mykey2')
your_bytes = key.get_contents_as_string(headers={'Range' : 'bytes=0-2'})
print your_bytes

#!/usr/bin/env python
import boto
import boto.s3.connection

aws_access_key=os.environ['S3_ACCESS_KEY_ID']
aws_secret_key=os.environ['S3_SECRET_ACCESS_KEY']
bucket_name="bucket1"
port=8000
# Connect to s3.
conn = boto.connect_s3(aws_access_key_id = aws_access_key,
                       aws_secret_access_key = aws_secret_key,
                       host = 'localhost',
                       port = port,
                       is_secure = False,
                       calling_format = boto.s3.connection.OrdinaryCallingFormat())
# Create bucket.
bucket = conn.create_bucket(bucket_name)

num_objs = 2500
# create object on non versioned bucket
for i in range(0, num_objs):
    obj = boto.s3.key.Key(bucket)
    obj.key = 'testfile'+ `i` + '.txt'
    obj.set_contents_from_string(obj.key)

print bucket

print 'list objects'
i = 0
for k in bucket.list():
    print 'obj ' + `i`
    print k
    i = i + 1


# Turn on versioning for this bucket.
bucket.configure_versioning(True)
bucket.configure_versioning(True)

print bucket

for i in range(0, num_objs):
    obj = boto.s3.key.Key(bucket)
    obj.key = 'testfile'+ `i` + '.txt'
    obj.set_contents_from_string('overwrite ' + obj.key)
    print 'overwrite ' + obj.key

print 'list object versioning on '
i = 0
for k in bucket.list():
    print 'obj ' + `i`
    print k
    i = i + 1

for i in range(0, num_objs):
    obj = boto.s3.key.Key(bucket)
    obj.key = 'testfile'+ `i` + '.txt'
    obj.set_contents_from_string('overwrite2' + obj.key)
    print 'overwrite2 ' + obj.key

print 'list object versioning on '
i = 0
for k in bucket.list():
    print 'obj ' + `i`
    print k
    i = i + 1

for i in range(2000, num_objs):
    obj = boto.s3.key.Key(bucket)
    obj.key = 'testfile'+ `i` + '.txt'
    obj.set_contents_from_string('overwrite3' + obj.key)
    print 'overwrite3 ' + obj.key

print 'list object versioning on 's
i = 0
for k in bucket.list():
    print 'obj ' + `i`
    print k
    i = i + 1
    

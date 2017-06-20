#!/usr/bin/env python
import boto
import boto.s3.connection
import argparse
import os

s3_access_key=os.environ['S3_ACCESS_KEY_ID']
s3_secret_key=os.environ['S3_SECRET_ACCESS_KEY']

parser = argparse.ArgumentParser(description='test_versioning')
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
print bucket.get_versioning_status()
num_objs=5
# create object on non versioned bucket
for i in range(1, num_objs):
    obj = boto.s3.key.Key(bucket)
    obj.key = 'obj'+ `i`
    obj.set_contents_from_string('Non versioned')

print bucket
print 'list objects'
for k in bucket.list():
    print k
for version in bucket.list_versions():
    print version.name + ' id ' + version.version_id

# Turn on versioning for this bucket.
bucket.configure_versioning(True)

print bucket
print 'list object versioning on '
for k in bucket.list():
    print k
for version in bucket.list_versions():
    print version.name + ' id ' + version.version_id

# create object on non versioned bucket
obj2 = boto.s3.key.Key(bucket)
obj2.key = 'obj2'
obj2.set_contents_from_string('versioned')

print bucket
print 'list objects'
for k in bucket.list():
    print k
for version in bucket.list_versions():
    print version.name + ' id ' + version.version_id

for i in range(1, num_objs):
    obj = boto.s3.key.Key(bucket)
    obj.key = 'obj'+ `i`
    obj.set_contents_from_string('versioned')

print bucket
print 'list objects'
for k in bucket.list():
    print k
for version in bucket.list_versions():
    print version.name + ' id ' + version.version_id

for i in range(1, num_objs):
    obj = boto.s3.key.Key(bucket)
    obj.key = 'obj'+ `i`
    obj.set_contents_from_file('/home/owasserm/ceph/build/bin/radosgw')

print bucket
print 'list objects'
for k in bucket.list():
    print k
for version in bucket.list_versions():
    print version.name + ' id ' + version.version_id

bucket.configure_versioning(False)

print bucket
print 'list object versioning off'
for k in bucket.list():
    print k
for version in bucket.list_versions():
    print version.name + ' id ' + version.version_id


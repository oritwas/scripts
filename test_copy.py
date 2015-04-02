#!/usr/bin/env python
# -*- coding: utf-8 -*
import time
import boto
import boto.s3.connection
import os
import argparse

#!/usr/bin/env python
# -*- coding: utf-8 -*
import time
import boto
import boto.s3.connection
import string
import random
import argparse
from cStringIO import StringIO
from nose.tools import eq_ as eq
    
    
if __name__ == "__main__":
    s3_access_key=os.environ['S3_ACCESS_KEY_ID']
    s3_secret_key=os.environ['S3_SECRET_ACCESS_KEY']

    parser = argparse.ArgumentParser(description='test_copy')
    parser.add_argument('--port', type=int, action='store', default=8000 )
    parser.add_argument('--key',type=str, action='store', default=s3_access_key)
    parser.add_argument('--secret',type=str, action='store', default=s3_secret_key)
    parser.add_argument('--version',type=str, action='store')
    args = parser.parse_args()

    s3_conn = boto.connect_s3(
        aws_access_key_id=s3_access_key,
        aws_secret_access_key=s3_secret_key,
        host='localhost',
        port=args.port,
        is_secure=False,
        calling_format=boto.s3.connection.OrdinaryCallingFormat(),
    )

    bucket = s3_conn.create_bucket('src_bucket')
    bucket.configure_versioning(True)
    print bucket
    
    key = bucket.new_key('foo123bar')
    key.set_metadata('foo', 'bar')
    size = 1*1024*1024
    data = str(bytearray(size))
    key.set_contents_from_string(data)
    print key
        
    # copy object in the same bucket
    key2 = bucket.copy_key('bar321foo', bucket.name, key.name, src_version_id = key.version_id)
    key2 = bucket.get_key(key2.name)
    print key2
    eq(key2.size, size)
    got = key2.get_contents_as_string()
    eq(got, data)
    eq(key2.metadata['foo'], 'bar')


    # second copy
    key3 = bucket.copy_key('bar321foo2', bucket.name, key2.name, src_version_id = key2.version_id)
    key3 = bucket.get_key(key3.name)
    print key3
    eq(key3.size, size)
    got = key3.get_contents_as_string()
    eq(got, data)
    eq(key3.metadata['foo'], 'bar')

    # copy to another versioned bucket
    bucket2 = s3_conn.create_bucket('dst_bucket')
    bucket2.configure_versioning(True)
    key4 = bucket2.copy_key('bar321foo3', bucket.name, key.name, src_version_id = key.version_id)
    key4 = bucket2.get_key(key4.name)
    print key4
    eq(key4.size, size)
    got = key4.get_contents_as_string()
    eq(got, data)
    eq(key4.metadata['foo'], 'bar')

    # copy to another non versioned bucket
    bucket3 = s3_conn.create_bucket('dst_bucket_no_ver')
    key5 = bucket3.copy_key('bar321foo4', bucket.name, key.name , src_version_id = key.version_id)
    key5 = bucket3.get_key(key5.name)
    print key5
    eq(key5.size, size)
    got = key5.get_contents_as_string()
    eq(got, data)
    eq(key5.metadata['foo'], 'bar')

    # copy from a non versioned bucket
    key6 = bucket.copy_key('foo123bar2', bucket3.name, key5.name)
    key6 = bucket.get_key(key6.name)
    eq(key6.size, size)
    got = key6.get_contents_as_string()
    eq(got, data)
    eq(key6.metadata['foo'], 'bar')


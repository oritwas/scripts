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
import os

def transfer_part(bucket, mp_id, mp_keyname, i, part):
    """Transfer a part of a multipart upload. Designed to be run in parallel.
    """
    mp = boto.s3.multipart.MultiPartUpload(bucket)
    mp.key_name = mp_keyname
    mp.id = mp_id
    part_out = StringIO(part)
    mp.upload_part_from_file(part_out, i+1)

def copy_part(src_bucket, src_keyname, dst_bucket, dst_keyname, mp_id, i, start=None, end=None):
    """Copy a part of a multipart upload from other bucket.
    """
    mp = boto.s3.multipart.MultiPartUpload(dst_bucket)
    mp.key_name = dst_keyname
    mp.id = mp_id
    mp.copy_part_from_key(src_bucket, src_keyname, i+1, start, end)
    
def generate_random(size, part_size=5*1024*1024):
    """
    Generate the specified number random data.
    (actually each MB is a repetition of the first KB)
    """
    chunk = 1024
    allowed = string.ascii_letters
    for x in range(0, size, part_size):
        strpart = ''.join([allowed[random.randint(0, len(allowed) - 1)] for _ in xrange(chunk)])
        s = ''
        left = size - x
        this_part_size = min(left, part_size)
        for y in range(this_part_size / chunk):
            s = s + strpart
        if this_part_size > len(s):
            s = s + strpart[0:this_part_size - len(s)]
        yield s
        if (x == size):
            return

def _multipart_upload(bucket, s3_key_name, size, part_size=5*1024*1024, do_list=None, headers=None, metadata=None, resend_parts=[]):
    """
    generate a multi-part upload for a random file of specifed size,
    if requested, generate a list of the parts
    return the upload descriptor
    """
    upload = bucket.initiate_multipart_upload(s3_key_name, headers=headers, metadata=metadata)
    s = ''
    for i, part in enumerate(generate_random(size, part_size)):
        s += part
        transfer_part(bucket, upload.id, upload.key_name, i, part)
        if i in resend_parts:
            transfer_part(bucket, upload.id, upload.key_name, i, part)

    if do_list is not None:
        l = bucket.list_multipart_uploads()
        l = list(l)

    return (upload, s)

    
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
    
    key_name="srcmultipart"
    content_type='text/bla'
    objlen = 30 * 1024 * 1024
    (upload, data) = _multipart_upload(bucket, key_name, objlen, headers={'Content-Type': content_type}, metadata={'foo': 'bar'})
    upload.complete_upload()
    key = bucket.get_key(key_name)
    print key
    
    # copy object in the same bucket
    print 'copy object in the same bucket'
    key2 = bucket.copy_key('dstmultipart', bucket.name, key.name, src_version_id = key.version_id)
    key2 = bucket.get_key(key2.name)
    print key2
    eq(key2.metadata['foo'], 'bar')
    eq(key2.content_type, content_type)
    eq(key2.size, key.size)
    got = key2.get_contents_as_string()
    eq(got, data)

    # second copy
    print 'second copy'
    key3 = bucket.copy_key('dstmultipart2', bucket.name, key2.name, src_version_id = key2.version_id)
    key3 = bucket.get_key(key3.name)
    print key3
    eq(key3.metadata['foo'], 'bar')
    eq(key3.content_type, content_type)
    eq(key3.size, key.size)
    got = key3.get_contents_as_string()
    eq(got, data)

    # copy to another versioned bucket
    print 'copy to another versioned bucket'
    bucket2 = s3_conn.create_bucket('dst_bucket')
    bucket2.configure_versioning(True)
    key4 = bucket2.copy_key('dstmultipart3', bucket.name, key.name, src_version_id = key.version_id)
    key4 = bucket2.get_key(key4.name)
    print key4
    eq(key4.metadata['foo'], 'bar')
    eq(key4.content_type, content_type)
    eq(key4.size, key.size)
    got = key4.get_contents_as_string()
    eq(got, data)

    # copy to another non versioned bucket
    print 'copy to another non versioned bucket'
    bucket3 = s3_conn.create_bucket('dst_bucket_no_ver')
    key5 = bucket3.copy_key('dstmultipart4', bucket.name, key.name, src_version_id = key.version_id)
    key5 = bucket3.get_key(key5.name)
    print key5
    eq(key5.metadata['foo'], 'bar')
    eq(key5.content_type, content_type)
    eq(key5.size, key.size)
    got = key5.get_contents_as_string()
    eq(got, data)

    # copy from a non versioned bucket
    print 'copy from a non versioned bucket'
    key6 = bucket.copy_key('dstmultipart5', bucket3.name, key5.name)
    key6 = bucket.get_key(key6.name)
    print key6
    print key6.metadata
    eq(key6.metadata['foo'], 'bar')
    eq(key6.content_type, content_type)
    eq(key6.size, key.size)
    got = key6.get_contents_as_string()
    eq(got, data)


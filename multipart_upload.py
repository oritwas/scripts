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
    parser.add_argument('--num', type=int, action='store', default=100 )
    parser.add_argument('--bucket', type=str, action='store', default='bucket1' )
    parser.add_argument('--size', type=int, action='store', default=5 * 1024 * 1024 )
    parser.add_argument('--obj_name', type=str, action='store', default="obj")

    args = parser.parse_args()

    s3_conn = boto.connect_s3(
        aws_access_key_id=s3_access_key,
        aws_secret_access_key=s3_secret_key,
        host='localhost',
        port=args.port,
        is_secure=False,
        calling_format=boto.s3.connection.OrdinaryCallingFormat(),
    )

    print 'creating bucket'
    bucket = s3_conn.create_bucket(args.bucket)

    content_type='text/bla'
    for i in range(args.num):
        print 'creating mulitpart obj' +`i`
        objlen = args.size
        key_name = args.obj_name + `i`
        (upload, data) = _multipart_upload(bucket, key_name, objlen, headers={'Content-Type': content_type},
                                           metadata={'foo': 'bar'})
        upload.complete_upload()
        key = bucket.get_key(key_name)
        print key

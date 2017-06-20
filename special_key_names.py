#!/usr/bin/env python
import boto.exception
import boto.s3.connection
import boto.s3.acl
import itertools
import os

from nose.tools import eq_ as eq

from boto.connection import AWSAuthConnection
from boto.s3.key import Key

bucket_counter = itertools.count(1)

def get_new_bucket_name():
    """
    Get a bucket name that probably does not exist.

    We make every attempt to use a unique random prefix, so if a
    bucket by this name happens to exist, it's ok if tests give
    false negatives.
    """
    name = '{prefix}{num}'.format(
        prefix='bucket',
        num=next(bucket_counter),
        )
    return name

def get_new_bucket(connection, name=None, headers=None):
    """
    Get a bucket that exists and is empty.

    Always recreates a bucket from scratch. This is useful to also
    reset ACLs and such.
    """
    if name is None:
        name = get_new_bucket_name()
    # the only way for this to fail with a pre-existing bucket is if
    # someone raced us between setup nuke_prefixed_buckets and here;
    # ignore that as astronomically unlikely

    return bucket

def _create_keys(connection, bucket=None, keys=[]):
    """
    Populate a (specified or new) bucket with objects with
    specified names (and contents identical to their names).
    """
    for s in keys:
        key = bucket.new_key(s)
        key.set_contents_from_string(s)

    return bucket

def check_head_obj_content(key, content):
    if content is not None:
        eq(key.get_contents_as_string(), content)
    else:
        print 'check head', key
        eq(key, None)

def check_obj_versions(bucket, objname, keys, contents):
    # check to see if object is pointing at correct version
    key = bucket.get_key(objname)

    if len(contents) > 0:
        print 'testing obj head', objname
        check_head_obj_content(key, contents[-1])
        i = len(contents)
        for key in bucket.list_versions():
            if key.name != objname:
                continue

            i -= 1
            eq(keys[i].version_id or 'null', key.version_id)
            print 'testing obj version-id=', key.version_id
            check_obj_content(key, contents[i])
    else:
        eq(key, None)

def create_multiple_versions(bucket, objname, num_versions, k = None, c = None):
    c = c or []
    k = k or []
    for i in xrange(num_versions):
        c.append('content-{i}'.format(i=i))

        key = bucket.new_key(objname)
        key.set_contents_from_string(c[i])

        if i == 0:
            bucket.configure_versioning(True)

    k_pos = len(k)
    i = 0
    for o in bucket.list_versions():
        if o.name != objname:
            continue
        i += 1
        if i > num_versions:
            break

        print o, o.version_id
        k.insert(k_pos, o)
        print 'created obj name=', objname, 'version-id=', o.version_id

    eq(len(k), len(c))

    for j in xrange(num_versions):
        print j, k[j], k[j].version_id

    check_obj_versions(bucket, objname, k, c)

    return (k, c)

def check_versioning(bucket, status):
    try:
        eq(bucket.get_versioning_status()['Versioning'], status)
    except KeyError:
        eq(status, None)

def test_bucket_create_special_key_names():

    s3_access_key=os.environ['S3_ACCESS_KEY_ID']
    s3_secret_key=os.environ['S3_SECRET_ACCESS_KEY']

    connection = boto.s3.connection.S3Connection(
        aws_access_key_id= s3_access_key,
        aws_secret_access_key=s3_secret_key,
        is_secure=False,
        port=8000,
        host='localhost',
        calling_format=boto.s3.connection.OrdinaryCallingFormat(),
        )

    bucket = connection.create_bucket('bucket1')
    key_names = [
        '_goodobj',
        '__badobj',
        '__',
        '_ _bad',
        '_a_rest',
        '_b__',
        'end_',
    ]
    bucket = _create_keys(connection, bucket=bucket, keys=key_names)
    print 'test_bucket_create_special_key_names ' + bucket.name

    b = connection.get_bucket('bucket1')
    for k in bucket.list():
        print k.name

    for k in key_names:
        obj = b.get_key(k)
        print obj

    print 'bucket ' + bucket.name + ' delete keys:'
    for k in bucket.list():
        print k
        bucket.delete_key(k)

    print 'bucket ' + bucket.name + ' version:'
    for version in bucket.list_versions():
        print 'delete ' + version.name + ' id ' + version.version_id
        bucket.delete_key(version.name, version_id = version.version_id)

    print 'delete bucket ' + bucket.name
    try:
        connection.delete_bucket(bucket)
    except boto.exception.S3ResponseError as e:
        print 'bucket ' + bucket.name + ' keys:'
        for k in bucket.list():
            print k

        print 'bucket ' + bucket.name + ' versions:'
        for version in bucket.list_versions():
            print ' key ' + version.name + ' id ' + version.version_id
        raise e

if __name__ == "__main__":
    test_bucket_create_special_key_names()

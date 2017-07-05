#!/bin/python

import boto.exception
import boto.s3.connection
import boto.s3.acl
import argparse
import os
from nose.tools import eq_ as eq

from boto.connection import AWSAuthConnection

def _create_keys(bucket_name, keys=[]):
    """
    Populate a (specified or new) bucket with objects with
    specified names (and contents identical to their names).
    """
    bucket = connection.create_bucket(bucket_name)

    for s in keys:
        key = bucket.new_key(s)
        key.set_contents_from_string(s)

    return bucket

def _get_keys_prefixes(li):
    """
    figure out which of the strings in a list are actually keys
    return lists of strings that are (keys) and are not (prefixes)
    """
    keys = [x for x in li if isinstance(x, boto.s3.key.Key)]
    prefixes = [x for x in li if not isinstance(x, boto.s3.key.Key)]
    return (keys, prefixes)


def validate_bucket_list(bucket, prefix, delimiter, marker, max_keys,
                         is_truncated, check_objs, check_prefixes, next_marker):

    print ("prefix", prefix)
    print("delimiter", delimiter)
    print("marker", marker)
    print("check_objs", check_objs)
    print("check_prefix", check_prefixes)
    print("next_marker", next_marker)

    li = bucket.get_all_keys(delimiter=delimiter, prefix=prefix, max_keys=max_keys, marker=marker)

    print ("is_truncated", li.is_truncated)
    print("next_marker", li.next_marker)
    eq(li.is_truncated, is_truncated)
    eq(li.next_marker, next_marker)

    (keys, prefixes) = _get_keys_prefixes(li)

    print ("keys", keys)
    print ("prefixes size: ",len(prefixes))
    for p in prefixes:
        print p.name

    eq(len(keys), len(check_objs))
    eq(len(prefixes), len(check_prefixes))

    objs = [e.name for e in keys]
    print("objs", objs)
    eq(objs, check_objs)

    prefix_names = [e.name for e in prefixes]
    eq(prefix_names, check_prefixes)

    return li.next_marker


def test_bucket_list_delimiter_prefix():

    bucket = _create_keys(bucket_name="prefix_bucket",keys=['asdf', 'boo/bar', 'boo/baz/xyzzy', 'cquux/thud', 'cquux/bla'])
    print("bucket list:")
    for k in bucket.list():
        print k

    delim = '/'
    marker = ''
    prefix = ''

    marker = validate_bucket_list(bucket, prefix, delim, '', 1, True, ['asdf'], [], 'asdf')
    marker = validate_bucket_list(bucket, prefix, delim, marker, 1, True, [], ['boo/'], 'boo/')
    marker = validate_bucket_list(bucket, prefix, delim, marker, 1, False, [], ['cquux/'], None)

    marker = validate_bucket_list(bucket, prefix, delim, '', 2, True, ['asdf'], ['boo/'], 'boo/')
    marker = validate_bucket_list(bucket, prefix, delim, marker, 2, False, [], ['cquux/'], None)

    prefix = 'boo/'

    marker = validate_bucket_list(bucket, prefix, delim, '', 1, True, ['boo/bar'], [], 'boo/bar')
    marker = validate_bucket_list(bucket, prefix, delim, marker, 1, False, [], ['boo/baz/'], None)

    marker = validate_bucket_list(bucket, prefix, delim, '', 2, False, ['boo/bar'], ['boo/baz/'], None)

def test_bucket_list_delimiter_prefix_under():

    bucket = _create_keys(bucket_name="under_bucket", keys=['_obj1_','_under1/bar', '_under1/baz/xyzzy', '_under2/thud', '_under2/bla'])

    print("bucket list:")
    for k in bucket.list():
        print k

    delim = '/'
    marker = ''
    prefix = ''

    marker = validate_bucket_list(bucket, prefix, delim, '', 1, True, ['_obj1_'], [], '_obj1_')
    marker = validate_bucket_list(bucket, prefix, delim, marker, 1, True, [], ['_under1/'], '_under1/')
    marker = validate_bucket_list(bucket, prefix, delim, marker, 1, False, [], ['_under2/'], None)

    marker = validate_bucket_list(bucket, prefix, delim, '', 2, True, ['_obj1_'], ['_under1/'], '_under1/')
    marker = validate_bucket_list(bucket, prefix, delim, marker, 2, False, [], ['_under2/'], None)

    prefix = '_under1/'

    marker = validate_bucket_list(bucket, prefix, delim, '', 1, True, ['_under1/bar'], [], '_under1/bar')
    marker = validate_bucket_list(bucket, prefix, delim, marker, 1, False, [], ['_under1/baz/'], None)

    marker = validate_bucket_list(bucket, prefix, delim, '', 2, False, ['_under1/bar'], ['_under1/baz/'], None)


print "test_bucket_list_prefix"


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

test_bucket_list_delimiter_prefix()


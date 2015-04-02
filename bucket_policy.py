#!/usr/bin/env python
import subprocess
import os
import boto.exception
import boto.s3.connection
import boto.s3.acl

from boto.connection import AWSAuthConnection
from cStringIO import StringIO

def get_acl(key):
    """
    Helper function to get the xml acl from a key, ensuring that the xml
    version tag is removed from the acl response
    """
    raw_acl = key.get_xml_acl()

    def remove_version(string):
        return string.split(
            '<?xml version="1.0" encoding="UTF-8"?>'
        )[-1]

    def remove_newlines(string):
        return string.strip('\n')

    return remove_version(
        remove_newlines(raw_acl)
    )

def rgwadmin(cmd, stdin=StringIO(), check_status=False,
             format='json'):
    print 'rgwadmin: ' ,cmd
    testdir = '.'
    pre = [
        './bin/radosgw-admin',
        '--log-to-stderr',
        '--format', format,
        ]
    pre.extend(cmd)
    print 'rgwadmin: cmd=%s' % pre
    p = subprocess.Popen(pre, stdout=subprocess.PIPE, 
                         stderr=subprocess.PIPE)
    out, err = p.communicate()
    print out
    j = None
    if not err and out != '':
        try:
            j = json.loads(out)
            log.info(' json result: %s' % j)
        except ValueError:
            j = out
            log.info(' raw result: %s' % j)
        
    return (err, out)

def test_bucket():

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

    # TESTCASE 'policy', 'bucket', 'policy', 'get bucket policy', 'returns S3 policy'
    bucket_name = 'myfoo'
    bucket = connection.create_bucket(bucket_name)

    # create an object
    key = boto.s3.key.Key(bucket)
    key.set_contents_from_string('seven')

    # should be private already but guarantee it
    key.set_acl('private')

    
    print 'key=' + key.key

    acl = get_acl(key)

    print acl

    (err, out) = rgwadmin(['policy', '--bucket', bucket.name, '--object', key.key],
        check_status=True, format='xml')

    print "rgwadmin: ", err
    print out

    assert acl == out.strip('\n')
    
if __name__ == "__main__":
    test_bucket()
    

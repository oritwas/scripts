import boto.exception
import boto.s3.connection
import boto.s3.acl
from nose.tools import eq_ as eq

from boto.connection import AWSAuthConnection

def check_versioning(bucket, status):
    try:
        eq(bucket.get_versioning_status()['Versioning'], status)
    except KeyError:
        eq(status, None)

def assert_raises(excClass, callableObj, *args, **kwargs):
    """
    Like unittest.TestCase.assertRaises, but returns the exception.
    """
    try:
        callableObj(*args, **kwargs)
    except excClass as e:
        return e
    else:
        if hasattr(excClass, '__name__'):
            excName = excClass.__name__
        else:
            excName = str(excClass)
        raise AssertionError("%s not raised" % excName)

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

    bucket_name='bucket1'
    print 'create ' + bucket_name
    bucket = connection.create_bucket(bucket_name)
    check_versioning(bucket, None)
    
    content = 'fooz'
    objname = 'testobj'
    print 'create ' + objname
    key = bucket.new_key(objname)
    key.set_contents_from_string(content)

    print 'bucket ' + bucket.name + ' list'
    for k in bucket.list():
        print k
        bucket.delete_key(k)

    for version in bucket.list_versions():
        print 'delete ' + version.name + ' id ' + version.version_id
        bucket.delete_key(version.name, version_id = version.version_id)
        
    print 'delete bucket ' + bucket.name
    connection.delete_bucket(bucket)

    bucket_name='bucket2'
    print 'create ' + bucket_name
    bucket = connection.create_bucket(bucket_name)
    bucket.configure_versioning(False)
    check_versioning(bucket, 'Suspended')
            
    content = 'fooz'
    objname = 'testobj'
    print 'create ' + objname
    key = bucket.new_key(objname)
    key.set_contents_from_string(content)

    print 'bucket ' + bucket.name + ' list'
    for k in bucket.get_all_keys():
        print k
        bucket.delete_key(k)

    print 'bucket ' + bucket.name + ' list of key after delete'
    for k in bucket.get_all_keys():
        print k

    for version in bucket.list_versions():
        print 'delete ' + version.name + ' id ' + version.version_id
        bucket.delete_key(version.name, version_id = version.version_id)

    print 'delete bucket ' + bucket.name
    connection.delete_bucket(bucket)

    bucket_name='bucket3'
    print 'create ' + bucket_name
    bucket = connection.create_bucket(bucket_name)
    bucket.configure_versioning(True)
    check_versioning(bucket, 'Enabled')
    
    content = 'fooz'
    objname = 'testobj'
    print 'create ' + objname
    key = bucket.new_key(objname)
    key.set_contents_from_string(content)

    print 'bucket ' + bucket.name + ' list'
    for k in bucket.list():
        print k
        bucket.delete_key(k)

    for version in bucket.list_versions():
        print 'delete ' + version.name + ' id ' + version.version_id
        bucket.delete_key(version.name, version_id = version.version_id)

    print 'delete bucket ' + bucket.name
    connection.delete_bucket(bucket)

    bucket_name = 'bucket4'
    print 'create ' + bucket_name
    bucket = connection.create_bucket(bucket_name)
    
    content = 'fooz'
    objname = 'testobj'
    print 'create ' + objname
    key = bucket.new_key(objname)
    key.set_contents_from_string(content)

    bucket.configure_versioning(True)
    
    print 'bucket ' + bucket.name + ' list'
    for k in bucket.list():
        print k
        bucket.delete_key(k)

    for version in bucket.list_versions():
        print 'delete ' + version.name + ' id ' + version.version_id
        bucket.delete_key(version.name, version_id = version.version_id)

    print 'delete bucket ' + bucket.name
    connection.delete_bucket(bucket)

    bucket_name = 'bucket5'
    print 'create ' + bucket_name
    bucket = connection.create_bucket(bucket_name)
    
    content = 'fooz'
    objname = 'testobj'
    print 'create ' + objname
    key = bucket.new_key(objname)
    key.set_contents_from_string(content)

    bucket.configure_versioning(True)
    bucket.configure_versioning(False)
    check_versioning(bucket, 'Suspended')
    
    print 'bucket ' + bucket.name + ' list'
    for k in bucket.list():
        print k
        bucket.delete_key(k)

    for version in bucket.list_versions():
        print 'delete ' + version.name + ' id ' + version.version_id
        bucket.delete_key(version.name, version_id = version.version_id)

    print 'delete bucket ' + bucket.name
    connection.delete_bucket(bucket)

           
if __name__ == "__main__":
    test_bucket()

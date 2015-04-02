import boto.exception
import boto.s3.connection
import boto.s3.acl
import os
from boto.connection import AWSAuthConnection

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

    print 'create a bucket'
    bucket = connection.create_bucket('bucket1')

    keys = ['mykey1', 'mykey2', 'mykey3', 'mykey4', 'obj1']
    keys_to_delete = ['obj1']

    for key in keys:
        obj = boto.s3.key.Key(bucket)
        obj.key = key
        obj.set_contents_from_string('This is ' + key)

    print 'bucket content:'
    for k in bucket.list():
        print k

    for o in bucket.list(prefix='obj'):
        print(o.key)                                             
        
    result = bucket.delete_keys(keys_to_delete)
    print result

    for o in bucket.list(prefix='obj'):
        print(o.key)

    print 'after delete_keys'
    for k in bucket.list():
        print k
    
    for k in bucket.list():
        bucket.delete_key(k)
    
    connection.delete_bucket(bucket)
        
           
if __name__ == "__main__":
    test_bucket()

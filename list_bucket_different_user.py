import boto.exception
import boto.s3.connection
import boto.s3.acl
import os

from boto.connection import AWSAuthConnection

def test_bucket():

    client_access_key=os.environ['S3_ACCESS_KEY_ID']
    client_secret_key=os.environ['S3_SECRET_ACCESS_KEY']
    
    client_connection = boto.s3.connection.S3Connection(
        aws_access_key_id= client_access_key,
        aws_secret_access_key=client_secret_key,
        is_secure=False,
        port=8000,
        host='localhost',
        calling_format=boto.s3.connection.OrdinaryCallingFormat(),
        )

    bucket = client_connection.create_bucket('my_bucket')
    for k in bucket.list():
        print k

    print 'client buckets'
    for b in client_connection.get_all_buckets():
        print "{name}\t{created}".format(
                name = b.name,
                created = b.creation_date,
        )

    old_bucket = client_connection.create_bucket('bucket1')
    for k in old_bucket.list():
        print k
    
if __name__ == "__main__":
    test_bucket()

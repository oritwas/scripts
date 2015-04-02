import boto
import boto.s3
import boto.s3.connection

aws3_access_key=os.environ['S3_ACCESS_KEY_ID']
aws_secret_key=os.environ['S3_SECRET_ACCESS_KEY']
bucket_name="bucket1"
port=8000
# Connect to s3.
conn = boto.connect_s3(aws_access_key_id = aws_access_key,
                       aws_secret_access_key = aws_secret_key,
                       host = 'localhost',
                       port = port,
                       is_secure = False,
                       calling_format = boto.s3.connection.OrdinaryCallingFormat())
# Create bucket.
bucket = conn.create_bucket(bucket_name)


for i in range(0,4):
    key_names[i] = 'foo' + str(i)
    obj = boto.s3.key.Key(bucket)
    obj.key = key_names[i]
    obj.set_contents_from_string('This is a test of S3 version ' + str(i))
    
result = bucket.delete_keys(keys_name)

for key in key_names:
    key = bucket.get_key(key);
    print key

    
print 'bucket list'
for k in b.list():
    print k
    

#!/bin/bash

FILE=file.jpg
BUCKET=bucket-10001b
FOLDER=_testing0001b


/usr/bin/s3cmd --host=http://localhost:8000 --access_key=$S3_ACCESS_KEY_ID --secret_key=$S3_SECRET_ACCESS_KEY mb s3://$BUCKET 

/usr/bin/s3cmd --access_key=$S3_ACCESS_KEY_ID --secret_key=$S3_SECRET_ACCESS_KEY sync $FILE  s3://$BUCKET/$FOLDER/file.jpg 

/usr/bin/s3cmd --access_key=$S3_ACCESS_KEY_ID --secret_key=$S3_SECRET_ACCESS_KEYls s3://$BUCKET/

/usr/bin/s3cmd --access_key=$S3_ACCESS_KEY_ID --secret_key=$S3_SECRET_ACCESS_KEY ls s3://$BUCKET/$DIR/

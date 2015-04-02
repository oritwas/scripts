#!/bin/bash
source "s3-common-functions"

awsAccessKeyId=$S3_ACCESS_KEY_ID
awsAccessSecretKeyIdFile="secret.file"
echo $S3_SECRET_ACCESS_KEY > $awsAccessSecretKeyIdFile
protocol="http"
bucket="s3bucket"
url="127.0.0.1:8000/${bucket}"

readonly authorizationHeader="$(computeAwsAuthorizationHeader)"
echo $authorizationHeader
     

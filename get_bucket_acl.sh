#!/bin/bash

s3 -us getacl $1 filename=publicbucket.acl

cat publicbucket.acl

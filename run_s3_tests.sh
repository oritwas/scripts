conf=${1:-"skinny.conf"}
cd $HOME/ceph/s3-tests/

S3TEST_CONF=$HOME/ceph/s3-tests/$conf $HOME/ceph/s3-tests/virtualenv/bin/nosetests --debug=DEBUG s3tests -v -a '!fails_on_rgw' 

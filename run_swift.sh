SWIFT_CONF=${1:-"$HOME//ceph/swift/test.conf"}
echo $SWIFT_CONF
cd $HOME/ceph/swift/
export SWIFT_TEST_CONFIG_FILE=$SWIFT_CONF
virtualenv/bin/nosetests test/functional --exe -v -a '!fails_on_rgw' 2>&1 | tee lll

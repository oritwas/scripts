CEPH_BIN=${1:-"./bin"}

#RGW_ZONE=--rgw-zone=zone1
$CEPH_BIN/radosgw-admin user create --subuser=tester1:tester1 --display-name=Tester1 --secret=asdf --key-type=swift $RGW_ZONE
$CEPH_BIN//radosgw-admin key create --uid=tester1 --key-type=s3 --access-key=$SWIFT_ACCESS_KEY --secret=$SWIFT_SECRET $RGW_ZONE
$CEPH_BIN//radosgw-admin subuser create --subuser=tester1:tester3 --display-name=Tester1-Subuser --secret=$SWIFT_SUBUSER_SECRET --key-type=swift $RGW_ZONE
$CEPH_BIN//radosgw-admin subuser modify --subuser=tester1:tester1 --access=full $RGW_ZONE
$CEPH_BIN//radosgw-admin user create --subuser=tester2:tester2 --display-name=Tester2 --secret=$SWIFT_SUBUSER_SECRET --key-type=swift $RGW_ZONE
 
export SWIFT_TEST_CONFIG_FILE=/home/owasserm/ceph/swift/test.conf

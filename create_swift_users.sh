CEPH_BIN=${1:-"./bin"}

#RGW_ZONE=--rgw-zone=zone1
$CEPH_BIN/radosgw-admin user create --subuser=tester1:tester1 --display-name=Tester1 --secret=asdf --key-type=swift --access=full $RGW_ZONE
$CEPH_BIN//radosgw-admin key create --uid=tester1 --key-type=s3 --access-key=$SWIFT_ACCESS_KEY --secret=$SWIFT_SECRET $RGW_ZONE
$CEPH_BIN//radosgw-admin subuser create --subuser=tester1:tester3 --display-name=Tester1-Subuser --secret=$SWIFT_SUBUSER_SECRET --key-type=swift $RGW_ZONE
$CEPH_BIN//radosgw-admin user create --subuser=tester2:tester2 --display-name=Tester2 --secret=$SWIFT_SUBUSER_SECRET --key-type=swift $RGW_ZONE
 
export SWIFT_TEST_CONFIG_FILE=/home/owasserm/ceph/swift/test.conf

$CEPH_BIN/radosgw-admin user create --tenant=tenant1 --uid=swift1 --display-name=Swift1  --key-type=swift --access=full --secret=asdf $RGW_ZONE
#$CEPH_BIN//radosgw-admin key create --tenant=tenant1 --uid=swift1 --key-type=s3 --access-key=$SWIFT_ACCESS_KEY --secret=$SWIFT_SECRET $RGW_ZONE
$CEPH_BIN//radosgw-admin subuser create --subuser='tenant1$swift1:test3' --display-name=Swift1-Subuser --secret=asfd2 --key-type=swift $RGW_ZONE
$CEPH_BIN//radosgw-admin user create --tenant=tenant2 --uid=swift2 -subuser=swift2:test2 --display-name=Swift2 --secret=asfd3 --key-type=swift $RGW_ZONE


./src/radosgw-admin realm create --rgw-realm myrealm --default

./src/radosgw-admin zonegroup create --rgw-zonegroup zg1 --master=true --endpoints "http://localhost:8000" --default

./src/radosgw-admin zone create --rgw-zone zone1 --rgw-zonegroup zg1 --master=true --endpoints "http://localhost:8000" --default

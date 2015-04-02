TOKEN=0555b35654ad1656d804
BUCKET=cont
publicURL=http://127.0.0.1:8000

#getting token
#curl -D - -H "X-Auth-User: tester1:tester1" -H "X-Auth-Key: asdf" ${publicURL}/auth 

token=AUTH_rgwtk0f000000746573746572313a74657374657231358a5852f43e7de8d73f89553cd3551ef377a4c0e716592d1d852e51125b170fbc55f0da

bucket='evgeny-test'

python ~/scripts/create_swift_bucket.py --name $bucket
swift -A $publicURL/auth/1.0 -U tester1:tester1  -K 'asdf' upload $bucket /tmp/456 /tmp/456 


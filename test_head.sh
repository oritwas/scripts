TOKEN=0555b35654ad1656d804
BUCKET=cont
publicURL=127.0.0.1:8000/swift/v1

#getting token
#curl -D - -H "X-Auth-User: tester1:tester1" -H "X-Auth-Key: asdf" ${publicURL}/auth 

token=AUTH_rgwtk0f000000746573746572313a74657374657231358a5852f43e7de8d73f89553cd3551ef377a4c0e716592d1d852e51125b170fbc55f0da
 curl -i ${publicURL}/cont -X HEAD -H "X-Auth-Token: $token"

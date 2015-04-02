publicURL="http://127.0.0.1:8000"
SCRIPTS=/home/owasserm/scripts

perl $SCRIPTS/s3curl.pl --debug  --id personal -- -i ${publicURL}/bucket1/mykey 

perl $SCRIPTS/s3curl.pl --debug  --id personal -- -i --range 0-1024 ${publicURL}/bucket1/mykey 

perl $SCRIPTS/s3curl.pl --debug --id personal -- -i ${publicURL}/bucket1/mykey2 

perl $SCRIPTS/s3curl.pl --debug --id personal -- -i --range 0-2 ${publicURL}/bucket1/mykey2 

perl $SCRIPTS/s3curl.pl --debug --id personal -- -i --range 0-1024 ${publicURL}/bucket1/mykey2 


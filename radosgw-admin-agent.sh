SRC_KEY=$SYSTEM_KEY
SRC_SECRET=$SYSTEM_SECRET
DST_KEY=$SYSTEM_KEY2
DST_SECRET=$SYSTEM_SECRET2
./radosgw-agent -v --src-access-key $SRC_KEY  --src-secret-key $SRC_SECRET --source http://localhost:7280 --dest-access-key $DST_KEY --dest-secret-key $DST_SECRET  --max-entries 1000 --log-file rgw_sync_agent.client.0.log --object-sync-timeout 30 --metadata-only --test-server-host 0.0.0.0 --test-server-port 8000 http://localhost:7281


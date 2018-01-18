#!/bin/bash -x

PORT=8000
CEPH_BIN="./bin"
rgw_name="rgw"

while [ $# -gt 0 ]; do
    case "$1" in
	-p|--port)
	    PORT="$2"
	    rgw_name=$rgw_name$2
	    ;;
	-z|--zone)
	    ZONE="--rgw-zone $2"
	    rgw_name=$rgw_name$2
	    ;;
	-b|--bin)
	    CEPH_BIN="$2"
	    ;;
	-c|--config)
	    CEPH_CONFIG="$2"
	    ;;
	-e|--extra)
	    EXTRA="$2"
	    ;;
	*)
            # unknown option
	    ;;
    esac
    shift # past argument
done

# --rgw-max-objs-per-shard=8

$CEPH_BIN/radosgw --log-file ./out/$rgw_name.log --rgw-frontends="civetweb port=$PORT" $CEPH_CONFIG --debug-rgw=20 --debug-ms=1 $ZONE $EXTRA
/home/owasserm/scripts/create_user.sh $CEPH_BIN

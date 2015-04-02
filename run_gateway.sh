
PORT=8000
CEPH_BIN="./bin"

while [ $# -gt 0 ]; do
    case "$1" in
	-p|--port)
	    PORT="$2"
	    ;;
	-z|--zone)
	    ZONE="--rgw-zone $2"
	    ;;
	-b|--bin)
	    CEPH_BIN="$2"
	    ;;
	*)
            # unknown option
	    ;;    
    esac
    shift # past argument
done

$CEPH_BIN/radosgw --log-file ./out/rgw.log --rgw-frontends="civetweb port=$PORT" --debug-rgw=20 --debug-ms=5 $ZONE

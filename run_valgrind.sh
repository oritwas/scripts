#--leak-check=full --show-leak-kinds=all

BIN=./bin/radosgw
#ZONE="--rgw-zone=zone1"
#--trace-children=yes \
#--soname-synonyms=somalloc="*tcmalloc*" \
#	--leak-check=yes \


#--child-silent-after-fork=yes \
#--leak-check=yes \
#--show-leak-kinds=all\
# --track-origins=yes 
    valgrind -v --log-file=./out/valgrind.out \
	--trace-children=no \
	--child-silent-after-fork=yes \
	--num-callers=50 \
	--time-stamp=yes \
	--tool=memcheck \
	--suppressions=/home/owasserm/ceph/src/valgrind.supp \
	$BIN --foreground --log-file ./out/rgw.log --rgw-frontends="civetweb port=8000" $ZONE  | tee ./out/rgw.client.0.stdout 2>&1
    
    #--debug-rgw=20 --debug-ms=5 

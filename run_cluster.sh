export CEPH_NUM_MON=1
export CEPH_NUM_OSD=1
export CEPH_NUM_MDS=0

if [ -n "$CEPH_DIR" ]; then
    CEPH_DIR=/home/owasserm/jewel/build/
fi

../src/mstart.sh c1 -n --short
../src/mstart.sh c2 -n --short

#start master
/home/owasserm/scripts/run_master.sh

#start second gateway
#/home/owasserm/scripts/run_second_gateway.sh 



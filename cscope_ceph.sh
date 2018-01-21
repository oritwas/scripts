#!/bin/bash

CEPH_DIR=$HOME/ceph

cd $CEPH_DIR

find  $CEPH_DIR  -type f -name "*.[chsS]" -print  > ./cscope.files
find  $CEPH_DIR -type f -name "*.hpp" -print  >>  ./cscope.files
find  $CEPH_DIR -type f -name "*.cpp" -print  >>  ./cscope.files
find  $CEPH_DIR -type f -name "*.h" -print  >> ./cscope.files
find  $CEPH_DIR -type f -name "*.cc" -print  >> ./cscope.files
find  $CEPH_DIR -type f -name "*.py" -print  >> ./cscope.files

cscope -qbk -v

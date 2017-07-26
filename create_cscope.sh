#!/bin/bash

find ./src -type f -name "*.[chsS]" -print > ./cscope.files
find  ./src -type f -name "*.cpp" -print  >>  ./cscope.files
find  ./src -type f -name "*.hpp" -print  >>  ./cscope.files
find  ./src -type f -name "*.cc" -print  >> ./cscope.files
find  ./src -type f -name "*.py" -print  >> ./cscope.files
find  ./qa -type f -name "*.[chsS]" -print >> ./cscope.files
find  ./qa -type f -name "*.py" -print  >> ./cscope.files
find  ./s3-tests -type f -name "*.[chsS]" -print >> ./cscope.files
find  ./s3-tests -type f -name "*.py" -print  >> ./cscope.files


cscope -R -q -b -v

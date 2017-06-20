#!/bin/bash

find  . -type f -name "*.[chsS]" -print  > ./cscope.files
find  . -type f -name "*.cpp" -print  >>  ./cscope.files
find  . -type f -name "*.hpp" -print  >>  ./cscope.files
find  . -type f -name "*.cc" -print  >> ./cscope.files
find  . -type f -name "*.py" -print  >> ./cscope.files

cscope -R -q -b -v

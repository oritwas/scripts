#!/bin/bash

dd if=/dev/urandom of=4k.bin bs=4K count=1

s3cmd mb s3://bucket-1000/

for i in `seq 1 1001`; do s3cmd put 4k.bin s3://bucket-1000/_medias/01/4k-$i.bin ; done

s3cmd ls s3://bucket-1000/_medias/01/ | wc -l

for i in `seq 1 1001`; do s3cmd put 4k.bin s3://bucket-1000/_medias/02/4k-$i.bin ; done

s3cmd ls s3://bucket-1000/_medias/

s3cmd ls s3://bucket-1000/_medias/02/ | wc -l


#!/bin/bash

BIN=$1
$BIN/rados purge .rgw.root --yes-i-really-really-mean-it
$BIN/rados cppool .rgw.root.backup .rgw.root 

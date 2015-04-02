#!/bin/sh

OLD_BRANCH=$1
NEW_BRANCH=$2

SRC_DIR=region_upgrade_test
GIT_REPO=git@github.com:oritwas/ceph.git

function get_processors() {
    if test -n "$NPROC" ; then
        echo $NPROC
    else
        if test $(nproc) -ge 2 ; then
            expr $(nproc) / 2
        else
            echo 1
        fi
    fi
}

DEFAULT_MAKEOPTS=${DEFAULT_MAKEOPTS:--j$(get_processors)}
BUILD_MAKEOPTS=${BUILD_MAKEOPTS:-$DEFAULT_MAKEOPTS}

function build() {
    git clone $GIT_REPO $SRC_DIR
    cd $SRC_DIR
    git checkout $1
    ./autogen.sh || return 1
    ./configure "$@" --disable-static --with-radosgw --with-debug --without-lttng \
             CC="ccache gcc" CXX="ccache g++" CFLAGS="-Wall -g" CXXFLAGS="-Wall -g" || return 1
    mkdir $1
    cd $1
    cmake $SRC_DIR/
    make $BUILD_MAKEOPTS || return 1
}

function test()
{

}

function main() {
    build $OLD_BRANCH
    test
    build $NEW_BRANCH
}

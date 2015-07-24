#!/usr/bin/sh 

function mkd {
    if [ ! -d $1 ]; then mkdir $1; fi
}

mkd bin
mkd build
mkd tmp

build_dir=$(pwd)/build

function pyston {
    if [ -x bin/pyston ]; then return; fi
    wget https://github.com/dropbox/pyston/releases/download/v0.3/pyston.linux.x86_64 -O bin/pyston
    chmod +x bin/pyston
}

function cpython {
    if [ -x bin/cpython ]; then return; fi
    mkdir $build_dir/cpython
    cd tmp
    if [ ! -d cpython ]
    then
        wget https://github.com/python/cpython/archive/2.7.zip -O cpython.zip
        unzip cpython.zip -d cpython
    fi
    cd cpython/*/
    ./configure --prefix=$build_dir/cpython/
    make -j7
    make install
    ln $build_dir/cpython/bin/python2.7 ../../../bin/cpython
}

function spython {
    if [ -x bin/spython ]; then return; fi
    mkd $build_dir/spython
    cd tmp
    if [ ! -d spython ]
    then
        wget https://bitbucket.org/stackless-dev/stackless/get/v2.7.9.zip -O spython.zip
        unzip spython.zip -d spython
    fi
    cd spython/*/
    ./configure --prefix=$build_dir/spython/
    make -j7
    make install
    ln $build_dir/spython/bin/python2.7 ../../../bin/spython
}
pyston
spython
cpython

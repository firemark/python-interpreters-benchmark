#!/usr/bin/sh 
set -e

function mkd {
    if [ ! -d $1 ]; then mkdir $1; fi
}

mkd bin
mkd build
mkd tmp

repo_dir=$(pwd)
build_dir=$repo_dir/build

if type pypy > /dev/null; then
    PYTHON=pypy
else
    PYTHON=python
fi

function install_pyston {
    cd $repo_dir
    if [ -x bin/pyston ]; then return; fi
    echo install pyston
    wget https://github.com/dropbox/pyston/releases/download/v0.3/pyston.linux.x86_64 -O bin/pyston
    chmod +x bin/pyston
}

function install_cpython {
    cd $repo_dir
    if [ -h bin/cpython ]; then return; fi
    echo install cpython
    mkd $build_dir/cpython
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
    ln -s $build_dir/cpython/bin/python2.7 $repo_dir/bin/cpython
}

function install_spython {
    if [ -h bin/spython ]; then return; fi
    echo install spython
    mkd $build_dir/spython
    cd $repo_dir/tmp
    if [ ! -d spython ]
    then
        wget https://bitbucket.org/stackless-dev/stackless/get/v2.7.9.zip -O spython.zip
        unzip spython.zip -d spython
    fi
    cd spython/*/
    ./configure --prefix=$build_dir/spython/
    make -j7
    make install
    ln -s $build_dir/spython/bin/python2.7 $repo_dir/bin/spython
}

function install_pypy {
    if [ -h bin/pypy ]; then return; fi
    echo install pypy
    cd $repo_dir/tmp
    if [ ! -d pypy ]
    then
        wget https://bitbucket.org/pypy/pypy/downloads/pypy-2.6.0-src.zip -O pypy.zip
        unzip pypy.zip -d pypy
    fi
    cd pypy/*/
    $PYTHON rpython/bin/rpython -Ojit --make-jobs=7 pypy/goal/targetpypystandalone.py
    ln -s $(pwd)/pypy-c $repo_dir/bin/pypy
}

function install_pypystm {
    if [ -h bin/pypy-stm ]; then return; fi
    echo install pypy stm
    cd $repo_dir/tmp
    wget https://bitbucket.org/pypy/pypy/downloads/pypy-stm-2.5.1-linux64.tar.bz2 -O pypy-stm.tar.bz2
    tar -xjf pypy-stm.tar.bz2 -C $build_dir/pypy-stm
    cd $build_dir/pypy-stm/*
    ln -s $(pwd)/bin/pypy-stm $repo_dir/bin/pypy-stm
}

function install_jython {
    if [ -x jython ]; then return; fi;
    echo install jython
    cd $build_dir
    wget http://search.maven.org/remotecontent?filepath=org/python/jython-standalone/2.7.0/jython-standalone-2.7.0.jar -O jython.jar
    echo -e \#\!/bin/sh\\njava -jar $build_dir/jython.jar '$@' > $repo_dir/bin/jython
    chmod +x $repo_dir/bin/jython
}

install_pyston
install_spython
install_cpython
install_pypy
install_pypystm
install_jython

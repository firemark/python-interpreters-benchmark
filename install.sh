#!/usr/bin/sh 
set -e

function mkd {
    if [ ! -d $1 ]; then mkdir $1; fi
}

mkd bin
mkd build
mkd tmp
mkd scripts/data
mkd venvs

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
    virtualenv -p $build_dir/cpython/bin/python2.7 $repo_dir/venvs/cpython
    py=$repo_dir/bin/cpython
    ln -s $repo_dir/venvs/cpython/bin/python2.7 $py
    $py -m pip install numpy 
    $py -m pip install -r $repo_dir/req.txt
}

function install_spython {
    cd $repo_dir
    if [ -h bin/spython ]; then return; fi
    echo install spython
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
    virtualenv -p $build_dir/spython/bin/python2.7 $repo_dir/venvs/spython
    py=$repo_dir/bin/spython
    ln -s $repo_dir/venvs/spython/bin/python2.7 $py
    $py -m pip install numpy
    $py -m pip install -r $repo_dir/req.txt
}

function install_pypy {
    cd $repo_dir
    if [ -h bin/pypy ]; then return; fi
    echo install pypy
    cd tmp
    if [ ! -d pypy ]
    then
        wget https://bitbucket.org/pypy/pypy/downloads/pypy-2.6.0-linux64.tar.bz2  -O pypy.tar.bz2
        tar -xjf pypy.tar.bz2 -C $build_dir/pypy
    fi
    if [ ! -d pypy-numpy ]
    then
        wget https://bitbucket.org/pypy/numpy/get/pypy-2.6.0.zip -O pypy-numpy.zip
        unzip pypy-numpy.zip -d pypy-numpy
    fi
    cd $build_dir/pypy/*
    virtualenv -p $(pwd)/bin/pypy $repo_dir/venvs/pypy
    py=$repo_dir/bin/pypy
    ln -s $repo_dir/venvs/pypy/bin/pypy $py
    cd $repo_dir/tmp/pypy-numpy/*
    $py -m pip install -r $repo_dir/req.txt
}

function install_pypystm {
    cd $repo_dir
    if [ -h bin/pypy-stm ]; then return; fi
    echo install pypy stm
    cd tmp
    if [ ! -d pypy-stm ]
    then
        wget https://bitbucket.org/pypy/pypy/downloads/pypy-stm-2.5.1-linux64.tar.bz2 -O pypy-stm.tar.bz2
        tar -xjf pypy-stm.tar.bz2 -C $build_dir/pypy-stm
    fi
    if [ ! -d pypy-numpy ]
    then
        wget https://bitbucket.org/pypy/numpy/get/pypy-2.6.0.zip -O pypy-numpy.zip
        unzip pypy-numpy.zip -d pypy-numpy
    fi
    cd $build_dir/pypy-stm/*
    virtualenv -p $(pwd)/bin/pypy-stm $repo_dir/venvs/pypy-stm
    py=$repo_dir/bin/pypy-stm
    ln -s $repo_dir/venvs/pypy/bin/pypy $py
    cd $repo_dir/tmp/pypy-numpy/*
    $py setup.py install
    $py -m pip install -r $repo_dir/req.txt
}

function install_jython {
    cd $repo_dir
    if [ -h bin/jython ]; then return; fi;
    echo install jython
    cd tmp
    if [ ! -e jython-installer.jar ]
    then
        wget http://search.maven.org/remotecontent?filepath=org/python/jython-installer/2.7.0/jython-installer-2.7.0.jar -O jython-installer.jar
    fi
    wget https://github.com/Stewori/JyNI/releases/download/v2.7-alpha.2.3/JyNI-2.7-alpha.2.3.jar -O jyni.jar
    if [ ! -d $build_dir/jython ] 
    then
        mkdir $build_dir/jython
        java -jar jython-installer.jar -s -d $build_dir/jython -t standard
    fi
    py=$repo_dir/bin/jython
    ln -s $build_dir/jython/bin/jython $py
    $py -m pip install -r $repo_dir/req_jython.txt
    #chmod +x $repo_dir/bin/jython $repo_dir/bin/jython-jyni
}

function install_ironpython {
    cd $repo_dir
    if [ -x bin/iron ]; then return; fi;
    echo install iron python
    cd tmp
    wget https://s3.amazonaws.com/pydevbuilds2/IronPython-2.7.4.zip -O iron-python.zip
    unzip iron-python.zip -d $build_dir
    echo -e \#\!/bin/sh\\nmono $build_dir/IronPython-2.7.4/ipy64.exe '$@' > $repo_dir/bin/iron
    chmod +x $repo_dir/bin/iron
}

function download_data {
    cd $repo_dir/scripts/data
    if [ ! -e howto.bz2 ]
    then
        wget http://people.unipmn.it/manzini/lightweight/corpus/howto.bz2 -O howto.bz2
        bzip2 -d howto.bz2
    fi
}

install_pyston
install_spython
install_cpython
install_pypy
install_pypystm
install_jython
install_ironpython

download_data

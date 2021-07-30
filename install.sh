#!/usr/bin/env bash

mkdir -p `pwd`/log
log_path=`pwd`/log
rm ${log_path}/*
log_file=${log_path}/log.log
vim_version="8.2.3249"

echo "START: Install build vim dep debs"
sudo apt install -y \
    ctags cscope curl \
    libncurses5-dev ruby2.3-dev libperl-dev \
    python2.7-dev python2.7-dbg 2>&1 >> ${log_file}
echo "DONE: Install build vim dep debs"

echo "START: Install npm & nodejs"
sudo apt install -y npm 2>&1 >> ${log_file}
sudo npm config set registry https://registry.npm.taobao.org
sudo npm install n -g 2>&1 >> ${log_file}
sudo n stable 2>&1 >> ${log_file}
echo "DONE: Install npm & nodejs"

echo "START: Download vim source tar.gz"
curl -o vim-${vim_version}.tar.gz -L https://github.com/vim/vim/archive/refs/tags/v${vim_version}.tar.gz
echo "DONE: Download vim source tar.gz"

echo "START: Extract vim source tar.gz"
tar -zxvf vim-${vim_version}.tar.gz 2>&1 >> ${log_file}
echo "DONE: Extract vim source tar.gz"

echo "START: Build vim"
pushd vim-${vim_version}/
./configure \
	    --disable-libsodium \
	    --with-features=huge \
	    --enable-multibyte \
	    --enable-pythoninterp=yes \
	    --with-python-command=`which python2.7` \
	    --with-python-config-dir=`python2.7-config  --configdir` \
	    --enable-rubyinterp=yes \
	    --enable-perlinterp=yes \
	    --enable-cscope 2>&1 >> ${log_file}

make -j$(nproc) 2>&1 >> log.log
sudo make install -j$(nproc) 2>&1 >> ${log_file}
popd
echo "DONE: Build vim"

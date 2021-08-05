#!/usr/bin/env bash

vim_version="8.2.3290"
auth=sudo

echo "Update apt"
${auth} apt update

source /etc/lsb-release

if [ ${DISTRIB_RELEASE} == "16.04" ]; then
    ${auth} apt install -y ruby2.3-dev
fi
if [ ${DISTRIB_RELEASE} == "18.04" ]; then
    ${auth} apt install -y ruby2.5-dev 
fi
if [ ${DISTRIB_RELEASE} == "20.04" ]; then
    ${auth} apt install -y ruby2.7-dev
fi


echo "START: Install build vim dep debs" >&2
${auth} apt install -y ctags cscope curl libncurses5-dev libperl-dev python2.7-dev python2.7-dbg
echo "DONE: Install build vim dep debs" >&2

echo "START: Install npm & nodejs" >&2
${auth} apt install -y npm 
${auth} npm config set registry https://registry.npm.taobao.org 
${auth} npm install n -g 
${auth} n stable 
echo "DONE: Install npm & nodejs" >&2

echo "START: Download vim source tar.gz" >&2
curl -o vim-${vim_version}.tar.gz -L https://github.com/vim/vim/archive/refs/tags/v${vim_version}.tar.gz
echo "DONE: Download vim source tar.gz" >&2

echo "START: Extract vim source tar.gz" >&2
tar -zxvf vim-${vim_version}.tar.gz
echo "DONE: Extract vim source tar.gz" >&2

echo "START: Build vim" >&2
pushd vim-${vim_version}/
./configure --disable-libsodium \
    --with-features=huge \
    --enable-multibyte \
    --enable-pythoninterp=yes  \
    --with-python-command=`which python2.7` \
    --with-python-config-dir=`python2.7-config  --configdir`  \
    --enable-rubyinterp=yes \
    --enable-perlinterp=yes \
    --enable-cscope \
    --with-x

make 
${auth} make install 
popd
echo "DONE: Build vim" >&2

vim --version
vim -c :PlugInstall

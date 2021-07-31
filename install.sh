#!/usr/bin/env bash

vim_version="8.2.3249"
auth=sudo

echo "Update apt" >&2
${auth} apt update 2>&1 > /dev/null

source /etc/lsb-release

if [ ${DISTRIB_RELEASE} == "16.04" ]; then
    ${auth} apt install -y ruby2.3-dev 2>&1 > /dev/null
fi
if [ ${DISTRIB_RELEASE} == "18.04" ]; then
    ${auth} apt install -y ruby2.5-dev 2>&1 > /dev/null
fi
if [ ${DISTRIB_RELEASE} == "20.04" ]; then
    ${auth} apt install -y ruby2.7-dev 2>&1 > /dev/null
fi


echo "START: Install build vim dep debs" >&2
${auth} apt install -y ctags cscope curl libncurses5-dev libperl-dev python2.7-dev python2.7-dbg 2>&1 > /dev/null
echo "DONE: Install build vim dep debs" >&2

echo "START: Install npm & nodejs" >&2
${auth} apt install -y npm 2>&1 > /dev/null
${auth} npm config set registry https://registry.npm.taobao.org 2>&1 > /dev/null
${auth} npm install n -g 2>&1 > /dev/null
${auth} n stable 2>&1 > /dev/null
echo "DONE: Install npm & nodejs" >&2

echo "START: Download vim source tar.gz" >&2
curl -o vim-${vim_version}.tar.gz -L https://github.com/vim/vim/archive/refs/tags/v${vim_version}.tar.gz
echo "DONE: Download vim source tar.gz" >&2

echo "START: Extract vim source tar.gz" >&2
tar -zxvf vim-${vim_version}.tar.gz 2>&1 > /dev/null
echo "DONE: Extract vim source tar.gz" >&2

echo "START: Build vim" >&2
pushd vim-${vim_version}/
./configure \ 
    --disable-libsodium \
    --with-features=huge \
    --enable-multibyte \
    --enable-pythoninterp=yes  \
    --with-python-command=`which python2.7` \
    --with-python-config-dir=`python2.7-config  --configdir`  \
    --enable-rubyinterp=yes \
    --enable-perlinterp=yes \
    --enable-cscope 2>&1 > /dev/null

make 2>&1 > /dev/null
${auth} make install 2>&1 > /dev/null
popd
echo "DONE: Build vim" >&2

vim --version
vim -c :PlugInstall

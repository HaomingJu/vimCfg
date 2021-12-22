#!/usr/bin/env bash

vim_version="8.2.3863"
auth=sudo

#vim_with_python="--enable-pythoninterp=yes  \
    #--with-python-command=`which python2` \
    #--with-python-config-dir=`python2.7-config  --configdir` \
    #"

vim_with_python="--enable-python3interp=yes  \
    --with-python3-command=`which python3` \
    --with-python3-config-dir=`python3-config  --configdir` \
    "

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
${auth} n latest
${auto} n prune
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
    ${vim_with_python}
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

# :CocCommand clangd.install 命令要下载的工具连接 https://github.com/clangd/clangd/releases/tag/13.0.0

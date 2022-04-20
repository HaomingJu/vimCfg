#!/usr/bin/env bash

build_vim=true
build_neovim=true

vim_with_python2="--enable-pythoninterp=yes  \
    --with-python-command=`which python2` \
    --with-python-config-dir=`python2.7-config  --configdir` \
    "

vim_with_python3="--enable-python3interp=yes  \
    --with-python3-command=`which python3` \
    --with-python3-config-dir=`python3-config  --configdir` \
    "
vim_with_python=$vim_with_python3

echo "Update apt"
sudo apt update

source /etc/lsb-release

if [ ${DISTRIB_RELEASE} == "16.04" ]; then
    sudo apt install -y ruby2.3-dev
fi
if [ ${DISTRIB_RELEASE} == "18.04" ]; then
    sudo apt install -y ruby2.5-dev 
fi
if [ ${DISTRIB_RELEASE} == "20.04" ]; then
    sudo apt install -y ruby2.7-dev
fi


echo "START: Install build vim dep debs" >&2
sudo apt install -y ctags cscope curl libncurses5-dev libperl-dev vim-scripts vim-gtk vim-gnome vim-common
echo "DONE: Install build vim dep debs" >&2

echo "START: Install npm & nodejs" >&2
sudo apt install -y npm
sudo npm config set registry https://registry.npm.taobao.org 
sudo npm install n -g 

export N_NODE_MIRROR=https://npm.taobao.org/mirrors/node
sudo n stable
sudo n prune
echo "DONE: Install npm & nodejs" >&2


if $build_vim; then
    rm -rf ~/.vim/build/vim
    git clone --depth 1 https://github.com/vim/vim.git ~/.vim/build/vim
    pushd ~/.vim/build/vim
    ./configure --disable-libsodium \
        --with-features=huge \
        --enable-multibyte \
        ${vim_with_python} \
        --enable-rubyinterp=yes \
        --enable-perlinterp=yes \
        --enable-cscope \
        --with-x

    make
    sudo make install
    popd
    echo "DONE: Build vim" >&2
fi

if $build_neovim; then
    rm -rf ~/.vim/build/neovim/
    git clone --depth 1 https://github.com/neovim/neovim.git ~/.vim/build/neovim
    pushd ~/.vim/build/neovim
    make CMAKE_BUILD_TYPE=Release
    sudo make install
popd

echo "DONE: Build neovim"
fi

vim -c :PlugInstall
# :CocCommand clangd.install 命令要下载的工具连接 https://github.com/clangd/clangd/releases/tag/13.0.0

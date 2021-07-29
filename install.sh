#!/usr/bin/env bash

sudo apt install ctags

# Install Plugin
vim -c :PlugInstall

# install coc extensions

# for coc-clangd
vim -c :CocCommand clangd.install
#sudo snap install clangd --classic


<!-- vim-markdown-toc GFM -->

* [1. 支持系统](#1-支持系统)
* [2. 部署](#2-部署)
    * [2.1 下载](#21-下载)
    * [2.2 执行安装脚本](#22-执行安装脚本)
    * [2.3 插件安装](#23-插件安装)
* [3. 文档参考](#3-文档参考)
* [4. TODOs](#4-todos)
* [5. Q&A](#5-qa)
* [6. 其他](#6-其他)

<!-- vim-markdown-toc -->

# 1. 支持系统

![](https://img.shields.io/badge/Ubuntu16_04_LTS_Xenial-PASS-green.svg) ![](https://img.shields.io/badge/Ubuntu18_04_LTS_Bionic-PASS-green.svg) ![](https://img.shields.io/badge/Ubuntu20_04_LTS_Focal-NOTEST-blue.svg)

# 2. 部署

## 2.1 下载
```
git clone https://github.com/HaomingJu/vimCfg.git ~/.vim
```

## 2.2 执行安装脚本
```
./install.sh
```

## 2.3 插件安装

```
# Bash
vim -c :PlugInstall

# Inside vim
:CocCommand clangd.install

# Wait for some minutes
```

> 执行`:CocCommand clangd.install`之后`~/.vim/coc-settings.json`内将会自动设定`clangd.path`选项值


# 3. 文档参考

[功能画廊](./doc/ScreenShot.md)    |    [快捷键文档](./doc/ShortCutKey.md)

# 4. TODOs

- [x] Automatic deployment and usage of Ubuntu16.04 (Ubuntu16.04的自动部署和使用)
- [x] Automatic deployment and usage of Ubuntu18.04 (Ubuntu18.04的自动部署和使用)
- [ ] Automatic deployment and usage of Ubuntu20.04 (Ubuntu20.04的自动部署和使用)
- [ ] Show dynamic scrrentshots of features (功能动态截图展示)
- [x] Vim complete with Perl (vim编译时支持Perl)
- [x] Vim complete with Ruby (vim编译时支持Ruby)
- [x] Vim complete with Python2 (vim编译时支持Python2)
- [x] Vim complete with Python3 (vim编译时支持Python3)
- [x] Complete documentation of shortcut keys (完善快捷键说明文档)
- [x] Lazy-load for plugin (支持延迟加载)

# 5. Q&A

# 6. 其他
![GitHub repo size](https://img.shields.io/github/repo-size/HaomingJu/vimCfg) 

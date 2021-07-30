

# 部署

下载
```
git clone https://github.com/HaomingJu/vimCfg.git ~/.vim
```

执行安装脚本
```
./install.sh
```

插件安装

```
# Bash
vim -c :PlugInstall

# Inside vim
:CocCommand clangd.install

# Wait for some minutes
```

> 执行`:CocCommand clangd.install`之后`~/.vim/coc-settings.json`内将会自动设定`clangd.path`选项值


# 文档参考

# TODOs

- [ ] Automatic deployment and usage of Ubuntu16.04 (Ubuntu16.04的自动部署和使用)
- [ ] Automatic deployment and usage of Ubuntu18.04 (Ubuntu18.04的自动部署和使用)
- [ ] Automatic deployment and usage of Ubuntu20.04 (Ubuntu20.04的自动部署和使用)
- [ ] Show dynamic scrrentshots of features (功能动态截图展示)
- [x] Vim complete with Perl (vim编译时支持Perl)
- [x] Vim complete with Ruby (vim编译时支持Ruby)
- [x] Vim complete with Python2 (vim编译时支持Python2)
- [ ] Vim complete with Python3 (vim编译时支持Python3)
- [ ] Complete documentation of shortcut keys (完善快捷键说明文档)

# Q&A

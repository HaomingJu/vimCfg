

# 安装步骤

**下载**
```
git clone https://github.com/HaomingJu/vimCfg.git ~/.vim
```

**执行安装脚本**
```
./install.sh
```

**插件安装**

```
# Bash
vim -c :PlugInstall

# Inside vim
:CocCommand clangd.install

# Wait for some minutes
```

> 执行`:CocCommand clangd.install`之后`~/.vim/coc-settings.json`内将会自动设定`clangd.path`选项值

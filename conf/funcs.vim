" 函数区
" 使得vim支持Alt组合键
function! Terminal_MetaMode(mode)
    if has('nvim') || has('gui_running')
        return
    endif
    function! s:metacode(mode, key)
        if a:mode == 0
            exec "set <M-".a:key.">=\e".a:key
        else
            exec "set <M-".a:key.">=\e]{0}".a:key."~"
        endif
    endfunc
    for i in range(10)
        call s:metacode(a:mode, nr2char(char2nr('0') + i))
    endfor
    for i in range(26)
        call s:metacode(a:mode, nr2char(char2nr('a') + i))
        call s:metacode(a:mode, nr2char(char2nr('A') + i))
    endfor
    if a:mode != 0
        for c in [',', '.', '/', ';', '[', ']', '{', '}']
            call s:metacode(a:mode, c)
        endfor
        for c in ['?', ':', '-', '_']
            call s:metacode(a:mode, c)
        endfor
    else
        for c in [',', '.', '/', ';', '{', '}']
            call s:metacode(a:mode, c)
        endfor
        for c in ['?', ':', '-', '_']
            call s:metacode(a:mode, c)
        endfor
    endif
    set ttimeout
    if $TMUX != ''
        set ttimeoutlen=30
    elseif &ttimeoutlen > 80 || &ttimeoutlen <= 0
        set ttimeoutlen=30
    endif
endfunc



" 依据时间选择颜色主题 8:00-18:00 light 18:00-8:00 dark
function! SwitchColor()
    " jackguo380/vim-lsp-cxx-highlight 配置变量, C++变量颜色渲染
    let g:lsp_cxx_hl_use_text_props = 1
    set t_Co=256
    let colorscheme_time=strftime("H")
    if colorscheme_time < 8
        "使用molakai配色方案
        let g:molokai_original=1
        colorscheme molokai
        set background=dark
    elseif colorscheme_time < 18
        "使用solarized配色方案
        colorscheme solarized
        set background=light
    else
        "使用molakai配色方案
        let g:molokai_original=1
        colorscheme molokai
        set background=dark
    endif
endfunc




"tagbar插件配置
function! SetTagbar()
    let g:tagbar_left = 1
    let g:tagbar_iconchars = ['▸', '▾']
    let g:tagbar_sort = 0
    let g:tagbar_show_visibility = 1
    highlight  TagbarHighlight guifg=Blue ctermfg=Blue
endfunc

"vim-json插件配置
function! SetVimjson()
    let g:vim_json_syntax_conceal = 0
endfunc

" 设置RainBow插件
function! SetRainbow()
    let g:rainbow_active = 1
    let g:rainbow_conf={'separately': {'cmake': 0,}}
endfunc


" EasyMotion颜色设置
function! SetEasyMotion()
    hi EasyMotionTarget2First ctermbg=green ctermfg=white
    hi EasyMotionTarget ctermbg=red ctermfg=white
endfunc


" 设定 doc 文档目录
function! SetChineseDoc()
    let g:helptags=$VIM."/vimfiles/doc"
    set helplang=cn
endfunc


" 翻译 Display translation in a window
function! SetTranslate()
    nmap <silent> <Leader>t <Plug>TranslateW
    vmap <silent> <Leader>t <Plug>TranslateWV
    let g:translator_default_engines=['google']
    let g:translator_proxy_url="http://127.0.0.1:12333"
endfunc

" 恢复上次文件打开位置
function! SetTextRecover()
    set viminfo='10,\"100,:20,%,n~/.viminfo
    au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif"'")"'")")'"
endfunc


" 设置LeaderF插件
function! SetLeaderfF()
    noremap <C-p> :LeaderfFile<CR>
    noremap <C-f> :LeaderfBufTag<CR>
    noremap <C-i> :LeaderfMru<CR>
    noremap <Leader>h :LeaderfHistoryCmd<CR>
    noremap <C-@> :LeaderfBuffer<CR>

    let g:Lf_HideHelp = 1
    let g:Lf_WindowHeight=0.3
    let g:Lf_StlColorscheme='powerline'
    let g:Lf_ShowDevIcons=0
    let g:Lf_HistoryNumber=1000
    let g:Lf_DefaultExternalTool='ag'
    let g:Lf_WindowPosition = 'popup'
    let g:Lf_PreviewInPopup = 1
    let g:Lf_WildIgnore = {
            \'dir': ['.git', 'build', '*output*'],
            \ 'file': ['*.o', '*.so', '*.py[co]', 'compile_commands.json']
            \}
endfunc

function! SetAirline()
    let g:airline_section_z = ''
endfunc

function! SetMarkdown()
    let g:vim_markdown_conceal = 0
    let g:vim_markdown_conceal_code_blocks = 0
    let g:vim_markdown_no_default_key_mappings = 1
    let g:vim_markdown_folding_disabled = 1
endfunc


"NERDTree 插件配置
function! SetNERDTree()
"autocmd vimenter * NERDTree
    let g:NERDTreeIgnore=['^output','^install','^build', '^output_x86_64$', 'pyc$', '__init__.py', 'compile_commands.json', '.+tar.gz', 'cmake-build-debug', 'cmake-build-release']
    let g:NERDTreeWinPos='right'
    let g:NERDTreeWinSize=23
    let g:NERDTreeChDirMode=2
    let g:NERDTreeShowBookmarks=1
    let g:NERDTreeStatusline='NERDTree'
    let g:NERDTreeMinimalUI=1
endfunc



function! SetLightline()
    let g:lightline = {
                \'active': {
                    \ 'left': [[ 'mode', 'paste'], ['relativepath', 'modified']],
                    \ 'right': [[ 'percent'], ['fileformat', 'fileencoding', 'filetype']]
                    \},
                \'inactive': {'left': [[ 'filename' ]], 'right': []}
    \}
endfunc

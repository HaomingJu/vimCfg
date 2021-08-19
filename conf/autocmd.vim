function! SwitchInputMethod()
    call job_start('fcitx-remote -c')
endfunc

autocmd InsertLeave * :call SwitchInputMethod()
autocmd BufCreate *  :call SwitchInputMethod()
autocmd BufEnter *  :call SwitchInputMethod()

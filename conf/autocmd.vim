function! SwitchInputMethod()
    call job_start('fcitx-remote -c')
endfunc


if !has('nvim')
    autocmd InsertLeave * :call SwitchInputMethod()
    autocmd BufCreate *  :call SwitchInputMethod()
    autocmd BufEnter *  :call SwitchInputMethod()
endif


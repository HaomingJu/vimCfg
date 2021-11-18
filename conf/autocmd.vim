function! SwitchInputMethod()
    call job_start('fcitx-remote -c')
endfunc

function! CapsLock2Escape()
    call job_start('xmodmap -e "clear lock"')
    call job_start('xmodmap -e "keycode 66 = Escape NoSymbol Escape"')
endfunction

autocmd InsertLeave * :call SwitchInputMethod()
autocmd BufCreate *  :call SwitchInputMethod()
autocmd BufEnter *  :call SwitchInputMethod()
autocmd VimEnter * :call CapsLock2Escape()

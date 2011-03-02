scriptencoding utf-8

if exists('g:loaded_remotecopy') && g:loaded_remotecopy
    finish
endif
let g:loaded_remotecopy = 1

let s:save_cpo = &cpo
set cpo&vim

" TODO: support passing in a register
command! RemoteCopy call remotecopy#docopy()

let &cpo = s:save_cpo

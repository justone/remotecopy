scriptencoding utf-8

if exists('g:loaded_remotecopy') && g:loaded_remotecopy
    finish
endif
let g:loaded_remotecopy = 1

let s:save_cpo = &cpo
set cpo&vim

command -range=% RemoteCopy call remotecopy#docopy(<line1>, <line2>)
command RemoteCopyRegister call remotecopy#copyreg()

" probably a better way to do this
noremap <leader>y :RemoteCopy<CR>
noremap <leader>r :RemoteCopyRegister<CR>

let &cpo = s:save_cpo

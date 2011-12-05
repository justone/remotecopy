scriptencoding utf-8

if exists('g:loaded_remotecopy') && g:loaded_remotecopy
    finish
endif
let g:loaded_remotecopy = 1

let s:save_cpo = &cpo
set cpo&vim

command -range=% RemoteCopy call remotecopy#docopy(0, <line1>, <line2>)
command -range=% RemoteCopyVisual call remotecopy#docopy(1, '', '')
command RemoteCopyRegister call remotecopy#copyreg()

" probably a better way to do this
noremap <leader>y :RemoteCopy<CR>
vnoremap <leader>y :RemoteCopyVisual<CR>
noremap <leader>r :RemoteCopyRegister<CR>

let &cpo = s:save_cpo

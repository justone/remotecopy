
if exists('s:loaded') && s:loaded
    finish
endif
let s:loaded = 1

let s:save_cpo = &cpo
set cpo&vim

function! remotecopy#docopy()
    let output = system("remotecopy", getreg(""))
    if v:shell_error
        if v:shell_error == 1
            " if it's exit code 1, then we need to reauth
            "echo v:shell_error
        else
            echo output
        endif
    else
        echo "Remote copied."
    endif
endfunction

let &cpo = s:save_cpo


if exists('s:loaded') && s:loaded
    finish
endif
let s:loaded = 1

let s:save_cpo = &cpo
set cpo&vim

let s:secret = 'none'

function! remotecopy#docopy(line1, line2)
    let s:copy_text = getline(a:line1, a:line2)
    let output = system("remotecopy -n -s ".s:secret, join(s:copy_text,"\r"))
    if v:shell_error
        if v:shell_error == 1
            " if it's exit code 1, then we need to reauth
            echo "Need to auth"
            let s:secret = input("Input secret: ")
            call remotecopy#docopy(a:line1, a:line2)
        else
            echo output
        endif
    else
        echo "Remote copied."
    endif
endfunction

function! remotecopy#copyreg()
    let output = system("remotecopy -n -s ".s:secret, getreg(v:register))
    if v:shell_error
        if v:shell_error == 1
            " if it's exit code 1, then we need to reauth
            echo "Need to auth"
            let s:secret = input("Input secret: ")
            call remotecopy#copyreg()
        else
            echo output
        endif
    else
        echo "Remote copied."
    endif
endfunction

let &cpo = s:save_cpo

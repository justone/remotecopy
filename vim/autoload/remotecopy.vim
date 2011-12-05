
if exists('s:loaded') && s:loaded
    finish
endif
let s:loaded = 1

let s:save_cpo = &cpo
set cpo&vim

let s:secret = 'none'

function! remotecopy#docopy(visual, line1, line2)
    " if it's a visual selection
    if (a:visual)

        " save the old value of the default register
        let old_reg = getreg('"')
        let old_regtype=getregtype('"')

        " grab the last visual selection
        normal! gvy

        " send it
        call s:rcopy(getreg('"'))

        " restore old register value
        call setreg('"', old_reg, old_regtype)
    else

        " if not visual, then just send the entire file
        call s:rcopy(join(getline(a:line1, a:line2),"\r"))
    endif
endfunction

function! remotecopy#copyreg()
    call s:rcopy(getreg(v:register))
endfunction

function s:rcopy(data)
    let output = system("remotecopy -n -s ".s:secret, a:data)
    if v:shell_error
        if v:shell_error == 1
            " if it's exit code 1, then we need to reauth
            echo "Need to auth"
            let s:secret = input("Input secret: ")
            call s:rcopy(a:data)
        else
            echo output
        endif
    else
        echo "Remote copied."
    endif
endfunction

let &cpo = s:save_cpo

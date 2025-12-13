
function! g:Commander(...)
    if a:0 == 3
        let l:nCol      = a:1
        let l:szCommand = a:2
        let l:szHelp    = a:3

        if len(l:szHelp) > 0
            let l:szSz = CapitalizeWords(l:szHelp)
            call add(g:pageSetList[g:pageno][l:nCol + 1], l:szSz)
        endif

        if len(l:szCommand) > 0
            let l:firstword = GetFirstWord(l:szCommand)
            if l:firstword == 'nnoremap' || l:firstword == 'inoremap' || l:firstword == 'command!'
                execute l:szCommand
            else
                execute 'nnoremap ' . l:szCommand
            endif
       endif

   endif
endfunction

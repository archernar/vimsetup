    if a:0 == 1
        call g:Commander('', a:1)
    else
        call g:Commander('', a:1 . " - " . a:2)
    endif

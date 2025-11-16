function! SaveMacroA(filename)
  let macro_content = getreg('a')
  call writefile([macro_content], a:filename)
endfunction
function! SaveMacroB(filename)
  let macro_content = getreg('b')
  call writefile([macro_content], a:filename)
endfunction
function! SaveMacroC(filename)
  let macro_content = getreg('c')
  call writefile([macro_content], a:filename)
endfunction
function! LoadMacroA(filename)
  if filereadable(a:filename)
      let macro_content = readfile(a:filename)
      if !empty(macro_content)
        call setreg('a', macro_content[0])
      endif
  endif
endfunction
function! LoadMacroB(filename)
  if filereadable(a:filename)
      let macro_content = readfile(a:filename)
      if !empty(macro_content)
        call setreg('b', macro_content[0])
      endif
  endif
endfunction
function! LoadMacroC(filename)
  if filereadable(a:filename)
      let macro_content = readfile(a:filename)
      if !empty(macro_content)
        call setreg('c', macro_content[0])
      endif
  endif
endfunction

function! DefineMacroAPrompt()
  let l:sz = input("macro 'a' text ")
  call setreg('a', l:sz)
  call SaveMacroA("/home/mestes/.vim/macros/macro_a.vim")
  nnoremap <Leader>a         :normal! @a<cr>b
endfunction
function! DefineMacroBPrompt()
  let l:sz = input("macro 'b' text ")
  call setreg('b', l:sz)
  call SaveMacroB("/home/mestes/.vim/macros/macro_b.vim")
  nnoremap <Leader>b         :normal! @b<cr>b
endfunction
function! DefineMacroCPrompt()
  let l:sz = input("macro 'c' text ")
  call setreg('c', l:sz)
  call SaveMacroC("/home/mestes/.vim/macros/macro_c.vim")
  nnoremap <Leader>c         :normal! @c<cr>b
endfunction

call LoadMacroA("/home/mestes/.vim/macros/macro_a.vim")
call LoadMacroB("/home/mestes/.vim/macros/macro_b.vim")
call LoadMacroC("/home/mestes/.vim/macros/macro_c.vim")
nnoremap <Leader>A         :call DefineMacroAPrompt()<cr>
nnoremap <Leader>B         :call DefineMacroBPrompt()<cr>
nnoremap <Leader>C         :call DefineMacroCPrompt()<cr>


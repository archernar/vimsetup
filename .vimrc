" *********************************************************DATEOMATIC: Sun Jun 29 10:07:30 AM EDT 2025
" *********************************************************HASHOMATIC: c110cf899e129b42a5862d73b1d553c3
" *****************************************************************************************************
                " W e l c o m e   t o   m y  V I M R C
                " *************************************************************************************
set nocompatible
set hidden                        " Will switch to next buffer without raising an error
set nowrap
set nohlsearch
set noerrorbells
set scrolloff=8
let loaded_matchparen = 1         
            " http://vimrc-dissection.blogspot.com/2006/09/vim-7-re-turn-off-parenparenthesiswhat.html
set splitbelow
set splitright
set cmdheight=2                   " Set the command window height to 2 lines, to avoid many cases
                                  " of having to  press <Enter> to continue
set ruler                         " Display crsr pos on last line of scr or in status line of a window
set number                        " Display line numbers on the left
set wildmenu                      " Better command-line completion
set showcmd                       " Show partial commands in the last line of the screen
set ignorecase                    " Use case insensitive search, except when using capital letters
set smartcase
set backspace=indent,eol,start    " Allow bckspcing over autoindent, line brks & start of insrt action
set nostartofline                 " Stop certain movements from always going to the 1st char of a line.
set laststatus=2                  " Always display the status line, even if only 1 window is displayed
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set colorcolumn=104
set background=dark
set laststatus=2                  " For Status Line
set t_Co=256                      " For Status Line

" set relativenumber
" set signcolumn=yes
" set incsearch
" set hlsearch incsearch          " Highlight searches (use <C-L> to temporarily turn off highlighting
                                  " see the mapping of <C-L> below)

" *****************************************************************************************************
                " Indent and Tab  Setup
                " *************************************************************************************
" There are in fact four main methods available for indentation, each one
" overrides the previous if it is enabled, or non-empty for 'indentexpr':
" 'autoindent'	uses the indent from the previous line.
"               When opening a new line and no filetype-specific indenting is enabled, keep same
"               indent as line currently on.
" 'smartindent'	is like 'autoindent' but also recognizes some C syntax to
" 		increase/reduce the indent where appropriate.
" 'cindent'	Works more cleverly than the other two and is configurable to
" 		different indenting styles.
" 'indentexpr'	The most flexible of all: Evaluates an expression to compute
" 		the indent of a line.  When non-empty this method overrides
" 		the other ones.  See |indent-expression|.
" set cindent                       
set tabstop=4 softtabstop=4
set shiftwidth=4     " Indent settings for using 4 spaces instead of tabs.
                     " Do not change 'tabstop' from its default value of 8 
set expandtab
set smartindent
" *****************************************************************************************************
                " Syntax Highlighting
                " *************************************************************************************
syntax off

set confirm                       " Instead of failing a command because of unsaved changes,
                                  " raise a dialogue asking to save changed files.
set visualbell                    " Use visual bell instead of beeping when doing something wrong
set t_vb=
                                  " reset terminal code for visual bell. 
                                  " If visualbell is set, and this line is also included vim will
                                  " neither flash nor beep. If visualbell is unset, this does nothing.
let mapleader = " "               " Leader - ( Spacebar )
let MRU_Auto_Close = 1            " Set MRU window to close after selection
set notimeout ttimeout ttimeoutlen=200  " Quickly time out on keycodes, but never time out on mappings

" *****************************************************************************************************
                " Commands
                " *************************************************************************************
command! MyLinter :caddexpr system("cat zzzz") | copen
command! ZZZZ :caddexpr system("cat zzzz") | copen
map <C-j> :cn<CR>
map <C-k> :cp<CR>
map <C-@> @a

"  :copen " Open the quickfix window
"  :ccl   " Close it
"  :cw    " Open it if there are "errors", close it otherwise (some people prefer this)
"  :cn    " Go to the next error in the window
"  :cp    " Go to the previous error in the window
"  :cnf   " Go to the first error in the next file
"  :.cc   " Go to error under cursor (if cursor is in quickfix window)
"
" *****************************************************************************************************
                " Pre Vundle Setup
                " *************************************************************************************
filetype off

" let NOVUNDLE = 1
" *****************************************************************************************************
                " Vundle            - see :h vundle for more details or wiki for FAQ
                " *******************************************************************
                " git clone  https://github.com/VundleVim/Vundle.vim.git  ~/.vim/bundle/Vundle.vim
                " git clone  https://github.com/archernar/home.git .
                " git clone  https://github.com/archernar/dotfiles.git    ~/tmp
                " git clone
                " OLD TO BE REMOVED git clone  https://github.com/archernar/Snips.git .
                " :PluginList       - lists configured plugins
                " :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
                " :PluginUpdate     - <leader>p
                " :PluginSearch foo - searches for foo; append `!` to refresh local cache
                " :PluginClean      - confirms removal of unused plugins;
                "                     append `!` to auto-approve removal
                " *************************************************************************************
                
" *****************************************************************************************************
                " Vundle Begin
                " *************************************************************************************
if !exists("NOVUNDLE")
    set rtp+=~/.vim/bundle/Vundle.vim
    call vundle#begin()
    " Plugin 'VundleVim/Vundle.vim'
    Plugin 'archernar/vim-utils'
    Plugin 'archernar/vim-flashcard'
    Plugin 'archernar/vim-dir'
    Plugin 'archernar/vim-progsnips'
    Plugin 'archernar/vim-map'
    Plugin 'archernar/vim-session'
    Plugin 'archernar/vim-program'
    Plugin 'archernar/vim-monochrome'
    Plugin 'archernar/vim-mru'
    Plugin 'gruvbox-community/gruvbox'
    Bundle 'Lokaltog/vim-monotone.git'
    Bundle 'owickstrom/vim-colors-paramount'
    Plugin 'tpope/vim-surround'
    Plugin 'vim-airline/vim-airline'
    " Plugin 'tpope/vim-fugitive'
    " Plugin 'vim-airline/vim-airline-themes'
    " Plugin 'jeetsukumaran/vim-buffergator'
    " Plugin 'ctrlpvim/ctrlp.vim'
    "
    call vundle#end()
endif
" *****************************************************************************************************
                " Vundle End
                " *************************************************************************************
                                  
" *****************************************************************************************************
                " Post Vundle Setup
                " *************************************************************************************
filetype plugin indent on         " required, to ignore plugin indent changes, instead use: 
                                  " filetype plugin on
                                  " Put non-Plugin stuff after this line

" *****************************************************************************************************
                " Functions
                " *************************************************************************************
source ~/utils.vim

" ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
" Help Buffer Popup
" ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
let s:helpPageList=[]
call add(s:helpPageList, [])
call add(s:helpPageList, [])
call add(s:helpPageList, [])
call add(s:helpPageList, [])
call add(s:helpPageList, [])
call add(s:helpPageList, [])

let s:pageSetList=[]
for i in range(1, 10)
    let s:pageSet = []
    call add(s:pageSet, [])
    call add(s:pageSet, [])
    call add(s:pageSet, [])
    call add(s:pageSet, [])
    call add(s:pageSet, [])
    call add(s:pageSet, [])
    call add(s:pageSetList, s:pageSet)
endfor
let g:pageno = 1

function! g:NextHelpPage()
    let g:pageno = g:pageno + 1
    if g:pageno > 4
        let g:pageno = 1
    endif
    echom "Help Page Number " . g:pageno
endfunction

" let s:helpPageSets=[]
" let s:helpPageList=[]
" call add(s:helpPageList, [])
" call add(s:helpPageList, [])
" call add(s:helpPageList, [])
" call add(s:helpPageList, [])
" call add(s:helpPageList, [])
" call add(s:helpPageList, [])
" call add(s:helpPageList, [])

let s:helpdisplaynames=[]
let s:helpdisplaynames2=[]
let s:helpdisplaynames3=[]
let s:helpdisplaynames4=[]
let s:helpdisplaynames5=[]
"for i in range(1, 10)
"    call add(s:helpdisplaynames3, "|" )
"endfor
"MODIFY
function! g:HelpPopUp()
    "let maxLen = max([len1, len2])
    let l:maxLen = -100
    let l:maxLen = max([len(s:pageSetList[g:pageno][1]), l:maxLen])
    let l:maxLen = max([len(s:pageSetList[g:pageno][2]), l:maxLen])
    let l:maxLen = max([len(s:pageSetList[g:pageno][3]), l:maxLen])
    let l:maxLen = max([len(s:pageSetList[g:pageno][4]), l:maxLen])
    let l:maxLen = max([len(s:pageSetList[g:pageno][5]), l:maxLen])

    let l:fullsize = l:maxLen
    for i in range(1, l:fullsize-len(s:pageSetList[g:pageno][1]))
        call add(s:pageSetList[g:pageno][1], "" )
    endfor
    for i in range(1, l:fullsize-len(s:pageSetList[g:pageno][2]))
        call add(s:pageSetList[g:pageno][2], "" )
    endfor
    for i in range(1, l:fullsize-len(s:pageSetList[g:pageno][3]))
        call add(s:pageSetList[g:pageno][3], "" )
    endfor
    for i in range(1, l:fullsize-len(s:pageSetList[g:pageno][4]))
        call add(s:pageSetList[g:pageno][4], "" )
    endfor
    for i in range(1, l:fullsize-len(s:pageSetList[g:pageno][5]))
        call add(s:pageSetList[g:pageno][5], "" )
    endfor

    let l:temp1 =  ConcatStringLists(g:PadStrings(s:pageSetList[g:pageno][1]), g:PadStrings(s:pageSetList[g:pageno][2]))
    let l:temp2 =  ConcatStringLists(l:temp1, g:PadStrings(s:pageSetList[g:pageno][3]))
    let l:temp3 =  ConcatStringLists(l:temp2, g:PadStrings(s:pageSetList[g:pageno][4]))
    let l:arr   =  ConcatStringLists(l:temp3, g:PadStrings(s:pageSetList[g:pageno][5]))

    call add(l:arr,"=")
    call popup_menu(l:arr,
    \ #{ title: "Help", callback: 'MenuCBDoNothing', line: 25, col: 40, 
    \ highlight: 'Question', border: [], close: 'click',  padding: [1,1,0,1]} )
endfunction

func! MenuCBDoNothing(id, result)
    let l:NOTHING=0
endfunction

func! g:CommanderText(...)
    if a:0 == 1
        call g:Commander('', a:1)
    else
        call g:Commander('', a:1 . " - " . a:2)
    endif
endfunction

func! g:Commander(szCommand, szHelp)
    if len(a:szCommand)+len(a:szHelp) == 0
        call add(s:pageSetList[1], "" )
    else
        if len(a:szHelp) > 0
            let l:szSz = CapitalizeWords(a:szHelp)

            if EndsWith(l:szSz,"++++")
                call add(s:pageSetList[g:pageno][5], strpart(l:szSz, 0, len(l:szSz) - 4) )
            else
                if EndsWith(l:szSz,"+++")
                    call add(s:pageSetList[g:pageno][4], strpart(l:szSz, 0, len(l:szSz) - 3) )
                else
                    if EndsWith(l:szSz,"++")
                        call add(s:pageSetList[g:pageno][3], strpart(l:szSz, 0, len(l:szSz) - 2) )
                    else
                        if EndsWith(l:szSz,"+")
                            call add(s:pageSetList[g:pageno][2], strpart(l:szSz, 0, len(l:szSz) - 1) )
                        else
                            call add(s:pageSetList[g:pageno][1], l:szSz )
                        endif
                    endif
                endif
            endif
        else
            call add(s:pageSetList[g:pageno][1], '' )

        endif

        if len(a:szCommand) > 0
            let l:firstword = GetFirstWord(a:szCommand)
            if l:firstword == 'nnoremap' || l:firstword == 'inoremap' || l:firstword == 'command!'
                execute a:szCommand
            else
                execute 'nnoremap ' . a:szCommand
            endif
       endif

   endif
endfunction

"MODIFY

" *****************************************************************************************************
                " Folding
                " *************************************************************************************

" set foldcolumn=3
" set foldmethod=marker
" set foldlevelstart=20
" set foldlevelstart=20
set foldlevel=1
set foldmethod=marker


" *****************************************************************************************************
                " Auto Commands
                " *************************************************************************************
    augroup AUTOGROUPONE
        autocmd!
        "au BufNewFile,BufRead *.ses let s=g:SessionMan()
        " Automatically close the quickfix window when you select a line
        autocmd FileType qf nnoremap <buffer> <CR> <CR>:cclose<CR>

        " Create an autocommand to call the function after a quickfix window is opened
        " The 'qf' filetype is used to target the quickfix window
        autocmd FileType qf call QuickfixResize()
        

    augroup END

" *****************************************************************************************************
                " Session Setup
                " *************************************************************************************
if ( 1 == 1 ) 
    if ( argc() == 0 ) 
         augroup VIMAUTOGROUPA
             autocmd!
             autocmd VimEnter * :call LoadSession()
         augroup END
    endif
    if ( argc() == 1 ) 
         let s:n=match(argv(0), "vimsession$")
         if (s:n>0)
             let $VIMFIRSTFILE=argv(0)
             let s:temp = argv(0)
             let s:temp = substitute(s:temp, ".vimsession$", "", "")
             let $VIMSESSION=s:temp
             let $VIMWINDOW="NIL"
             let $VIMSPLIT="NIL"
             if ( 1 == 1 ) 
             augroup VIMAUTOGROUPB
                 autocmd!
                 autocmd VimEnter * :call LoadSession()
                 "autocmd VimEnter * :echom "POPEYE"
             augroup END
             endif
         endif
    endif
endif

"   ***************************************************************************************************
                " Jump to Last Position When Reopening a File
                " *************************************************************************************
   if has("autocmd")
      au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
      \| exe "normal! g'\"" | endif
   endif
function! s:SLine(msg)
    let save_statusline = &statusline  " Save the current statusline
    let &statusline = a:msg
    "let &statusline = save_statusline
endfunction
"
" wget -O ~/.vim/vim.txt https://raw.githubusercontent.com/archernar/basics/refs/heads/master/vim.txt
" nnoremap         <F7> :call g:FlashCard($HOME . "/.vim/1.fc")<cr>
" nnoremap <leader><F7> :call g:UnFlashCard()<cr>
function! g:Test()
    echom "TEST TEST TEST TEST"
endfunction

function! EditDotFiles()
        execute  "edit ~/.bashrc"
        execute  "edit ~/.vimrc"
        execute  "edit ~/.profile"
        execute  "edit ~/.vim/vimbrief.txt"
        execute  "edit ~/.vim/vim.txt"
endfunction
function! g:MultiToggleVoid()
        let g:multi_toggle_state = 0
endfunction

let g:multi_toggle_state = -1
let &statusline = "Void Mode"

" Map a key to call the function.  For example, map <Leader>u to it.
" You can choose any key combination you prefer.  <Leader> is often \.
" See :help leader for more about setting the leader key.
" Example:
"
" hello
"
"
" Option 1: Add the current file
nnoremap <leader>gaf :!git add %<CR>

" Option 2: Add the current file and stage changes
nnoremap <leader>gac :!git add % && git commit -m "Staged changes" <CR>

" Option 3: Add all changes in the current directory
nnoremap <leader>gaa :!git add .<CR>

" Option 4: Add all changes in the current directory and stage changes
nnoremap <leader>gss :!git add . && git commit -m "Staged all changes" <CR>

" Option 5: Add the current file and show git status
nnoremap <leader>gas :!git add %<CR>:!git status<CR>

" Option 6: Add all changes in the current directory and show git status
nnoremap <leader>gaas :!git add .<CR>:!git status<CR>

" Option 7: Add the current file and run a custom git command
"nnoremap <leader>gac :!git add % && git commit -m <C-r>=@%<CR><CR>

" Option 8: Add all changes in the current directory and run a custom git command
nnoremap <leader>gacc :!git add . && git commit -m <C-r>=getcwd()<CR><CR>


function! g:OpenReadOnlyFileExit()
    silent exe "bd!"
    echom ""
endfunction
function! g:BufferDelete(...)
        if (a:1 == 0)
            nnoremap <silent> <buffer> q     :call g:BufferDelete(1)<cr>
            nnoremap <silent> <buffer> <F1>  :call g:BufferDelete(1)<cr>
            nnoremap <silent> <buffer> <esc> :call g:BufferDelete(1)<cr>
        else
            silent exe "bd!"
        endif
    echom ""
endfunction
function! g:OpenReadOnlyFile(...)
        let l:filename = a:1
        exe "set nopaste"
        let l:f = l:filename
        if filereadable(l:f)
            " silent exe "tabnew " . l:f
            silent execute "edit " . l:f
            silent exe "set buftype=nowrite"
            nnoremap <silent> <buffer> q     :call g:OpenReadOnlyFileExit()<cr>
            nnoremap <silent> <buffer> <F1>  :call g:OpenReadOnlyFileExit()<cr>
            nnoremap <silent> <buffer> <esc> :call g:OpenReadOnlyFileExit()<cr>
            silent exe "normal gg0"
        endif
        exe "set paste"
endfunction

"https://www.baeldung.com/linux/vim-find-full-path-current-file#:~:text=The%20%25%20Register,%2C%20depending%20on%20the%20context).
"let l:command = "/usr/bin/git add " . expand('%') . ";git commit -m \"Update\"; git push origin master"
func! MenuCB(id, result)
    if ( a:result == 1 )
        let l:command = "git status > /tmp/out"
        call system(l:command)
        call UtilityPopUp("/tmp/out")
        "execute "new | r ! " . l:command
        "call g:BufferDelete(0)
    endif
    if ( a:result == 2 )
        let l:command = "/usr/bin/git add " . expand('%')
        execute "new | r ! " . l:command
        call g:BufferDelete(0)
    endif
    if ( a:result == 3 )
        let l:command = "git commit -m \"Update\""
        execute "new | r ! " . l:command
        call g:BufferDelete(0)
    endif
    if ( a:result == 4 )
        let l:command = "git push origin master"
        execute "new | r ! " . l:command
        call g:BufferDelete(0)
    endif
    if ( a:result == 5 )
        let l:command = "/usr/bin/git add " . expand('%') . ";git commit -m \"Update\"; git push origin master"
        execute "new | r ! " . l:command
        call g:BufferDelete(0)
    endif
    if ( a:result == 6 )
        let l:command = "./make"
        execute "new | r ! " . l:command
        call g:BufferDelete(0)
    endif
    if ( a:result == 7 )
        let l:command = "./deploy"
        execute "new | r ! " . l:command
        call g:BufferDelete(0)
    endif
    if ( a:result == 8 )
        call g:UtilityPopupCommand("df -h")
    endif
    if ( a:result == 9 )
        call g:UtilityBufferCommand("cat /usr/share/vim/vim82/doc/*.txt")
    endif
    if ( a:result == 10 )
        call g:UtilityBufferCommand("cat /usr/share/vim/vim82/doc/pop*.txt")
    endif

endfunc

func! DoNothingCB(id, result)
    let l:NOTHING=0
endfunc


" https://vi.stackexchange.com/questions/24462/what-are-the-new-popup-windows-in-vim-8-2
function! g:GitPopUp()
call popup_menu(['Status', 'add', 'commit', 'push', 'all', 'make', 'deploy','df','vim', 'pop' ], 
     \ #{ title: "Git", callback: 'MenuCBBuffer', line: 25, col: 40, 
     \ highlight: 'Question', border: [], close: 'click',  padding: [1,1,0,1]} )
endfunction




"
" ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
" Gemini AI Interface
" ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
"
function! InsertSystemOutput(command, query)
  " Run the system command and store the output in a variable.
  let output = system(a:command)

  " Get the current cursor position.
  let current_line = line('.')
  let current_col = col('.')

  " Insert the output into the buffer at the current cursor position.
  call append(current_line - 1, split(output, '\n'))

  let l:current_date = strftime("%Y-%m-%d")
  call writefile( ['', l:current_date] , "/tmp/gem.txt", "a") 
  call writefile( ['--------------------------------------'] , "/tmp/gem.txt", "a") 
  call writefile( ['New Gemini Query  --------------------'] , "/tmp/gem.txt", "a") 
  call writefile( ['--------------------------------------'] , "/tmp/gem.txt", "a") 
  call writefile( [ a:query, '' ]                            , "/tmp/gem.txt", "a") 
  let l:xx = split(output, '\n')
  call writefile( l:xx,                      "/tmp/gem.txt", "a")

  " Move the cursor to the end of the inserted text.
  let output_lines = len(split(output, '\n'))
  call cursor(current_line + output_lines, current_col)
endfunction

function! GetUserInput(prompt)
    " Displays a popup window and prompts the user to enter a string.
    " Compatible with Vim 8.2 (using inputdialog).
    " Args:    prompt (string): The prompt message to display in the popup.
    " Returns: string: The user's input, or an empty string if cancelled.
    let input = inputdialog(a:prompt, '')
    if input == ''
      return "" " User cancelled
    else
      return input
    endif
endfunction

function! Gemini()
    let l:dq="\""
    let l:szIn = GetUserInput("Gemini prompt: ")
    if l:szIn != ""
      let l:sz = "/home/mestes/scm/private/qg " . l:dq . l:szIn . l:dq . " | fold -sw 80"
      call InsertSystemOutput(l:sz, l:szIn)
    else
      echo "Input cancelled."
    endif
  return 0
endfunction

" https://vi.stackexchange.com/questions/24462/what-are-the-new-popup-windows-in-vim-8-2
"
" ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
" Vim Buffer Popup
" ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

let g:buffernames=[]
let g:bufferdisplaynames=[]

function! g:SplitBuffers()
    let l:last_bufno = bufnr("$")
    let l:i = 1
    let l:filenames = ""
    let l:filename  = ""

    let g:VimBufferPopUp_Init=1
    while l:i < l:last_bufno
        if bufexists(i) && buflisted(i)
            let fullpath = fnamemodify(bufname(i), ':p')
            if filereadable(fullpath)
                if v:version >= 702
                    let l:filename = fnameescape(fullpath)
                    let l:filenames = l:filenames . " " . fnameescape(fullpath)
                else
                    let l:filename  = fullpath
                    let l:filenames = l:filenames . " " . fullpath
                endif
            endif
            execute "split"
            execute "bnext "
        endif
        let l:i = l:i + 1
    endwhile
    execute "wincmd t"
    normal! 0
endfunction
function! g:VimBufferPopUpLoader()
    let l:last_bufno = bufnr("$")
    let l:i = 1
    let l:filenames = ""
    let l:filename  = ""

    let g:buffernames=[]
    let g:bufferdisplaynames=[]

    let g:VimBufferPopUp_Init=1
    while l:i <= l:last_bufno
        if bufexists(i) && buflisted(i)
            let fullpath = fnamemodify(bufname(i), ':p')
            if filereadable(fullpath)
                if v:version >= 702
                    let l:filename = fnameescape(fullpath)
                    let l:filenames = l:filenames . " " . fnameescape(fullpath)
                else
                    let l:filename  = fullpath
                    let l:filenames = l:filenames . " " . fullpath
                endif
            endif
            call add(g:bufferdisplaynames, fnamemodify(l:filename, ":t") )
            call add(g:buffernames, l:filename )
        endif
        let l:i = l:i + 1
    endwhile
endfunction


function! g:VimBufferPopUp()
    let l:last_bufno = bufnr("$")
    let l:i = 1
    let l:filenames = ""
    let l:filename  = ""

if !exists('g:VimBufferPopUp_Init')
let g:VimBufferPopUp_Init=1

    while l:i <= l:last_bufno
        if bufexists(i) && buflisted(i)
            let fullpath = fnamemodify(bufname(i), ':p')
            if filereadable(fullpath)
                if v:version >= 702
                    let l:filename = fnameescape(fullpath)
                    let l:filenames = l:filenames . " " . fnameescape(fullpath)
                else
                    let l:filename  = fullpath
                    let l:filenames = l:filenames . " " . fullpath
                endif
            endif
            call add(g:bufferdisplaynames, fnamemodify(l:filename, ":t") )
            call add(g:buffernames, l:filename )
        endif
        let l:i = l:i + 1
    endwhile

endif 

    call popup_menu(g:bufferdisplaynames, 
    \ #{ title: "Vim Buffers", callback: 'MenuCBBuffer', line: 25, col: 40, 
    \ highlight: 'Question', border: [], close: 'click',  padding: [1,1,0,1]} )
endfunction


" 1. Define a function to run *when* the list changes.
"function! s:HandleBufferListChange()
"    Put your logic here. For demonstration, we'll just echo.
"   call  g:VimBufferPopUpLoader()
"   let l:NOTHING=0
"endfunction

" 2. Create an autocommand group to hold our listeners.
"augroup DetectBufferSetChange
"    autocmd! " Clear any existing autocommands in this group
"    3. Attach the function to the events.
"    Run when a new buffer is added to the list.
"    autocmd BufAdd * call s:HandleBufferListChange()
"    Run when a buffer is permanently wiped out.
"    autocmd BufWipeout * call s:HandleBufferListChange()
"augroup END


func! MenuCBBuffer(id, result)
    if ( a:result > -1 ) 
        execute "e " . g:buffernames[a:result-1]
        call MoveToFront(g:buffernames, a:result-1)
        call MoveToFront(g:bufferdisplaynames, a:result-1)
        "echom "POPEYE" . "  " . a:result
    endif
endfunction
" ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
" ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

function! LocalSetups()
    setlocal iskeyword=@,48-57,_,192-255,.
endfunction
command! SPEC      :call LocalSetups() 
command! LOC       :call LocalSetups() 
command! LOCAL     :call LocalSetups() 
call LocalSetups() 

source ~/.macros.vim



" ----------------------------------------------------------------------------
"  Section 6: File Management & Backups
" ----------------------------------------------------------------------------

" --- Persistent Undo ---
" Keep undo history even after closing a file
set undofile
set undodir=~/.vim/undo
" Create the directory if it doesn't exist
silent !mkdir -p ~/.vim/undo

" ----------------------------------------------------------------------------
"  Section 7: Key Mappings (Quality of Life)
" ----------------------------------------------------------------------------

" *****************************************************************************************************
                " Remaps
                " Note: `nnoremap` means "non-recursive normal mode map".
                " It's the safest way to map keys.
                " --- Fast Escape ---
                " Use `jj` to exit Insert mode. Much faster than reaching for Esc.
                " *************************************************************************************
"
call g:Commander("", "Help" )
call g:Commander("", "Help+" )
call g:Commander("", "Help++" )
call g:Commander("", "Help+++" )
call g:Commander("", "Help++++" )

call g:Commander("<F1>          :cclose<cr>:bnext<cr>",      " F1 - Next Buffer" )
call g:Commander("<leader><F1>  <C-w>w",                     "+F1 - Next Split")
call g:Commander('', '')
call g:Commander("<F2>          :call VimBufferPopUp()<CR>", " F2 - Vim Buffer PopUp" )
call g:Commander("<F3>          :call HelpPopUp()<CR>",      " F3 - Help Popup" )
call g:Commander('', '')
call g:Commander("<F5>          :call ProgramCompile()<cr>", " F5 - Program Compile")
call g:Commander("<F6>          :call ProgramRun()<cr>",     " F6 - Program Run")
call g:Commander("<leader><F6>  :cclose<cr>",                "+F6 - Close QuickFix")
call g:Commander("<F7> :call g:MultiToggleVoid()<CR>",         " F7 - Multi-Toggle")
call g:Commander("<F8> :call g:MultiToggle()<CR>",             " F8 - Toggle Multi-Toggle")
call g:Commander("<F9> :call UtilityPopUp('/home/mestes/vim.txt')<CR>", " F9 - Utility Popup")
call g:Commander("<F12> :call g:NextHelpPage()<cr>",           " Set Next Help")
call g:Commander('', '')
call g:Commander("<Leader>p     :PluginUpdate<cr>",          "+p  - Plugin Update")

" --- Buffer & Tab Navigation ---
call g:Commander("<leader>b :bnext<CR>",                     "+b  - Next buffer")
call g:Commander("<leader>k :bprev<CR>",                     "+k  - Previous buffer")
call g:Commander("<leader>d :bdelete<CR>",                   "+d  - Close buffer")
call g:Commander("<leader>t :tabnew<CR>",                    "+t  - New tab")
call g:Commander('', '')

" --- Window (Split) Management ---
call g:Commander("<leader>vs  :call g:HSplit(2)<CR>",  "+vs - Vertical split")
call g:Commander("<leader>hs  :call g:VSplit(2)<CR>",  "+hs - Horizontal split")
call g:Commander("<leader>ss  :call g:VSplit(2)<CR>",  "+ss - Horizontal split")
call g:Commander("<leader>ns  :call g:NoSplits()<CR>", "+ns - Close all splits")
call g:Commander("<leader>as  :call g:SplitBuffers()<CR>", "+ss - All splits")

" Navigate splits using Ctrl + (h,j,k,l)
call g:Commander("<C-h> <C-w>h",           "^h   - Mv Sp-Left+")
call g:Commander("<C-j> <C-w>j",           "^j   - Mv Sp-Down+")
call g:Commander("<C-k> <C-w>k",           "^k   - Mv Sp-Up+")
call g:Commander("<C-l> <C-w>l",           "^l   - Mv Sp-Right+")
call g:Commander("<leader><Left> <C-w>h",  "+<L> - Mv Sp-Left+")
call g:Commander("<leader><Down> <C-w>j",  "+<D> - Mv Sp-Down+")
call g:Commander("<leader><Up> <C-w>k",    "+<U> - Mv Sp-Up+")
call g:Commander("<leader><Right> <C-w>l", "+<R> - Mv Sp-Right+")

call g:Commander("<leader>gaf  :!git add %<CR>","git add++")
call g:Commander("<leader>gac  :!git add % && git commit -m 'Staged changes' <CR>","git add and commit++")
call g:Commander("<leader>gaa  :!git add .<CR>","git add .++")
call g:Commander("<leader>gss  :!git add . && git commit -m 'Staged all changes' <CR>","git add . and commit++")
call g:Commander("<leader>gas  :!git add %<CR>:!git status<CR>","git add and status++")
call g:Commander("<leader>gaas :!git add .<CR>:!git status<CR>","git add . and status++")

call g:Commander("",                                ":sp  <fn> - edit in split+++" )
call g:Commander("",                                ":vsp <fn> - edit in vsplit+++" )
call g:Commander("",                                " gv       - remember last select+++" )
call g:Commander("",                                "Sgq       - breaks down long line+++" )
call g:CommanderText(" %        - jumps to the match prn,brckt,brc+++")
call g:CommanderText(" ci<obj>  - changes inside a text object+++")
call g:CommanderText("--- Ex Commands++++")
call g:CommanderText(":wincmd h","Cursor to win-left++++")
call g:CommanderText(":wincmd j","Cursor to win-below++++")
call g:CommanderText(":wincmd k","Cursor to win-above++++")
call g:CommanderText(":wincmd l","Cursor to win-right++++")
call g:CommanderText(":wincmd w","Cycle next win++++")
call g:CommanderText(":wincmd p","Go to the prev active win++++")
call g:CommanderText(":wincmd =","All winds equal size++++")
call g:CommanderText(":wincmd _","Max wind height++++")
call g:CommanderText(":wincmd |","Max wind width++++")
call g:CommanderText(":wincmd H","Mv wind far left++++")
call g:CommanderText(":wincmd J","Mv wind very bottom++++")
call g:CommanderText(":wincmd K","Mv wind very top++++")
call g:CommanderText(":wincmd L","Mv wind far right++++")
call g:Commander("inoremap jj <Esc>",                        " jj - <ESC>+++")
call g:CommanderText("+++")
call g:CommanderText("--- Commands+++")
call g:Commander("command! Gemini   :call Gemini()<cr>",     "Gemini+++")
call g:Commander("command! Gem      :call Gemini()<cr>",     "Gem+++")
call g:Commander("command! GEM      :call Gemini()<cr>",     "GEM+++")
call g:Commander("command! SESSION  :call CaptureSession()", "SESSION+++") 
call g:Commander("command! -nargs=+ GREP    call GrepPopUp(<q-args>)<cr>", "GREP+++")
call g:Commander("command! -nargs=+ POPGREP call GrepPopUp(<q-args>)<cr>", "POPGREP+++")

call g:CommanderText("+++")
call g:CommanderText("--- Sets+++")
call g:CommanderText("set nu!", "Toggle screen mumbering+++")
call g:CommanderText("+++")
call g:CommanderText("--- Scrolling+++")
call g:CommanderText("CTRL-F","Scroll forward full screen+++")
call g:CommanderText("CTRL-B","Scroll backward full screen+++")
call g:CommanderText("CTRL-D","Scroll down (forward) half screen+++")
call g:CommanderText("CTRL-U","Scroll up (backward) half screen+++")
call g:CommanderText("CTRL-E","Scroll down one line+++")
call g:CommanderText("CTRL-Y","Scroll up one line+++")
call g:CommanderText("zz","Center the current line on screen+++")
call g:CommanderText("zt","Mv current line to the top of screen+++")
call g:CommanderText("zb","Mv current line to the bottom of screen+++")

"Key Sequence","Description"
".","Repeats the last change (insert, delete, change, replace)."
"CTRL-A / CTRL-X","In normal mode, increments (CTRL-A) or decrements (CTRL-X) the number under the cursor."
"CTRL-O / CTRL-I","In normal mode, navigates the jump list backward (CTRL-O) or forward (CTRL-I)."
"ci<object>","Changes inside a text object (e.g., ci"" changes inside quotes, ci( changes inside parentheses)."
"gv","In normal mode, re-selects the last visual selection."
"CTRL-O (in Insert Mode)","Executes a single normal mode command and immediately returns to insert mode."
"gi","In normal mode, moves the cursor to the last insert position and enters insert mode."
"* / #","In normal mode, searches forward (*) or backward (#) for the word under the cursor."
"%","In normal mode, jumps to the matching parenthesis, bracket, or brace."
":noh","Clears the search highlighting from the last search."

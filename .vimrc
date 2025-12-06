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

 set relativenumber
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
let s:pageno = 1

function! g:NextHelpPage()
    let s:pageno = s:pageno + 1
    if s:pageno > 4
        let s:pageno = 1
    endif
    echom "Help Page Number " . s:pageno
    call HelpPopUp()
endfunction


let s:helpdisplaynames=[]
let s:helpdisplaynames2=[]
let s:helpdisplaynames3=[]
let s:helpdisplaynames4=[]
let s:helpdisplaynames5=[]
"for i in range(1, 10)
"    call add(s:helpdisplaynames3, "|" )
"endfor
"MODIFY
"
"let s:pageSetList[3][1] = readfile("zed",'',12)
function! g:HelpPopUpInit()
    let s:pageno = 0
    call g:HelpPopUp()
endfunction

function! g:HelpPopUp()
        let l:MAX = 5
        let s:pageno = s:pageno + 1
        if s:pageno > l:MAX 
            let s:pageno = 1
        endif

    "let maxLen = max([len1, len2])
    let l:maxLen = -100
    let l:maxLen = max([len(s:pageSetList[s:pageno][1]), l:maxLen])
    let l:maxLen = max([len(s:pageSetList[s:pageno][2]), l:maxLen])
    let l:maxLen = max([len(s:pageSetList[s:pageno][3]), l:maxLen])
    let l:maxLen = max([len(s:pageSetList[s:pageno][4]), l:maxLen])
    let l:maxLen = max([len(s:pageSetList[s:pageno][5]), l:maxLen])

    let l:fullsize = l:maxLen
    for i in range(1, l:fullsize-len(s:pageSetList[s:pageno][1]))
        call add(s:pageSetList[s:pageno][1], "" )
    endfor
    for i in range(1, l:fullsize-len(s:pageSetList[s:pageno][2]))
        call add(s:pageSetList[s:pageno][2], "" )
    endfor
    for i in range(1, l:fullsize-len(s:pageSetList[s:pageno][3]))
        call add(s:pageSetList[s:pageno][3], "" )
    endfor
    for i in range(1, l:fullsize-len(s:pageSetList[s:pageno][4]))
        call add(s:pageSetList[s:pageno][4], "" )
    endfor
    for i in range(1, l:fullsize-len(s:pageSetList[s:pageno][5]))
        call add(s:pageSetList[s:pageno][5], "" )
    endfor

    let l:temp1 =  ConcatStringLists(g:PadStrings(s:pageSetList[s:pageno][1]), g:PadStrings(s:pageSetList[s:pageno][2]))
    let l:temp2 =  ConcatStringLists(l:temp1, g:PadStrings(s:pageSetList[s:pageno][3]))
    let l:temp3 =  ConcatStringLists(l:temp2, g:PadStrings(s:pageSetList[s:pageno][4]))
    let l:arr   =  ConcatStringLists(l:temp3, g:PadStrings(s:pageSetList[s:pageno][5]))

    let l:szTitle = " Help " . s:pageno . " "
    call g:PopMeUp(l:arr, l:szTitle, 'HelpPopUpCustomFilter')

endfunction

func MyFilter100(winid, key)
      let l:MAX=3
      if a:key ==# "\<Esc>"
	    call popup_close(a:winid)
	    return 1
	  endif
      if a:key ==# "\x1b"
	    call popup_close(a:winid)
	    return 1
	  endif
	  if a:key == 'x'
	    call popup_close(a:winid)
	    return 1
	  endif

	  if a:key == "\<F12>"
	    call popup_close(a:winid)
        let s:pageno = s:pageno + 1
        if s:pageno > l:MAX 
            let s:pageno = 1
        endif
        call HelpPopUp()
	    " do something
	    return 1
	  endif

	  if a:key == 'c'
	    call popup_close(a:winid)
        let s:pageno = s:pageno + 1
        if s:pageno > l:MAX 
            let s:pageno = 1
        endif
        call HelpPopUp()
	    return 1
	  endif

	  return 0
endfunc


func! g:CommanderDash(...)
    call add(s:pageSetList[s:pageno][a:1 + 1], '----' )
endfunc
func! g:CommanderSpace(...)
    call add(s:pageSetList[s:pageno][a:1 + 1], '' )
endfunc
func! g:CommanderText(...)
    if a:0 == 2
        call add(s:pageSetList[s:pageno][a:1 + 1], a:2 )
    else
        if a:0 == 3
            call add(s:pageSetList[s:pageno][a:1 + 1], a:2 . " - " . a:3)
        endif
    endif
endfunc


func! g:CommanderTextxx(...)
    if a:0 == 1
        call g:Commander('', a:1)
    else
        if a:0 == 2
            call g:Commander('', a:1 . " - " . a:2)
        else
            if a:0 == 3
                let l:sz = ""
                if a:1 == 0
                    let l:sz = ""
                endif
                if a:1 == 1
                    let l:sz = "+"
                endif
                if a:1 == 2
                    let l:sz = "++"
                endif
                if a:1 == 3
                    let l:sz = "+++"
                endif
                if a:1 == 4
                    let l:sz = "++++"
                endif
                if a:1 == 5
                    let l:sz = "+++++"
                endif

                if a:2 == ""
                    call g:Commander('', a:3 . l:sz)
                else
                    call g:Commander('', a:2 . " - " . a:3 . l:sz)
                endif
            endif
        endif
    endif
endfunction

function! g:Commander(...)
    if a:0 == 3
        let l:nCol      = a:1
        let l:szCommand = a:2
        let l:szHelp    = a:3

        if len(l:szHelp) > 0
            let l:szSz = CapitalizeWords(l:szHelp)
            call add(s:pageSetList[s:pageno][l:nCol + 1], l:szSz)
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
      let l:sz = $HOME . "/scm/private/qg " . l:dq . l:szIn . l:dq . " | fold -sw 80"
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


function! g:VimBufferPopUp()
    " let l:buffer_list = getbufinfo()
    " let listed_buffers = getbufinfo({'buflisted': 1})
    " let l:buffer_names = map(getbufinfo({'buflisted': 1}), 'v:val.name')
    let l:last_bufno  = bufnr("$")
    let l:i = 1
    let l:filenames = ""
    let l:filename  = ""
    let l:a1  = [] 
    let l:a2  = [] 
    let l:arr  = [] 
    " Notes
    " let buffer_list = getbufinfo()
    " buffer_list is a list of dictionaries.
    " Example element:
    " {'bufnr': 1, 'changed': 0, 'filetype': 'vim', 'hidden': 0, 'lnum': 1, 'name': '/path/to/file.vim', 'listed': 1, 'windows': [5001]}
    " Get info for buffers that are 'listed' (like :ls output)
    " let listed_buffers = filter(getbufinfo(), 'v:val.listed')
    " Or, more efficiently in recent Vim versions:
    " let listed_buffers = getbufinfo({'buflisted': 1})
    " Get a list of the names of all listed buffers
    " let buffer_names = map(getbufinfo({'buflisted': 1}), 'v:val.name')
    " Display the result (for demonstration)
    while l:i <= l:last_bufno
        if bufexists(i) && buflisted(i)
            let l:fullpath = fnamemodify(bufname(i), ':p')
            if filereadable(l:fullpath)
               call add(l:a1, bufname(i))
               call add(l:a2, l:fullpath)
            endif
        endif
        let l:i = l:i + 1
    endwhile
    " #{ title: "Vim Buffers", callback: 'MenuCBBuffer', line: 25, col: 40, 
    let l:arr =  ConcatStringLists(g:PadStrings(l:a1), g:PadStrings(l:a2))

    call g:PopMeUp(l:arr, "Buffers")

endfunction


" 1. Define a function to run *when* the list changes.
"function! s:HandleBufferListChange()
"    Put your logic here. For demonstration, we'll just echo.
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


func! MenuCBDoNothing(id, result)
    let l:NOTHING=0
endfunction
func! MenuCBBuffer(id, result)
    if ( a:result > -1 ) 
        execute "e " . g:buffernames[a:result-1]
        call MoveToFront(g:buffernames, a:result-1)
        call MoveToFront(g:bufferdisplaynames, a:result-1)
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
for i in range(0, 4)
    call g:CommanderText(i, "Help" )
    call g:CommanderDash(i)
endfor


call g:Commander(0, "<F1>         :cclose<cr>:bnext<cr>",       " F1 - Next Buffer" )
call g:Commander(0, "<leader><F1> <C-w>w",                      "+F1 - Next Split")
call g:Commander(0, "<F2>         :call VimBufferPopUp()<CR>",  " F2 - Vim Buffer PopUp" )
call g:Commander(0, "<F3>         :call HelpPopUpInit()<CR>",   " F3 - Help Popup" )
call g:Commander(0, "<F5>         :call ProgramCompile()<cr>",  " F5 - Program Compile")
call g:Commander(0, "<F6>         :call ProgramRun()<cr>",      " F6 - Program Run")
call g:Commander(0, "<leader><F6> :cclose<cr>",                 "+F6 - Close QuickFix")
call g:Commander(0, "<F7> :call g:MultiToggleVoid()<CR>",       " F7 - Multi-Toggle")
call g:Commander(0, "<F8> :call g:MultiToggle()<CR>",           " F8 - Toggle Multi-Toggle")
call g:Commander(0, "<F9> <esc>:call g:FilePopUp(g:GUF())<CR>", " F9 - Utility Popup")
call g:Commander(0, "<Leader>p     :PluginUpdate<cr>",          "+p  - Plugin Update")
call g:CommanderSpace(0)
call g:Commander(0, "<leader>b :bnext<CR>",                     "+b  - Next buffer")
call g:Commander(0, "<leader>k :bprev<CR>",                     "+k  - Previous buffer")
call g:Commander(0, "<leader>d :bdelete<CR>",                   "+d  - Close buffer")
call g:Commander(0, "<leader>t :tabnew<CR>",                    "+t  - New tab")

" --- Window (Split) Management ---
call g:Commander(1, "<leader>vs  :call g:HSplit(2)<CR>",  "+vs     - Vertical split")
call g:Commander(1, "<leader>hs  :call g:VSplit(2)<CR>",  "+hs     - Horizontal split")
call g:Commander(1, "<leader>ss  :call g:VSplit(2)<CR>",  "+ss     - Horizontal split")
call g:Commander(1, "<leader>ns  :call g:NoSplits()<CR>", "+ns     - Close all splits")
call g:Commander(1, "<leader>as  :call g:SplitBuffers()<CR>", "+ss     - All splits")
call g:CommanderSpace(1)
" Navigate splits using Ctrl + (h,j,k,l)
call g:Commander(1, "<C-h> <C-w>h",           "^h      - Mv Split-Left")
call g:Commander(1, "<C-j> <C-w>j",           "^j      - Mv Split-Down")
call g:Commander(1, "<C-k> <C-w>k",           "^k      - Mv Split-Up")
call g:Commander(1, "<C-l> <C-w>l",           "^l      - Mv Split-Right")
call g:Commander(1, "<leader><Left> <C-w>h",  "+<L>    - Mv Split-Left")
call g:Commander(1, "<leader><Down> <C-w>j",  "+<D>    - Mv Split-Down")
call g:Commander(1, "<leader><Up> <C-w>k",    "+<U>    - Mv Split-Up")
call g:Commander(1, "<leader><Right> <C-w>l", "+<R>    - Mv Split-Right")
call g:CommanderSpace(1)
call g:CommanderText(1,                       ":sp <f> - edit in split")
call g:CommanderText(1,                       ":vsp    - edit in vsplit")
call g:CommanderText(1,                       "gv      - remember last select")
call g:CommanderText(1,                       "Sgq     - breaks down long line")
call g:CommanderText(1,                       "%       - jump to match ( { [")
call g:CommanderText(1,                       "ci<obj> - chg inside text obj")
call g:CommanderSpace(1)


call g:Commander(2, "<leader>gaf  :!git add %<CR>","git add++")
call g:Commander(2, "<leader>gac  :!git add % && git commit -m 'Staged changes' <CR>","git add and commit++")
call g:Commander(2, "<leader>gaa  :!git add .<CR>","git add .++")
call g:Commander(2, "<leader>gss  :!git add . && git commit -m 'Staged all changes' <CR>","git add . and commit++")
call g:Commander(2, "<leader>gas  :!git add %<CR>:!git status<CR>","git add and status++")
call g:Commander(2, "<leader>gaas :!git add .<CR>:!git status<CR>","git add . and status++")


call g:CommanderText(3, "--- Ex Commands")
call g:CommanderText(3, ":wincmd h","Cursor to win-left")
call g:CommanderText(3, ":wincmd j","Cursor to win-below")
call g:CommanderText(3, ":wincmd k","Cursor to win-above")
call g:CommanderText(3, ":wincmd l","Cursor to win-right")
call g:CommanderText(3, ":wincmd w","Cycle next win")
call g:CommanderText(3, ":wincmd p","Go to the prev active win")
call g:CommanderText(3, ":wincmd =","All winds equal size")
call g:CommanderText(3, ":wincmd _","Max wind height")
call g:CommanderText(3, ":wincmd |","Max wind width")
call g:CommanderText(3, ":wincmd H","Mv wind far left")
call g:CommanderText(3, ":wincmd J","Mv wind very bottom")
call g:CommanderText(3, ":wincmd K","Mv wind very top")
call g:CommanderText(3, ":wincmd L","Mv wind far right")
call g:Commander("inoremap jj <Esc>",                        " jj - <ESC>")
call g:CommanderText("")
call g:CommanderText("--- Commands")
call g:Commander(3, "command! Gemini   :call Gemini()<cr>",     "Gemini")
call g:Commander(3, "command! Gem      :call Gemini()<cr>",     "Gem")
call g:Commander(3, "command! GEM      :call Gemini()<cr>",     "GEM")
call g:Commander(3, "command! SESSION  :call CaptureSession()", "SESSION") 
call g:Commander(3, "command! -nargs=+ GREP    call GrepPopUp(<q-args>)<cr>", "GREP")
call g:Commander(3, "command! -nargs=+ POPGREP call GrepPopUp(<q-args>)<cr>", "POPGREP")

" Define the command :RunScript
" call g:Commander("<F9> :call system('ls -la > /tmp/files.txt')<cr>",           " Test Command")
"
call Commander(3, "command! -nargs=1 CLI call system( <q-args> . ' > /tmp/files.txt  ') | call FilePopUp('/tmp/files.txt', 'System','FilesDotTxtPopUpCustomFilter')", "CLI+++")
let s:pageno = 1
call g:CommanderText(2,"","")
call g:CommanderText(2,"","")
call g:CommanderText(2,"","")
call g:CommanderText(2, "set nu!", "Toggle scrn #s")
call g:CommanderText(2,"","")
call g:CommanderText(2, "", "--- Scrolling")
call g:CommanderText(2, "C-F","Scrl fwd full scrn")
call g:CommanderText(2, "C-B","Scrl bck full scrn")
call g:CommanderText(2, "C-D","Scrl dn (fwd) half scrn")
call g:CommanderText(2, "C-U","Scrl up (bck) half scrn")
call g:CommanderText(2, "C-E","Scrl dn 1 line")
call g:CommanderText(2, "C-Y","Scrl up 1 line")
call g:CommanderText(2, "zz","Center crnt")
call g:CommanderText(2, "zt","Mv crnt line top scrn")
call g:CommanderText(2, "zb","Mv crnt line bot scrn")
let s:pageno = 1

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

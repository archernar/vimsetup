
function g:LogMessage(...)
    let l:ret = 0

    let l:messages=[]
    call add(l:messages, a:1)
    call writefile(l:messages, "/tmp/vimscript.log", "a")
    return l:ret
endfunction
" Function: SplitStringOnce(mainString, delimiter)
" Description: Splits a string into two pieces based on the first
"              occurrence of a delimiter string.
" Arguments:
"   mainString (String): The string to be split.
"   delimiter (String):  The string to use as the split point.
" Returns:
"   (List): A list containing two strings: [before, after].
"           If the delimiter is not found or is empty,
"           returns [mainString, ""].
function! SplitStringOnce(mainString, delimiter)
  " If the delimiter is empty, we can't split.
  " Return the original string as the 'before' part.
  if empty(a:delimiter)
    return [a:mainString, ""]
  endif

  " Find the byte index of the first occurrence of the delimiter.
  " stridx() is 0-based.
  let index = stridx(a:mainString, a:delimiter)

  " Check if the delimiter was found.
  if index == -1
    " Delimiter not found.
    return [a:mainString, ""]
  else
    " Delimiter was found.
    " Extract the part before the delimiter.
    " String slicing [s:e] is inclusive.
    let l:before = a:mainString[0 : index - 1]

    " Calculate the starting index of the 'after' part.
    let l:after_start = index + strlen(a:delimiter)
    
    " Extract the part after the delimiter to the end of the string.
    let l:after = a:mainString[l:after_start :]

    return [l:before, l:after]
  endif
endfunction



function! CapitalizeWords(inputString)
  " Use substitute() to find the beginning of each word ('\<\w')
  " and replace it with its uppercase version ('\u&').
  " '\<' matches the beginning of a word.
  " '\w' matches any word character.
  " '\u' makes the next character uppercase.
  " '&' refers to the entire matched text (the single character).
  " 'g' flag ensures all matches in the line are replaced.
  let l:arr = SplitStringOnce(a:inputString, " - ")
  return l:arr[1] == "" ? l:arr[0] : l:arr[0] . " - " . substitute(l:arr[1], '\<\w', '\u&', 'g')
endfunction

                
" Function to check if a:haystack ends with a:needle
function! EndsWith(haystack, needle)
  let l:len_haystack = strlen(a:haystack)
  let l:len_needle = strlen(a:needle)

  " If the needle is longer than the haystack, it can't be the tail.
  if l:len_needle > l:len_haystack
    return 0
  endif

  " Extract the tail of the haystack, with the same length as the needle.
  " strpart(str, start_index) extracts from start_index to the end.
  let l:tail = strpart(a:haystack, l:len_haystack - l:len_needle)

  " Compare the tail with the needle.
  " ==? performs a case-sensitive comparison.
  " Use ==# for case-insensitive.
  return l:tail ==? a:needle
endfunction


" Vimscript function to pad an array of strings to a uniform length.
"
" This function takes a list of strings, finds the longest string in
" the list, and then pads each string with spaces so that all strings
" have a length equal to the (longest string's length + 2).

function! g:PadStrings(stringList)
  let l:ret = []
  " Check if the list is empty. If so, return an empty list.
  if empty(a:stringList)
    return []
  endif

  " 1. Calculate the target length
  let l:mx = -1
  for item in a:stringList
      let l:ll = len(item)
      if l:ll > l:mx
          let l:mx = l:ll
     endif
  endfor
  let l:tx = l:mx + 3

  " 2. pad the new list
  for item in a:stringList
      call add(l:ret, item . repeat(" ", l:tx - len(item)) )
  endfor
  "call add(l:ret, '' . repeat(" ", l:tx - 0) )

  " 3. Return the new list
  return l:ret
endfunction




"
" Concatenates strings from two lists element-by-element.
"
" Takes two lists of strings (list1 and list2).
" Returns a new list where each element is the concatenation of the
" corresponding elements from list1 and list2.
"
" If one list is shorter than the other, it behaves as if the shorter
" list is padded with empty strings.
"
function! ConcatStringLists(list1, list2)
    let result = []
    
    " Determine the length of the longer list
    let len1 = len(a:list1)
    let len2 = len(a:list2)
    let maxLen = max([len1, len2])

    " Handle the case of two empty lists
    if maxLen == 0
        return []
    endif

    " Loop up to the length of the longer list
    for i in range(maxLen)
        " Use get() to safely access elements.
        " If the index 'i' is out of bounds for a list, get() will
        " return the default value, which we set to "".
        let s1 = get(a:list1, i, "")
        let s2 = get(a:list2, i, "")

        " Concatenate the two strings (Vimscript 8 uses .) and add to result
        call add(result, s1 . s2)
    endfor

    return result
endfunction

" Description: A Vimscript function to extract the first 
"              whitespace-delimited word from a given string.

" Define the function. In Vimscript, functions must start
" with an uppercase letter if they are global.
function! GetFirstWord(input_string)
    " a:input_string refers to the first argument passed to the function.
    
    " The split() function, when called with just one argument,
    " splits the string by whitespace and returns a List of words.
    " It automatically handles leading/trailing/multiple whitespace.
    let l:word_list = split(a:input_string)
    
    " Check if the list of words is not empty.
    " If the input string was empty or only contained whitespace,
    " the list will be empty.
    if len(l:word_list) > 0
        " Return the first item from the list (which is at index 0).
        return l:word_list[0]
    else
        " If the list is empty, return an empty string.
        return ""
    endif
endfunction

" +++++++++++++++++++++"
" Concatenates strings from two lists element-by-element.
"
" Takes two lists of strings (list1 and list2).
" Returns a new list where each element is the concatenation of the
" corresponding elements from list1 and list2.
"
" If one list is shorter than the other, it behaves as if the shorter
" list is padded with empty strings.
"
function! ConcatStringLists(list1, list2)
    let result = []
    
    " Determine the length of the longer list
    let len1 = len(a:list1)
    let len2 = len(a:list2)
    let maxLen = max([len1, len2])

    " Handle the case of two empty lists
    if maxLen == 0
        return []
    endif

    " Loop up to the length of the longer list
    for i in range(maxLen)
        " Use get() to safely access elements.
        " If the index 'i' is out of bounds for a list, get() will
        " return the default value, which we set to "".
        let s1 = get(a:list1, i, "")
        let s2 = get(a:list2, i, "")

        " Concatenate the two strings (Vimscript 8 uses .) and add to result
        call add(result, s1 . s2)
    endfor

    return result
endfunction

function! ToLowerUnderCursor()
  " Get the current cursor position.
  let [row, col] = getpos('.')[1:2]

  " Get the character under the cursor.
  let char = getline(row)[col-1]

  " Check if a character exists at the cursor position (not end of line).
  if char != ""

    " Convert the character to lowercase.
    let lower_char = tolower(char)

    " Replace the character under the cursor with the lowercase version.
    call setline(row, strpart(getline(row), 0, col-1) . lower_char . strpart(getline(row), col))

    " Restore the cursor position (important!).
    call cursor(row, col)
  endif
endfunction
function! ToUpperUnderCursor()
  " Get the current cursor position.
  let [row, col] = getpos('.')[1:2]

  " Get the character under the cursor.
  let char = getline(row)[col-1]

  " Check if a character exists at the cursor position (not end of line).
  if char != ""

    " Convert the character to uppercase.
    let upper_char = toupper(char)

    " Replace the character under the cursor with the uppercase version.
    call setline(row, strpart(getline(row), 0, col-1) . upper_char . strpart(getline(row), col))

    " Restore the cursor position (important!).
    call cursor(row, col)
  endif
endfunction
function g:HSplit(...)
    let l:i = 0
    let l:bc = a:1 - 1
    while l:i < l:bc 
        execute "split"
        execute "bnext"
        let l:i = l:i + 1
    endwhile
    execute "wincmd t"
    normal! 0
endfunction
function g:VSplit(...)
    let l:i = 0
    let l:bc = a:1 - 1
    while l:i < l:bc 
        execute "vsplit"
        execute "bnext"
        let l:i = l:i + 1
    endwhile
    execute "wincmd t"
    normal! 0
endfunction
function g:NoSplits()
    execute "only"
    normal! 0
endfunction
" Function to reorder a list, moving the element at a:index to the front (index 0).
"
" Args:
"   a:list (List): The list to be modified. This list is modified IN-PLACE.
"   a:index (Number): The 0-based index of the element to move to the front.
"
" Returns:
"   (List): The modified list.
function! MoveToFront(list, index)
    " Get the length of the list
    let l:list_len = len(a:list)

    " --- Input Validation ---
    " Check if the list is empty
    if l:list_len == 0
        echoerr "MoveToFront: Cannot operate on an empty list."
        return a:list
    endif

    " Check if the index is within the valid bounds
    if a:index < 0 || a:index >= l:list_len
        echoerr "MoveToFront: Index " . a:index . " is out of bounds for list of length " . l:list_len
        return a:list " Return the list unmodified
    endif

    " If the item is already at the front, there's nothing to do.
    if a:index == 0
        return a:list
    endif

    " --- Reordering Logic ---
    " 1. Remove the element at the specified index.
    "    remove() returns the removed item.
    let l:item_to_move = remove(a:list, a:index)

    " 2. Insert the removed item at the beginning (index 0) of the list.
    "    We use 'call' because we are modifying the list in-place and
    "    don't need the return value of insert().
    call insert(a:list, l:item_to_move, 0)

    " 3. Return the modified list (though it was also modified in-place).
    return a:list
endfunction
" *****************************************************************************************************
                " Quickfix Resizing
                " *************************************************************************************
" Set quickfix window height to half the screen height
function! QuickfixResize()
  " Get the total height of the Vim window
  let total_height = &lines
  " Calculate half the height, using integer division (//) for a whole number
  let half_height = total_height / 2
  exe "resize " . half_height
endfunction
" *****************************************************************************************************
                " Utility Popup
                " *************************************************************************************
function! g:UtilityPopupCommand(...)
    call system( a:1 . " > /tmp/out" )
    call UtilityPopUp("/tmp/out")
endfunction
let g:utilityPopupFilename = ""
function! g:UtilityPopUp(...)
    if filereadable(a:1)
        let g:utilityPopupFilename = a:1 
        call popup_create(readfile(a:1), #{ line: 1, col: 1, border: [], padding: [1,1,1,1] } )
        let l:id = popup_list()[0]
        call popup_move(l:id, #{ line: 2, col: 4, 
                    \ minwidth: &columns -14,
                    \ maxheight: &lines -8, maxwidth: &columns -8,
                    \ })
        hi MyPopupColor ctermbg=black guibg=black
        call setwinvar(l:id, '&wincolor', 'MyPopupColor')
        nnoremap <DOWN> :call ScrollPopup(1)<CR>
        nnoremap <UP>   :call ScrollPopup(-1)<CR>
        nnoremap <F10>  :call UtilityPopUpClear(g:utilityPopupFilename)<CR>
    endif
endfunction
function! g:UtilityBufferCommand(...)
    call system( a:1 . " > /tmp/out" )
    call UtilityBuffer("/tmp/out")
endfunction
function! g:UtilityBuffer(...)
    if filereadable(a:1)
        execute "edit " . a:1
    endif
endfunction

function! g:UtilityPopUpClear(...)
    call popup_clear(1)
    nnoremap <DOWN> <down>
    nnoremap <UP>   <up>
    nnoremap <F10>  :call UtilityPopUp(g:utilityPopupFilename)<CR>
endfunction

function! ScrollPopup(nlines)
    let winids = popup_list()
    if len(winids) == 0
        return
    endif

    " Ignore hidden popups
    let prop = popup_getpos(winids[0])
    if prop.visible != 1
        return
    endif

    let firstline = prop.firstline + a:nlines
    let buf_lastline = str2nr(trim(win_execute(winids[0], "echo line('$')")))
    if firstline < 1
        let firstline = 1
    elseif prop.lastline + a:nlines > buf_lastline
        let firstline = buf_lastline + prop.firstline - prop.lastline
    endif

    call popup_setoptions(winids[0], {'firstline': firstline})
endfunction
function! GetUserInput(prompt)
  let user_input = input(a:prompt)
  return user_input
endfunction
" let user_string = GetUserInput("Enter your name: ")

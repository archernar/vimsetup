# Vim Essentials Cheatsheet & Guide

### Movements Within A Line
```
$       : Move cursor to the end of the line
0       : Move cursor to the beginning of the line
^       : Move cursor to first non-blank character in line
fx      : Find next occurrence of character 'x'
Fx      : Find previous occurrence of character 'x'
tx      : Go towards next occurrence of character 'x' (stops right before it)
Tx      : Go towards previous occurence of character 'x' (stops right before it)
;       : Repeat previous f, F, t, or T movement forwards
,       : Repeat previous f, F, t, or T movement backwards
```

### Word Movements
```
w       : Move cursor forwards to start of word (letters, digits, underscores)
W       : Move cursor forwards to start of WORD (non-blank characters)
b       : Move cursor backwards to start of word
B       : Move cursor backwards to start of WORD
e       : Move cursor forwards to end of word
E       : Move cursor forwards to end of WORD
ge      : Move cursor backwards to end of word
gE      : Move cursor backwards to end of WORD
```

### Sentence Movements
```
)       : Move cursor to next sentence
(       : Move cursor to previous sentence
```

### Paragraph Movements
```
}       : Move cursor to next paragraph
{       : Move cursor to previous paragraph
```

### Moving To Specific Lines
```
gg      : Move cursor to first line of document
G       : Move cursor to last line of document
{num}G  : Move cursor to line {num}
{num}j  : Go {num} lines down
{num}k  : Go {num} lines up
H       : Move cursor to line at the top of the window
M       : Move cursor to the line at the middle of the window
L       : Move cursor to the line at the bottom of the window
```

### Parenthesis, Bracket, Curly Brace and Method Navigation
```
%       : Find next parenthesis/bracket/brace and jump to match
[(      : Go to previous unmatched (
[{      : Go to previous unmatched {
])      : Go to next unmatched )
]}      : Go to next unmatched }
]m      : Go to next start of method (Java like languages)
]M      : Go to next end of method
[m      : Go to previous start of method
[M      : Go to previous end of method
```

### Screen Related Cursor Movements
```
Ctrl-F  : Move cursor forwards one full screen
Ctrl-B  : Move cursor backwards one full screen
Ctrl-D  : Move cursor down half a screen
Ctrl-U  : Move cursor up half a screen
```

### Scrolling While Leaving Cursor In Place
```
zz      : Place current cursor line in the middle of the window
zt      : Place current cursor line at the top of the window
zb      : Place current cursor line at the bottom of the window
Ctrl-E  : Scroll down a single line, leaving cursor in place
Ctrl-Y  : Scroll up a single line, leaving cursor in place
```

## Search Movements
```
/pattern : Search forward for pattern
?pattern : Search backward for pattern
* : Search forward for the word under or in front of the cursor
#        : Search backward for the word under or in front of the cursor
n        : Repeat last search in same direction
N        : Repeat last search in opposite direction
```

## Changing Vim Modes
```
i       : Enter INSERT mode
a       : Enter INSERT mode after the cursor (think: append)
A       : Enter INSERT mode at the end of the line (think: Append)
o       : Open new line below the cursor and enter INSERT mode
O       : Open new line above the cursor and enter INSERT mode
v       : Enter VISUAL mode
Ctrl-v  : Enter VISUAL-BLOCK mode
:       : Enter COMMAND-LINE mode
R       : Enter REPLACE mode
ESC     : Go back to NORMAL mode from other modes
```


## Navigating The Jump List
```
Ctrl-O   : Go to the previous cursor position in the jump list
Ctrl-I   : Go to the next cursor position in the jump list
```

## Editing Text

### Deletion
```
d{motion}: Delete text that {motion} moves over; copy into register.
dd       : Delete whole current line; copy into register.
D        : Delete from cursor to end of line; copy into register.
```

### Undo & Redo
```
u        : Undo last change
Ctrl-R   : Redo changes that have been undone with u
```

### Changing Text
```
c{motion}: Delete text {motion} moves over, copy to register, enter insert mode.
cc       : Delete whole current line, copy to register, enter insert mode.
C        : Delete from cursor to end of line, copy to register, enter insert mode.
```

### Repeating a File Change
```
.        : Repeat the last change you made to the file

```

### Replacing & Deleting Characters
```
r{char}  : Replace current character under cursor with {char}
R        : Enter replace mode; replace characters until ESC is pressed
x        : Delete current character under cursor; copy into register
```

### Yank (Copy) and Paste (Put)
```
y{motion}: Yank (copy) text that motion moves over into register
yy       : Yank (copy) whole current line into register
Y        : Yank (copy) from cursor to end of line into register
p        : Put (paste) text in register after cursor
P        : Put (paste) text in register before cursor
```

### Changing Case
```
~          : Switch case of character under cursor and move right
~{motion}  : Switch case of text that {motion} moves over
gu{motion} : Change text that {motion} moves over to lowercase
guu        : Make whole current line lower case
gU{motion} : Change text that {motion} moves over to uppercase
gUU        : Make whole current line upper case
```

## Search/Replace
```
:%s/old/new/g   : Replace all "old" with "new" in whole file
:%s/old/new/gc  : Replace all "old" with "new" in whole file, confirm each
:%s/old/new/gi  : Replace all "old" with "new" in whole file, ignore case
```

## Working With Text Objects
```
a"       : A double quoted string, including the quotes
i"       : A double quoted string, excluding the quotes
a'       : A single quoted string, including the quotes
i'       : A single quoted string, excluding the quotes
a( / a)  : A block surrounded by parenthesis, including parenthesis
i( / i)  : A block surrounded by parenthesis, excluding parenthesis
a[ / a]  : A block surrounded by brackets, including brackets
i[ / i]  : A block surrounded by brackets, excluding brackets
a{ / a}  : A block surrounded by curly braces, including braces
i{ / i}  : A block surrounded by curly braces, excluding braces
a< / a>  : Text surrounded by <>, including opening/closing
i< / i>  : Text surrounded by <>, excluding opening/closing
at       : A block surrounded by xml/html tags, including tags
it       : A block surrounded by xml/html tags, excluding tags
aw       : A word including the surrounding whitespace
iw       : A word excluding the surrounding whitespace
ap       : A paragraph including the surrounding whitespace
ip       : A paragraph excluding the surrounding whitespace
```

## Indentation
```
>{motion}: Indent text that {motion} moves over, to the right
>>       : Indent whole current line to the right
```

## Exiting
```
:w      : Write (save) file without exiting
:wa     : Write (save) all open files without exiting
:q      : Quit but fail if unsaved changes exist
:q!     : Quit and discard unsaved changes
:wq     : Write (save) and quit (or :x)
:wqa    : Write and quit on all open files
```

## Moving Around Within Vim

### Arrows
```
h       : Move cursor left
j       : Move cursor down
k       : Move cursor up
l       : Move cursor right
```


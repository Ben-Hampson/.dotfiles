"" For vim and the VSCode vim extension.
"" Not for neovim. See init.lua for that.

:set number
:set relativenumber
:set syntax
:set hlsearch
:set ignorecase

" Use jk to escape to normal mode  
inoremap jk <esc>
vnoremap jk <esc>

" H + L -> End of Line
nmap H ^
nmap L $

" Yank to system clipboard
set clipboard=unnamed

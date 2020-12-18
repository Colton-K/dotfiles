" tab settings
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set autoindent

" color settings
syntax on
set background=dark
colorscheme monokai
colorscheme gruvbox

" relative numbering
augroup numbertoggle
      autocmd!
      autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu | set rnu   | endif
      autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu | set nornu | endif
augroup END

set number relativenumber

set mouse=a
" hotkey for switching mouse mode
map <F8> :set mouse=a
map <F7> :set mouse=""

" make hotkeys
au BufNewFile,BufRead *.c
    \ map <F9> :make clean && make

au BufNewFile,BufRead *.cpp
    \ map <F9> :make clean && make 

" run hotkeys
au BufNewFile,BufRead *.py
    \ map <F9> :w <bar> :!clear; python3 %

au BufNewFile,BufRead *.sh
    \ map <F9> :w <bar> :!clear; ./%

" templates
if has("autocmd")
    augroup templates
        autocmd BufNewFile *.sh 0r ~/.vim/templates/skeleton.sh
        autocmd BufNewFile *.c 0r ~/.vim/templates/skeleton.c
        autocmd BufNewFile *.cpp 0r ~/.vim/templates/skeleton.cpp
    augroup END
endif




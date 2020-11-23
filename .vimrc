set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

set mouse=a

set autoindent

syntax on
"colorscheme monokai
colorscheme slate

" relative numbering
augroup numbertoggle
      autocmd!
      autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu | set rnu   | endif
      autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu | set nornu | endif
augroup END

set number relativenumber

" make hotkeys
au BufNewFile,BufRead *.c
    \ map <F9> :make clean && make

" run hotkeys
au BufNewFile,BufRead *.py
    \ map <F9> :!clear; python %

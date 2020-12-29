" -------------------
" vim-plug and packages
" -------------------

" make sure vim-plug is installed
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
  \| endif

call plug#begin('~/.vim/plugged')

" automatically show vim's complete menu
Plug 'vim-scripts/AutoComplPop'
Plug 'vim-scripts/AutoComplPop'

" enhance vim's complete menu
" NEEDS NODEJS SERVER - not good for student machines
" Plug 'neoclide/coc.nvim'

" Automatically clear search highlights after you move your cursor.
" added a shortcut to press '\' later in vimrc if preferred
" Plug 'haya14busa/is.vim'

" commenting plugin
Plug 'scrooloose/nerdcommenter'

" be able to have multiple cursors like sublime text
Plug 'terryma/vim-multiple-cursors'

" file management
Plug 'preservim/nerdtree'

" install fuzzy finder for vim
"Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

" autocomplete brackets
Plug 'jiangmiao/auto-pairs'

call plug#end()

" ----------------
" GENERAL SETTINGS
" ----------------

" for nerdcommenter
filetype plugin on
nnoremap <C-/> :call NERDComment(0,"toggle")<CR>
vnoremap <C-/> :call NERDComment(0,"toggle")<CR>
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDDefaultAlign = 'left'

" tab settings
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set autoindent
" color settings
syntax on
"set background=dark
colorscheme monokai
colorscheme blue " for some reason makes gruvbox dark on nd student machines...
let g:gruvbox_contrast_dark = 'medium' " but this doesn't????
colorscheme gruvbox

" highlight search
set hlsearch
set number relativenumber

" mouse support settings
function! ToggleMouse()
    " check if mouse is enabled
    if &mouse == 'a'
        " disable mouse
        set mouse=
    else
        " enable mouse everywhere
        set mouse=a
    endif
endfunc

set mouse=a
" hotkey for switching mouse mode
map <F8> :call ToggleMouse() <CR>
map <F7> :set mouse=""

" press j and k simultaneously for escape so you don't have to move hands
imap jk <Esc>
imap kj <Esc>

if has("autocmd")
    " make hotkeys
    au BufNewFile,BufRead *.c
        \ map <F9> :w <bar> :make clean && make <CR>

    au BufNewFile,BufRead *.cpp
        \ map <F9> :w <bar> :make clean && make <CR> 

    " run hotkeys
    au BufNewFile,BufRead *.py
        \ map <F9> :w <bar> :!clear; python3 % <CR>

    au BufNewFile,BufRead *.sh
        \ map <F9> :w <bar> :!clear; ./% <CR>
  
    " comment hotkeys before found nerdcommenter
    " augroup CommentUnComment
    "     au BufNewFile,BufRead *.py
    "         \ map <C-/> :s/^/# / <bar> :noh <CR>
    "     "    \ map <C-/> call CommentUnComment() <bar> :noh <CR>

    "     au BufNewFile,BufRead *.cpp
    "         \ map <C-/> :s/^/\/\/ / <bar> :noh <CR>

    "     au BufNewFile,BufRead *.c
    "         \ map <C-/> :s/^/\/\/ / <bar> :noh <CR>

    "     au BufNewFile,BufRead *.sh
    "         \ map <C-/> :s/^/# / <bar> :noh <CR>
    " augroup endif
    " relative numbering
    augroup numbertoggle
          autocmd!
          autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu | set rnu   | endif
          autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu | set nornu | endif
    augroup END
    " templates
    augroup templates
        autocmd BufNewFile *.sh 0r ~/.vim/templates/skeleton.sh
        autocmd BufNewFile *.c 0r ~/.vim/templates/skeleton.c
        autocmd BufNewFile *.cpp 0r ~/.vim/templates/skeleton.cpp
    augroup endif
    " Start NERDTree when Vim is started without file arguments.
"    augroup nerdtree
"        autocmd StdinReadPre * let s:std_in=1
"        autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif
"    augroup endif
endif

" make tab autocomplete
function! Tab_Or_Complete()
  if col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
    return "\<C-N>"
  else
    return "\<Tab>"
  endif
endfunction
:inoremap <Tab> <C-R>=Tab_Or_Complete()<CR>
:set dictionary="/usr/dict/words"

" remove highlighted search words 
nnoremap \ :noh<return>

" make fzf bound to ctrl-p
nnoremap <C-p> :<C-u>FZF<CR>

" map multiple line selection to be the same as in sublime text
let g:multi_cursor_start_word_key = '<C-d>'
let g:multi_cursor_next_key = '<C-d>'
let g:multi_cursor_quit_key = '<Esc>'

" map buttons to nerdtree
nnoremap <C-n> :NERDTreeToggle <CR>
nnoremap <C-f> :NERDTreeFind <CR>

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

" enhance vim's complete menu
" NEEDS NODEJS SERVER - not good for student machines
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" set signcolumn=no " because I don't want coc's stupid side bar thingy

" commenting plugin
Plug 'scrooloose/nerdcommenter'
nnoremap <C-/> :call NERDComment(0,"toggle")<CR>
vnoremap <C-/> :call NERDComment(0,"toggle")<CR>
nnoremap <C-_> :call NERDComment(0,"toggle")<CR>
vnoremap <C-_> :call NERDComment(0,"toggle")<CR>
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDDefaultAlign = 'left'

" be able to have multiple cursors like sublime text
Plug 'terryma/vim-multiple-cursors'
" map multiple line selection to be the same as in sublime text
let g:multi_cursor_start_word_key = '<C-d>'
let g:multi_cursor_next_key = '<C-d>'
let g:multi_cursor_quit_key = '<Esc>'

" file management
Plug 'preservim/nerdtree'
" map buttons to nerdtree
nnoremap <C-n> :NERDTreeToggle <CR>
nnoremap <C-m> :NERDTreeFind <CR>
nnoremap <F7> :cd %:p:h<CR>:pwd<CR>

" install fuzzy finder for vim
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
" make fzf bound to ctrl-p
nnoremap <C-p> :<C-u>FZF<CR>
" make file search bound to ctrl-f
nnoremap <C-f> :Rg<CR>

" autocomplete brackets
Plug 'jiangmiao/auto-pairs'

" good light colorscheme
Plug 'endel/vim-github-colorscheme'

" linting for style ;)
Plug 'vim-syntastic/syntastic'
let g:syntastic_cpp_checkers = ['cpplint']

call plug#end()

" ----------------
" GENERAL SETTINGS
" ----------------

" for nerdcommenter
filetype plugin on

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
" set number 
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
map <F7> :cd %:p:h<CR>

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

    au BufNewFile,BufRead *.s
        \ map <F9> :w <bar> :!clear; albaasm ./% ./%.o && albasim -i ./%.o <CR>
  
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
        autocmd BufNewFile *.py 0r ~/.vim/templates/skeleton.py
        autocmd BufNewFile Makefile 0r ~/.vim/templates/skeleton.makefile
    augroup endif
    augroup nerdtree
        " Exit Vim if NERDTree is the only window left.
        autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

        " toggle automatically changing directory to whatever current file is in
        let g:chDir = 1 " default to autochanging directory
        function! ToggleChDir()
            if g:chDir
                cd ~
                autocmd BufEnter * silent! lcd %:p:h
                let g:chDir = 0
            else
                cd ~
                let g:chDir = 1
            endif
        endfunction

        " nnoremap <F7> :call ToggleChDir() <CR>
    augroup endif
    " for easier web dev (autocompletes tags)
    function s:CompleteTags()
        inoremap <buffer> > ></<C-x><C-o><Esc>:startinsert!<CR><C-O>?</<CR>
        inoremap <buffer> ><Leader> >
        inoremap <buffer> ><CR> ></<C-x><C-o><Esc>:startinsert!<CR><C-O>?</<CR><CR><Tab><CR><Up><C-O>$
        :noh " need to find a way to turn off highlighting
    endfunction
    autocmd BufRead,BufNewFile *.html,*.js,*.xml call s:CompleteTags() 
endif

" automatically change working directory
" set autochdir

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
nnoremap \ :noh<CR>

" make a hotkey for searching
nnoremap <C-g> :s///g 

" ignore case while searching
set ignorecase

" show incremental search results
set incsearch

" use netrw for file manager - I don't because it doesn't find your directory
" automatically
" set autochdir
" let g:NetrwIsOpen=0

" function! ToggleNetrw()
"     if g:NetrwIsOpen
"         let i = bufnr("$")
"         while (i >= 1)
"             if (getbufvar(i, "&filetype") == "netrw")
"                 silent exe "bwipeout " . i 
"             endif
"             let i-=1
"         endwhile
"         let g:NetrwIsOpen=0
"     else
"         let g:NetrwIsOpen=1
"         silent Lexplore
"     endif
" endfunction

" nnoremap <C-n> :call ToggleNetrw() <CR>
" let g:netrw_liststyle = 0 " for thin view
" let g:netrw_banner = 0 " hide banner 
" let g:netrw_winsize = 25 " set width to 25% of window size

" make pairs autocomplete instead of using a plugin
" :inoremap ( ()<Esc>:let leavechar=")"<CR>i
" :inoremap [ []<Esc>:let leavechar="]"<CR>i
" :inoremap { {}<Esc>:let leavechar="}"<CR>i
" :inoremap " ""<Esc>:let leavechar="""<CR>i


" make copy paste to/from system work
set clipboard=unnamedplus


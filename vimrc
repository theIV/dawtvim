" Use Vim settings, rather then Vi settings
set nocompatible

" Needed on some linux distros.
" see http://www.adamlowe.me/2009/12/vim-destroys-all-other-rails-editors.html
"filetype off

call pathogen#helptags()
call pathogen#runtime_append_all_bundles()

" http://www.google.com/webfonts/family?family=Lekton&subset=latin
set guifont=Lekton:h18

" map our leader
let mapleader = ','
let maplocalleader = '\'

" set cursorline
set lines=35 columns=80
set number
set go-=T
set go-=l
set go-=L
set go-=r
set go-=R


set hidden

" be gone, scrollbars
set guioptions-=r

syntax enable

" searchin'
" highlight search results
set hlsearch
" search as you type
set incsearch
" who cares what case you're searchin' for...
set ignorecase
" unless they contain at least one capital letter
set smartcase
" get rid of highlighting when we're done
noremap <leader>n :nohl<CR>

set wildmode=list:longest

set wildignore+=*.sw? " Vim swap files

" invisibles
" Show invisible characters
set list
" Shortcut to toggle `set list`
nnoremap <leader>l :set list!<CR>
" These are pretty cute so you can see what's going on
set lcs=trail:·,tab:▸\ ,eol:¬,extends:>,precedes:<,nbsp:&

filetype plugin indent on

compiler ruby

augroup myfiletypes
  au!
  au FileType ruby,haml,eruby,yaml
  au BufNewFile,BufRead *.liquid setlocal filetype=liquid
  au BufNewFile,BufRead *.js setlocal filetype=javascript.jquery
  au BufNewFile,BufRead *.as setlocal filetype=actionscript
  "au FileType ruby set omnifunc=rubycomplete#Complete
  au FileType javascript set ai et omnifunc=javascriptcomplete#CompleteJS
  au FileType html set ai et omnifunc=htmlcomplete#CompleteTags
augroup END

augroup ft_css
    au!

    au BufNewFile,BufRead *.sass,*.scss setlocal filetype=sass

    au Filetype sass,scss,css setlocal foldmethod=marker
    au Filetype sass,scss,css setlocal foldmarker={,}
    au Filetype sass,scss,css setlocal omnifunc=csscomplete#CompleteCSS
    au Filetype sass,scss,css setlocal iskeyword+=-

    " Use <localleader>S to sort properties.  Turns this:
    "
    "     p {
    "         width: 200px;
    "         height: 100px;
    "         background: red;
    "
    "         ...
    "     }
    "
    " into this:

    "     p {
    "         background: red;
    "         height: 100px;
    "         width: 200px;
    "
    "         ...
    "     }
    au BufNewFile,BufRead *.sass,*.scss,*.css nnoremap <buffer> <localleader>S ?{<CR>jV/\v^\s*\}?$<CR>k:sort<CR>:noh<CR>

    " Make {<cr> insert a pair of brackets in such a way that the cursor is correctly
    " positioned inside of them AND the following code doesn't get unfolded.
    au BufNewFile,BufRead *.sass,*.scss,*.css inoremap <buffer> {<cr> {}<left><cr><space><space><space><space>.<cr><esc>kA<bs>
augroup END

" Only show cursorline in the current window and in normal mode.

augroup cline
    au!
    au WinLeave * set nocursorline
    au WinEnter * set cursorline
    au InsertEnter * set nocursorline
    au InsertLeave * set cursorline
augroup END

set tabstop=2
set softtabstop=2
set shiftwidth=2
set autoindent
set smarttab
set expandtab

set background=light
colorscheme solarized

" window splitting mappings
nnoremap <leader>v :vsplit<CR> <C-w><C-w>
nnoremap <leader>s :split<CR> <C-w><C-w>

" toggle TagBar
nnoremap <leader>t :TagbarToggle<CR>

" toggle MiniBufExplorer
nnoremap <leader>m :TMiniBufExplorer<CR>

" sane movement with wrap turned on
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk
nnoremap <Down> gj
nnoremap <Up> gk
vnoremap <Down> gj
vnoremap <Up> gk
inoremap <Down> <C-o>gj
inoremap <Up> <C-o>gk

" get the fuck out
inoremap jk <esc>
inoremap <esc> <nop>

" NERDTree
" 'wycats' style NERDTree
let NERDTreeDirArrows  = 1
let NERDTreeMouseMode  = 3
let NERDTreeShowHidden = 1

" Shortcut to toggle nerd tree
noremap <leader>d :execute 'NERDTreeToggle ' . getcwd()<CR>


" System clipboard interaction
" From https://github.com/henrik/dotfiles/blob/master/vim/config/mappings.vim
noremap <leader>y "*y
noremap <leader>p :set paste<CR>"*p<CR>:set nopaste<CR>
noremap <leader>P :set paste<CR>"*P<CR>:set nopaste<CR>


" Shortcut to delete trailing whitespace
nnoremap <leader>w :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

" Keep 3 lines of 'buffer' when scrolling
set scrolloff=3

" Set column so we know when we've reached 80 characters on a line
set colorcolumn=81

" Load matchit
runtime macros/matchit.vim

autocmd BufRead *_spec.rb syn keyword rubyRspec describe context it specify it_should_behave_like before after setup subject
highlight def link rubyRspec Function

" indent guides sizing
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size  = 1


" Ack {{{

nnoremap <leader>a :Ack!<space>

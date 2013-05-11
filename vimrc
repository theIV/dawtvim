set encoding=utf-8  " always roll utf-8
set laststatus=2    " always show the statusline

filetype plugin indent on
syntax enable

execute pathogen#infect()
execute pathogen#helptags()

" As a nice alternate, when you are feeling flirty:
" http://www.google.com/webfonts/family?family=Lekton&subset=latin
" set guifont=Lekton:h14
set guifont=Menlo:h16

" no tabs, 2 spaces
set tabstop=2
set softtabstop=2
set shiftwidth=2
set autoindent
set smarttab
set expandtab

" map our leader
let mapleader = ','
let maplocalleader = '\'

" set cursorline
set lines=25 columns=90
set number

" keep 2 extra lines when scrolling
set scrolloff=2

" set column so we know when we've reached 80 characters on a line
set colorcolumn=81

" set leading
set linespace=3

" begone, evil scrollbars
set go-=T
set go-=l
set go-=L
set go-=r
set go-=R
set guioptions-=r

" stfu!
set visualbell

set hidden

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
noremap <leader><space> :nohl<CR>

set wildmode=list:longest

set wildignore+=*.sw?     " Vim swap files
set wildignore+=.DS_Store " You are the bane of my existence, .DS_Store.
set wildignore+=tags      " Ignore tag files

" invisibles
" Show invisible characters
set list
" Shortcut to toggle `set list`
nnoremap <leader>l :set list!<CR>
" These are pretty cute so you can see what's going on
set lcs=trail:·,tab:▸\ ,eol:¬,extends:>,precedes:<,nbsp:&

" status line from gary bernhardt
" https://github.com/garybernhardt/dotfiles/blob/master/.vimrc
set statusline=%<%f\ (%{&ft})\ %-4(%m%)%=%-19(%3l,%02c%03V%)

compiler ruby

augroup filetypes
  au!
  au BufNewFile,BufRead *.coffee setlocal filetype=coffee
  au BufNewFile,BufRead *.liquid setlocal filetype=liquid
  au BufNewFile,BufRead *.js setlocal filetype=javascript.jquery
  au BufNewFile,BufRead *.as setlocal filetype=actionscript
  au FileType javascript set autoindent expandtab omnifunc=javascriptcomplete#CompleteJS
  au FileType html set autoindent expandtab omnifunc=htmlcomplete#CompleteTags
  "au FileType ruby set omnifunc=rubycomplete#Complete
augroup END

augroup filetype_css
  au!
  au BufNewFile,BufRead *.sass,*.scss setlocal filetype=sass

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
augroup cursorline
  au!
  au WinLeave * set nocursorline
  au WinEnter * set cursorline
  au InsertEnter * set nocursorline
  au InsertLeave * set cursorline
augroup END

" colorschemin'
colorscheme aftereight

" window splitting mappings
nnoremap <leader>v :vsplit<CR> <C-w><C-w>
nnoremap <leader>s :split<CR> <C-w><C-w>

" TagBar
  let g:tagbar_ctags_bin = "/Users/frecial/Developer/bin/ctags"
  " https://gist.github.com/Phize/1527856
  let g:tagbar_type_css = {
  \ 'ctagstype' : 'Css',
      \ 'kinds'     : [
          \ 'c:classes',
          \ 's:selectors',
          \ 'i:identities'
      \ ]
  \ }
  " toggle
  nnoremap <leader>t :TagbarToggle<CR>

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

" go fullscreen
nnoremap <leader>f :set invfullscreen<CR>

" NERDTree
  " janus style
  let NERDTreeDirArrows  = 1
  let NERDTreeMouseMode  = 3
  " hide hidden files...
  let NERDTreeShowHidden = 0
  " shortcut to toggle nerd tree
  noremap <leader>d :execute 'NERDTreeToggle ' . getcwd()<CR>

" numbers.vim
  " toggle
  nnoremap <F3> :NumbersToggle<CR>

" system clipboard interaction
" From https://github.com/henrik/dotfiles/blob/master/vim/config/mappings.vim
noremap <leader>y "*y
noremap <leader>p :set paste<CR>"*p<CR>:set nopaste<CR>
noremap <leader>P :set paste<CR>"*P<CR>:set nopaste<CR>

" delete trailing whitespace
nnoremap <leader>w :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

" load matchit
runtime macros/matchit.vim

autocmd BufRead *_spec.rb syn keyword rubyRspec describe context it specify it_should_behave_like before after setup subject
highlight def link rubyRspec Function

" shortcut for ack
nnoremap <leader>a :Ack!<space>

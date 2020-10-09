set encoding=utf-8  " always roll utf-8
set laststatus=2    " always show the statusline

set nocompatible
filetype plugin indent on
syntax enable

let g:loaded_python_provider = 0
let g:python3_host_prog = '/Users/theiv/.asdf/shims/python'

source ~/.vim/plugins

" no tabs, 2 spaces
set tabstop=2
set softtabstop=2
set shiftwidth=2
set autoindent
set smarttab
set expandtab

set nolazyredraw

set backspace=indent,eol,start

" map our leader
let mapleader = ','
let maplocalleader = '\'

set number

" keep 2 extra lines when scrolling
set scrolloff=2

" set leading
set linespace=3

" stfu!
set visualbell

set hidden

" searchin'
set hlsearch                      " highlight results...
set incsearch                     " and go as you type...
set ignorecase                    " and who cares about capitals...
set smartcase                     " unless there is one...
noremap <leader><space> :nohl<CR> " and get rid of highlighting when we're done.

set wildmode=list:longest
set wildignore+=*.sw?     " Vim swap files
set wildignore+=.DS_Store " You are the bane of my existence, .DS_Store.
set wildignore+=tags      " Ignore tag files

" invisibles

set list " Show invisible characters
" These are pretty cute so you can see what's going on
set lcs=trail:·,tab:▸\ ,eol:¬,extends:>,precedes:<,nbsp:&

" status line from gary bernhardt
" https://github.com/garybernhardt/dotfiles/blob/master/.vimrc
set statusline=%<%f\ (%{&ft})\ %-4(%m%)%=%-19(%3l,%02c%03V%)

compiler ruby

" colorschemin'
" let g:seoul256_background = 237
" colo seoul256
colo nord

let &colorcolumn=join(range(81,999),",") " extend column highlight beyond 80

" Remove line numbers & column in Quickfix
au FileType qf setlocal nonumber colorcolumn=

let g:airline_theme = 'pencil'
let g:airline#extensions#hunks#enabled = 0

let g:vim_markdown_folding_disabled = 1
set conceallevel=3

let g:pencil#wrapModeDefault = 'soft'   " default is 'hard'

augroup pencil
  autocmd!
  " autocmd FileType markdown,mkd call pencil#init({'wrap': 'hard'})
  autocmd FileType text         call pencil#init()
augroup END"

nnoremap <c-j> <c-w>j " move down a split
nnoremap <c-k> <c-w>k " move up a split
nnoremap <c-h> <c-w>h " move left a split
nnoremap <c-l> <c-w>l " move right a split

" break the split habit
nnoremap <leader>v <nop>
nnoremap <leader>s <nop>

" sane movement with wrap turned on
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" get the fuck out
inoremap jk <esc>
inoremap <esc> <nop>

" CoC
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
let g:coc_global_extensions = ['coc-solargraph']

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" numbers.vim
" toggle
nnoremap <F3> :NumbersToggle<CR>

" Tagbar
let g:tagbar_ctags_bin = "/usr/local/bin/ctags"
let g:tagbar_autofocus = 1            " jump to Tagbar when opening
nnoremap <leader>t :TagbarToggle<CR>  " toggle Tagbar

vnoremap <leader>gh :Gbrowse!<CR>

let g:easytags_async = 1
set tags=./tags;
let g:easytags_dynamic_files = 1
let g:easytags_cmd = '/usr/local/bin/ctags'
let g:easytags_languages = {
\   'ruby': {
\     'ripper-tags': g:easytags_cmd,
\        'args': [],
\        'fileoutput_opt': '-f',
\        'stdout_opt': '-f-',
\        'recurse_flag': '-R'
\   }
\}

" TabNine configuration
set rtp+=~/.dawtvim/vim/bundle/tabnine-vim

" system clipboard interaction
" From https://github.com/henrik/dotfiles/blob/master/vim/config/mappings.vim
noremap <leader>y "*y
noremap <leader>p :set paste<CR>"*p<CR>:set nopaste<CR>
noremap <leader>P :set paste<CR>"*P<CR>:set nopaste<CR>

let test#strategy = "vtr"

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

" delete trailing whitespace
nnoremap <leader>w :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

" swap 1.8 with 1.9 style hash-syntax
nnoremap <leader>r :let _s=@/<Bar>:%s/:\([a-z\d_]\+\)\(\s*\)=>/\1:/g<Bar>:let @/=_s<Bar>:nohl<CR>

" load matchit
runtime macros/matchit.vim

autocmd BufRead *_spec.rb syn keyword rubyRspec describe context it specify it_should_behave_like before after setup subject
highlight def link rubyRspec Function

let g:ale_linters = {
\ 'sh': ['shellcheck'] ,
\ }
let g:ale_fixers = {
  \   'ruby': [
  \       'rufo',
  \       'rubocop'
  \   ],
  \   'sh': ['shfmt'],
  \}

" Add space after comment marker inserted by NERDCommenter
let g:NERDSpaceDelims = 1

let g:go_fmt_command = "goimports"
autocmd BufEnter *.go set noexpandtab shiftwidth=8 softtabstop=8

" shortcut for ack
nnoremap <leader>a :Ag!<space>

" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

" https://ttssh2.osdn.jp/manual/en/usage/tips/vim.html
if has("patch-8.0.0238")
  " When below configuration is not set by using Bracketed Paste Mode supporting version(8.0.0238 or later),
  " the Bracketed Paste Mode is used while TERM is xterm.
  " When tmux is used, below configuration is needed because TERM is screen.
  if &term =~ "screen"
    let &t_ti .= "\e[?2004h"
    let &t_te .= "\e[?2004l"
    let &pastetoggle = "\e[201~"

    function! XTermPasteBegin(ret) abort
      set paste
      return a:ret
    endfunction

    noremap <special> <expr> <Esc>[200~ XTermPasteBegin("0i")
    inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
    vnoremap <special> <expr> <Esc>[200~ XTermPasteBegin("c")
    cnoremap <special> <Esc>[200~ <nop>
    cnoremap <special> <Esc>[201~ <nop>
  endif
endif

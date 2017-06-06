set encoding=utf-8  " always roll utf-8
set laststatus=2    " always show the statusline

set nocompatible
filetype plugin indent on
syntax enable

"set nocp

source ~/.vim/plugins

" no tabs, 2 spaces
set tabstop=2
set softtabstop=2
set shiftwidth=2
set autoindent
set smarttab
set expandtab

set backspace=indent,eol,start

" map our leader
let mapleader = ','
let maplocalleader = '\'

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
  au FileType javascript set autoindent expandtab omnifunc=javascriptcomplete#CompleteJS
  au FileType html set autoindent expandtab omnifunc=htmlcomplete#CompleteTags
  "au FileType ruby set omnifunc=rubycomplete#Complete
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
colorscheme vividchalk

" Move around splits with <c-hjkl>
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" window splitting mappings
nnoremap <leader>v :vsplit<CR> <C-w><C-w>
nnoremap <leader>s :split<CR> <C-w><C-w>

" TagBar
  let g:tagbar_ctags_bin = "/usr/local/bin/ctags"
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

let g:NERDTreeDirArrowExpandable = '±'
let g:NERDTreeDirArrowCollapsible = '•'
" NERDTree
" janus style
let NERDTreeDirArrows  = 1
let NERDTreeMouseMode  = 3
" hide hidden files...
let NERDTreeShowHidden = 0
" shortcut to toggle nerd tree
noremap <leader>d :execute 'NERDTreeToggle ' . getcwd()<CR>

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:airline_powerline_fonts = 1
"let g:tmuxline_powerline_separators = 0

" numbers.vim
" toggle
nnoremap <F3> :NumbersToggle<CR>

" system clipboard interaction
" From https://github.com/henrik/dotfiles/blob/master/vim/config/mappings.vim
noremap <leader>y "*y
noremap <leader>p :set paste<CR>"*p<CR>:set nopaste<CR>
noremap <leader>P :set paste<CR>"*P<CR>:set nopaste<CR>

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

" shortcut for ack
nnoremap <leader>a :Ag!<space>

" swap splits
" courtesy of sgriffin on stackoverflow
" http://stackoverflow.com/questions/2586984/how-can-i-swap-positions-of-two-open-files-in-splits-in-vim
function! MarkWindowSwap()
    let g:markedWinNum = winnr()
endfunction

function! DoWindowSwap()
    " Mark destination
    let curNum = winnr()
    let curBuf = bufnr( "%" )
    exe g:markedWinNum . "wincmd w"
    " Switch to source and shuffle dest->source
    let markedBuf = bufnr( "%" )
    " Hide and open so that we aren't prompted and keep history
    exe 'hide buf' curBuf
    " Switch to dest and shuffle source->dest
    exe curNum . "wincmd w"
    " Hide and open so that we aren't prompted and keep history
    exe 'hide buf' markedBuf
endfunction

nmap <silent> <leader>mw :call MarkWindowSwap()<CR>
nmap <silent> <leader>pw :call DoWindowSwap()<CR>

" https://ttssh2.osdn.jp/manual/en/usage/tips/vim.html
if has("patch-8.0.0238")
  " When below configuration is not set by using Bracketed Paste Mode supporting version(8.0.0238 or later),
  " the Bracketed Paste Mode is used while TERM is xterm.
  " When tmux is used, below configuration is needed because TERM is screen.
  if &term =~ "screen"
    let &t_ti .= "\e[?2004h"
    let &t_te .= "\e[?2004l"
    let &pastetoggle = "\e[201~"

    function XTermPasteBegin(ret)
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

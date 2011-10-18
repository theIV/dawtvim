" Needed on some linux distros.
" see http://www.adamlowe.me/2009/12/vim-destroys-all-other-rails-editors.html
filetype off
call pathogen#helptags()
call pathogen#runtime_append_all_bundles()

" http://www.google.com/webfonts/family?family=Lekton&subset=latin
set guifont=Lekton:h18

set cursorline
set lines=35 columns=80
set number
set go-=T

set hidden

" Highlight search results
set hlsearch
" Search as you type!
set incsearch

set wildmode=list:longest

" Show invisible characters
set list
" Shortcut to toggle `set list`
nmap <leader>l :set list!<CR>
" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬
" These are pretty cute
set lcs=tab:│┈,trail:·,extends:>,precedes:<,nbsp:&

:syntax on

filetype plugin indent on

augroup myfiletypes
  " Clear old autocmds in group
  autocmd!
   " autoindent with two spaces, always expand tabs
  au FileType ruby,haml,eruby,yaml
  au BufNewFile,BufRead *.liquid setf liquid
  au BufNewFile,BufRead *.js set ft=javascript.jquery
  au BufNewFile,BufRead *.as set ft=actionscript
  au FileType ruby set omnifunc=rubycomplete#Complete
  au FileType javascript set ai et omnifunc=javascriptcomplete#CompleteJS
  au FileType html set ai et omnifunc=htmlcomplete#CompleteTags
  au FileType css set omnifunc=csscomplete#CompleteCSS
augroup END

set ts=2
set sts=2
set sw=2
set autoindent
set smarttab
set expandtab

set background=dark
colorscheme solarized


" window splitting mappings
nmap <leader>v :vsplit<CR> <C-w><C-w>
nmap <leader>s :split<CR> <C-w><C-w>

" toggle TagBar
nmap <leader>t :TagbarToggle<CR>

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

" NERDTree

" 'wycats' style NERDTree
let NERDTreeDirArrows = 1
let NERDTreeMouseMode = 3

" FuzzyFinder toggles
nmap ,f :FufFileWithCurrentBufferDir
nmap ,b :FufBuffer
nmap ,t :FufTaggedFile

"!ctags -R --extra=+f .

" Shortcut to toggle nerd tree
map <leader>d :execute 'NERDTreeToggle ' . getcwd()<CR>

" Shortcut to delete trailing whitespace
nmap <leader>w :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

" Shortcut to split up silly Fireworks lines
nmap <leader>x :let _s=@/<Bar>:%s///g

" Highlight lines longer than 80 characters
match ErrorMsg '\%>80v.\+'

" Load matchit
runtime macros/matchit.vim

autocmd BufRead *_spec.rb syn keyword rubyRspec describe context it specify it_should_behave_like before after setup subject
highlight def link rubyRspec Function

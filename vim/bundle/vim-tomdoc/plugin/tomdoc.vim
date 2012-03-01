" tomdoc.vim - You should really TomDoc your code.
" Author:   Jesse Cooke <http://jc00ke.com>
" Version:  0.0.1

if exists("g:loaded_tomdoc") || v:version < 700
  finish
endif
let g:loaded_tomdoc = 1
let s:templates_dir = expand("<sfile>:p:h") . "/../templates/"

function! s:TomDocMethod()
  let lineNumber = search('def', 'b') - 1
  exec ":" . lineNumber . "r" . s:templates_dir . "method.txt"
  silent norm! '[=']
endfunction

function! s:TomDocClass()
  let lineNumber = search('class', 'b') - 1
  exec ":" . lineNumber . "r" . s:templates_dir . "class-or-module.txt"
  silent norm! '[=']
endfunction

function! s:TomDocModule()
  let lineNumber = search('module', 'b') - 1
  exec ":" . lineNumber . "r" . s:templates_dir . "class-or-module.txt"
  silent norm! '[=']
endfunction

function! s:TomDocConstant()
  exec ":-1r" . s:templates_dir . "constant.txt"
  silent norm! '[=']
endfunction

function! s:TomDocAttrReader()
  exec ":-1r" . s:templates_dir . "attr_reader.txt"
  silent norm! '[=']
endfunction

function! s:TomDocAttrWriter()
  exec ":-1r" . s:templates_dir . "attr_writer.txt"
  silent norm! '[=']
endfunction

function! s:TomDocAttrAccessor()
  exec ":-1r" . s:templates_dir . "attr_accessor.txt"
  silent norm! '[=']
endfunction

nnoremap <silent> <Plug>TDMethod        :<C-U>call <SID>TomDocMethod()<CR>
nnoremap <silent> <Plug>TDClass         :<C-U>call <SID>TomDocClass()<CR>
nnoremap <silent> <Plug>TDModule        :<C-U>call <SID>TomDocModule()<CR>
nnoremap <silent> <Plug>TDConstant      :<C-U>call <SID>TomDocConstant()<CR>
nnoremap <silent> <Plug>TDAttrReader    :<C-U>call <SID>TomDocAttrReader()<CR>
nnoremap <silent> <Plug>TDAttrWriter    :<C-U>call <SID>TomDocAttrWriter()<CR>
nnoremap <silent> <Plug>TDAttrAccessor  :<C-U>call <SID>TomDocAttrAccessor()<CR>

nmap tdm  <Plug>TDMethod
nmap tdc  <Plug>TDClass
nmap tdmo <Plug>TDModule
nmap tdco <Plug>TDConstant
nmap tdar <Plug>TDAttrReader
nmap tdaw <Plug>TDAttrWriter
nmap tdaa <Plug>TDAttrAccessor

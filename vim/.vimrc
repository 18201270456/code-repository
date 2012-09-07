" ====== my vimrc configure ====== "
 
 
set encoding=utf-8
 
"let vim support other languanges.
let &termencoding=&encoding
set fileencodings=utf-8,gb18030,gbk,gb2312,big5
 
"syntax highlighting on
syntax on
 
"background is dark (or light)
set bg=dark
set background=dark
 
"color scheme for GVim
if has("gui_running")
    set guifont=Dejavu\ Sans\ Mono\ 11
    set guifontwide=Dejavu\ Sans\ Mono\ 11
    colorscheme desert
endif
 
"display line number
set number
set nu
 
"set length of auto indent = 4
set shiftwidth=4 
set sw=4

"autoindent/noautoindent
set autoindent

"c/c++ style indent
set cindent
 
"tab width=4
set tabstop=4 
set ts=4
 
"set replace tab with spaces
set expandtab 
set et
 
"set backspace=4 * (blank space)
set smarttab
 
  
"let gvim have menu.
set langmenu=zh_CN.UTF-8
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim
  
"set status-menu
set laststatus=2
set statusline=%F%m%r,%Y,%{&fileformat}\ \ \ ASCII=\%b,HEX=\%B\ \ \ %l,%c%V\ %p%%\ \ \ [\ %L\ lines\ in\ all\ ]
"set scroll=1

"keep cursor in the middle all the time :)
nnoremap k kzz
nnoremap j jzz
nnoremap G Gzz
nnoremap dd ddzz
nnoremap o o<esc>zzI
nnoremap O O<esc>zzI
nnoremap p pzz
nnoremap P Pzz
nnoremap <c-d> <c-d>zz
nnoremap <c-u> <c-u>zz


"for windows
if has("win32")
    set guifont=Courier_New:h11:cANSI
    set guifontwide=Courier_New:h11:cANSI
"   set go="无菜单、工具栏"
endif

"when past something in, don't indent.
set pastetoggle=<c-h>

"plugin: vimim 
let g:vimim_toggle='wubi'
let g:vimim_wubi='jd'
let g:vimim_mode = 'dynamic'
let g:vimim_map='c-bslash'
let g:vimim_punctuation=-1

"set swap of vim = clipboard, make copy/paste easy.
set clipboard=unnamedplus
set mouse=v

"set sign of 80'th column
"set cc=80


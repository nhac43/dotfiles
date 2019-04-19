" Encode
set encoding=UTF-8

" Dein {{{
let s:vimdir = $HOME . '/.vim'
let s:dein_dir = s:vimdir . '/dein'
let s:dein_github = s:dein_dir . '/repos/github.com'
let s:dein_repo_name = "Shougo/dein.vim"
let s:dein_repo_dir = s:dein_github . '/' . s:dein_repo_name

"  Install dein automatically
if !isdirectory(s:dein_repo_dir)
  call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
endif

if &compatible
  set nocompatible
endif

let &runtimepath = &runtimepath . "," . s:dein_repo_dir

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  call dein#add('Shougo/dein.vim')

  " Syntax highlight
  call dein#add('vim-python/python-syntax')
  call dein#add('octol/vim-cpp-enhanced-highlight')

  " Utils
  call dein#add('rhysd/accelerated-jk')

  " Filer
  call dein#add('scrooloose/nerdtree')

  call dein#end()
endif
" }}}


" accelerated-jk
if dein#tap('accelerated-jk')
  nmap j <Plug>(accelerated_jk_gj)
  nmap k <Plug>(accelerated_jk_gk)
endif

"python-syntax
if dein#tap('python-syntax')
  let g:python_highlight_all = 1
endif

" vim-cpp-enhanced-highlight
if dein#tap('vim-cpp-enhanced-highlight')
  let g:cpp_class_scope_highlight = 1
  let g:cpp_member_variable_highlight = 1
  let g:cpp_class_decl_highlight = 1
  let g:cpp_experimental_template_highlight = 1
  let g:cpp_concepts_highlight = 1
endif

" NERDTree 
if dein#tap('nerdtree')
  let g:NERDTreeShowHidden=1
  nnoremap <silent><C-e> :NERDTreeToggle<CR>
endif

" Basic setting

set number
set shiftwidth=4
set tabstop=4
set expandtab
set autoindent
set hlsearch
set showmatch matchtime=1
set cursorline
set nobackup
set noswapfile
set autoread
set hidden
set showcmd
set laststatus=2
syntax on

" Check whether plugins should be installed or not
if has('vim_starting') && dein#check_install()
  call dein#install()
endif


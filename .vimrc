"#Encoding
set encoding=UTF-8

"basic setings
set number
set title
set cursorline
set expandtab
set tabstop=4
set shiftwidth=4
set hlsearch
set mouse-=a
syntax on

"vim 8.1 settings
if (v:version >= 801)
    "delete key doesn't work on vim 8.1
    set backspace=indent,eol,start
    "terminal setting
    set splitbelow
    set termwinsize=7x0
endif

"Install vim-plug and plugins
let vimplug_exists=expand('~/.vim/autoload/plug.vim')

let g:vim_bootstrap_editor = "vim"				" nvim or vim

if !filereadable(vimplug_exists)
  if !executable("curl")
    echoerr "You have to install curl or first install vim-plug yourself!"
    execute "q!"
  endif
  echo "Installing Vim-Plug..."
  echo ""
  silent exec "!\curl -fLo " . vimplug_exists . " --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  let g:not_finish_vimplug = "yes"

  autocmd VimEnter * PlugInstall
endif

" vim-plug check the specified plugin is installed
function s:is_plugged(name)
    if exists('g:plugs') && has_key(g:plugs, a:name) && isdirectory(g:plugs[a:name].dir)
        return 1
    else
        return 0
    endif
endfunction

"plugins
call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'Yggdroot/indentLine'
Plug 'airblade/vim-gitgutter'
Plug 'tomtom/tcomment_vim'
Plug 'rhysd/accelerated-jk'
Plug 'chrisbra/csv.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-surround'
Plug '907th/vim-auto-save'

"color scheme
Plug 'tomasr/molokai'
Plug 'w0ng/vim-hybrid'
Plug 'cocopon/iceberg.vim'
Plug 'morhetz/gruvbox'

call plug#end()

"visual
if (s:is_plugged("gruvbox"))
    colorscheme gruvbox
endif
set background=dark

"for tmux
set t_Co=256

"NerdTree
noremap <C-n> :NERDTreeToggle<CR>
"open a file with NerdTree
"autocmd VimEnter *  NERDTree
"Close NerdTree when file is closed
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"indentLine
"fix bug to edit Tex file
let g:indentLine_concealcursor="nc"

"accelerate jk
nmap j <Plug>(accelerated_jk_gj)
nmap k <Plug>(accelerated_jk_gk)

"fzf
noremap <C-j> :Files<CR>
noremap <C-k> :GFiles<CR>

"csv
noremap <C-@> :CSVTabularize<CR>

"markdown
let g:auto_save = 0
augroup ft_markdown
  au!
  au FileType markdown let b:auto_save = 1
augroup END

"high light
nnoremap <ESC><ESC> :nohl<CR>

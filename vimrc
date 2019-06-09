"#Encoding
set encoding=UTF-8

"basic setings
set number
set title
"set cursorline
set mouse=a
set expandtab
set tabstop=4
set shiftwidth=4
set hlsearch
syntax on

"vim 8.1 settings
if (v:version >= 801)
    "delete key doesn't work on vim 8.1
    set backspace=indent,eol,start
    "terminal setting
    set splitbelow
    set termwinsize=7x0
endif

"Auto vim-plug install
let vimplug_exists=expand('~/./autoload/plug.vim')

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

"plugins
call plug#begin()

Plug 'scrooloose/nerdtree'
Plug 'vim-scripts/vim-auto-save'
Plug 'vim-airline/vim-airline'
Plug 'Yggdroot/indentLine'

"color scheme
Plug 'tomasr/molokai'
Plug 'w0ng/vim-hybrid'
Plug 'cocopon/iceberg.vim'

call plug#end()

"visual
colorscheme hybrid
set background=dark

"NerdTree
map <C-n> :NERDTreeToggle<CR>
"open a file with NerdTree
"autocmd VimEnter *  NERDTree
"Close NerdTree when file is closed
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"auto save
function! SwitchAutoSave()
    if (g:auto_save == 0)
        let g:auto_save = 1
    else
        let g:auto_save = 0
    endif
endfunction
:command AS call SwitchAutoSave()


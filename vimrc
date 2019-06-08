"#Encoding
set encoding=UTF-8

"basic setings
set number
set title
"set cursorline
set mouse=a
set tabstop=4
set shiftwidth=4
set hlsearch
syntax on

"vim 8.1 settings
if (v:version >= 810)
	"delete key doesn't work on vim 8.1
	set backspace=indent,eol,start
	"terminal setting for vim 8.1
	set splitbelow
	set termwinsize=7x0
endif

"plugins
call plug#begin()
Plug 'scrooloose/nerdtree'
call plug#end()

"NerdTree
map <C-n> :NERDTreeToggle<CR>
"Close NerdTree when file is closed
"autocmd VimEnter *  NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

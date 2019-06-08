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
if (v:version >= 801)
	"delete key doesn't work on vim 8.1
	set backspace=indent,eol,start
	"terminal setting for vim 8.1
	set splitbelow
	set termwinsize=7x0
endif

"plugins
call plug#begin()
Plug 'scrooloose/nerdtree'
Plug 'vim-scripts/vim-auto-save'
call plug#end()

"NerdTree
map <C-n> :NERDTreeToggle<CR>
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

"========================================================
"                    Basic Settings
"                     (w/o Plugins)
"========================================================
set encoding=UTF-8
set number
set title
set cursorline
set expandtab
set tabstop=4
set shiftwidth=4
set hlsearch
set incsearch
set ignorecase
set smartcase
syntax on

"for tmux
set t_Co=256

"indentLine
"fix bug to edit Tex file
let g:indentLine_concealcursor="nc"


"========================================================
"                    My Key Bindings
"========================================================
"high light
nnoremap <ESC><ESC> :nohl<CR>

" Terminal-Nomal mode
tnoremap <Esc> <C-\><C-n>

" Tabs
nnoremap <C-l> gt
nnoremap <C-h> gT
nnoremap <C-k> :q<CR>


"========================================================
"                   Vim 8.1 Settings
"========================================================
if (v:version >= 801)
    "delete key doesn't work on vim 8.1
    set backspace=indent,eol,start
    "terminal setting
    set splitbelow
    set termwinsize=7x0
endif


"========================================================
"                   Install Vim-Plug
"========================================================
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


"========================================================
"                       Plugins
"========================================================
call plug#begin('~/.vim/plugged')

" Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'Yggdroot/indentLine'
Plug 'airblade/vim-gitgutter'
Plug 'tomtom/tcomment_vim'
Plug 'rhysd/accelerated-jk'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
" Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Defx (filer)
if has('nvim')
    Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
else
    Plug 'Shougo/defx.nvim'
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
endif

"color scheme
Plug 'tomasr/molokai'
Plug 'w0ng/vim-hybrid'
Plug 'cocopon/iceberg.vim'
Plug 'morhetz/gruvbox'

call plug#end()


"========================================================
"             Advanved Settings of Plugins
"========================================================
"NerdTree
" noremap <C-n> :NERDTreeToggle<CR>
"open a file with NerdTree
" autocmd VimEnter *  NERDTree

"Close NerdTree when file is closed
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"accelerate jk
nmap j <Plug>(accelerated_jk_gj)
nmap k <Plug>(accelerated_jk_gk)

"fzf
noremap <C-j> :Files<CR>
" noremap <C-k> :GFiles<CR>


"========================================================
"                   Visual Settings
"========================================================
if (s:is_plugged("gruvbox"))
    colorscheme gruvbox
else
    colorscheme industry
endif
set background=dark


"========================================================
"                   Defx Key Settings
"========================================================
" autocmd VimEnter * execute 'Defx'

nnoremap <silent> <C-t> :<C-u> Defx <CR>

autocmd FileType defx call s:defx_my_settings()
function! s:defx_my_settings() abort
    " Define mappings
    nnoremap <silent><buffer><expr> <CR>
                \ defx#is_directory() ?
                \ defx#do_action('open_directory') :
                \ defx#do_action('multi', ['quit', ['open', 'tab drop']])
                " \ defx#do_action('multi', ['drop', 'quit'])
    " nnoremap <silent><buffer><expr> t
    "             \ defx#do_action('open', 'tabnew')
    " nnoremap <silent><buffer><expr> c
    nnoremap <silent><buffer><expr> yy
                \ defx#do_action('copy')
    " nnoremap <silent><buffer><expr> m
    nnoremap <silent><buffer><expr> dd
                \ defx#do_action('move')
    nnoremap <silent><buffer><expr> p
                \ defx#do_action('paste')
    nnoremap <silent><buffer><expr> l 
                \ defx#is_directory() ?
                \ defx#do_action('open_directory') :
                \ defx#do_action('multi', ['quit', ['open', 'tab drop']])
                " \ defx#do_action('multi', ['drop', 'quit'])
    nnoremap <silent><buffer><expr> E
                \ defx#do_action('drop', 'vsplit')
    nnoremap <silent><buffer><expr> P
                \ defx#do_action('preview')
    " nnoremap <silent><buffer><expr> o
    "             \ defx#do_action('open_tree', 'toggle')
    " nnoremap <silent><buffer><expr> K
    nnoremap <silent><buffer><expr> O
                \ defx#do_action('new_directory')
    " nnoremap <silent><buffer><expr> N
    nnoremap <silent><buffer><expr> o
                \ defx#do_action('new_file')
    nnoremap <silent><buffer><expr> M
                \ defx#do_action('new_multiple_files')
    nnoremap <silent><buffer><expr> C
                \ defx#do_action('toggle_columns',
                \                'mark:indent:icon:filename:type:size:time')
    nnoremap <silent><buffer><expr> S
                \ defx#do_action('toggle_sort', 'time')
    " nnoremap <silent><buffer><expr> d
    nnoremap <silent><buffer><expr> x
                \ defx#do_action('remove')
    " nnoremap <silent><buffer><expr> r
    nnoremap <silent><buffer><expr> i
                \ defx#do_action('rename')
    nnoremap <silent><buffer><expr> !
                \ defx#do_action('execute_command')
    " nnoremap <silent><buffer><expr> x
    "             \ defx#do_action('execute_system')
    " nnoremap <silent><buffer><expr> yy
    "             \ defx#do_action('yank_path')
    nnoremap <silent><buffer><expr> .
                \ defx#do_action('toggle_ignored_files')
    nnoremap <silent><buffer><expr> ;
                \ defx#do_action('repeat')
    nnoremap <silent><buffer><expr> h
                \ defx#do_action('cd', ['..'])
    nnoremap <silent><buffer><expr> ~
                \ defx#do_action('cd')
    nnoremap <silent><buffer><expr> q
                \ defx#do_action('quit')
    nnoremap <silent><buffer><expr> <Space>
                \ defx#do_action('toggle_select') . 'j'
    nnoremap <silent><buffer><expr> *
                \ defx#do_action('toggle_select_all')
    nnoremap <silent><buffer><expr> j
                \ line('.') == line('$') ? 'gg' : 'j'
    nnoremap <silent><buffer><expr> k
                \ line('.') == 1 ? 'G' : 'k'
    " nnoremap <silent><buffer><expr> <C-l>
    "             \ defx#do_action('redraw')
    nnoremap <silent><buffer><expr> <C-g>
                \ defx#do_action('print')
    nnoremap <silent><buffer><expr> cd
                \ defx#do_action('change_vim_cwd')
endfunction

call defx#custom#option('_', {
            \ 'winwidth': 40,
            \ 'split': 'no',
            \ 'direction': 'topleft',
            \ 'show_ignored_files': 1,
            \ 'buffer_name': 'exlorer',
            \ 'toggle': 1,
            \ 'resume': 1,
            \ })

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
let mapleader = " "
set relativenumber

"for tmux
set t_Co=256

"indentLine
"fix bug to edit Tex file
let g:indentLine_concealcursor="nc"


"========================================================
"                    My Key Bindings
"========================================================
let g:python3_host_prog='$HOME/nvims/python/.venv/bin/python'
let g:python_host_prog='$HOME/nvims/python/.venv/bin/python'


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

" Copy mode toggle: Hide left column and indent line
" let s:copy_mode = 0
" function! CopyModeToggle()
"     if s:copy_mode
"         set nu
"         set signcolumn=yes
"         let s:copy_mode = 0
"     else
"         set nonu
"         set signcolumn=no
"         let s:copy_mode = 1
"     endif
"     IndentLinesToggle
" endfunction
" nnoremap <Leader>l :call CopyModeToggle()<CR>
let s:paste_mode = 0
function! PasteModeToggle()
    if s:paste_mode
        set nopaste
        echo ":set nopaste"
        let s:paste_mode = 0
    else
        set paste
        echo ":set paste"
        let s:paste_mode = 1
    endif
endfunction
nnoremap <Leader>l :call PasteModeToggle()<CR>


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

Plug 'vim-airline/vim-airline'
Plug 'Yggdroot/indentLine'
Plug 'airblade/vim-gitgutter'
Plug 'rhysd/accelerated-jk'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.5' }
Plug 'nvim-lua/plenary.nvim'
Plug 'tpope/vim-commentary'
Plug 'cohama/lexima.vim'
Plug 'kkoomen/vim-doge'

Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'onsails/lspkind.nvim'
Plug 'nvimtools/none-ls.nvim'

Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'sirver/ultisnips'
Plug 'quangnguyen30192/cmp-nvim-ultisnips'
Plug 'tpope/vim-surround'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'olimorris/codecompanion.nvim'
Plug 'MeanderingProgrammer/render-markdown.nvim'

" Plug 'tpope/vim-fugitive'
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'heavenshell/vim-pydocstring', { 'do': 'make install', 'for': 'python' }
" Plug 'puremourning/vimspector'

" Plug 'tomtom/tcomment_vim'
" Plug 'scrooloose/nerdtree'
" Plug '907th/vim-auto-save'
" Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
" Plug 'junegunn/fzf.vim'
" Plug 'autozimu/LanguageClient-neovim', {
"     \ 'branch': 'next',
"     \ 'do': 'bash install.sh',
"     \ }

" " Defx (filer)
" if has('nvim')
"     Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
" else
"     Plug 'Shougo/defx.nvim'
"     Plug 'roxma/nvim-yarp'
"     Plug 'roxma/vim-hug-neovim-rpc'
" endif

"color scheme
Plug 'tomasr/molokai'
Plug 'w0ng/vim-hybrid'
Plug 'cocopon/iceberg.vim'
Plug 'morhetz/gruvbox'

call plug#end()


"========================================================
"             Advanved Settings of Plugins
"========================================================
"accelerate jk
nmap j <Plug>(accelerated_jk_gj)
nmap k <Plug>(accelerated_jk_gk)


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
"                  UltiSnips Settings
"========================================================
" Trigger configuration. You need to change this to something other than <tab> if you use one of the following:
" - https://github.com/Valloric/YouCompleteMe
" - https://github.com/nvim-lua/completion-nvim
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

let g:ultisnips_python_style = 'google'

"========================================================
"                  Pydocstring Settings
"========================================================
" " let g:pydocstring_formatter = 'numpy'
" let g:pydocstring_formatter = 'google'
" " let g:pydocstring_formatter = 'sphinx'

" let g:pydocstring_enable_mapping = 0

let g:doge_doc_standard_python = 'google'

"========================================================
"                   Telescope Settings
"========================================================
" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

"========================================================
"                CodeCompanion Settings
"========================================================
nnoremap <leader><leader> <cmd>CodeCompanionChat<cr>

"========================================================
"                     Lua Settings
"========================================================
lua require("lsp_config")
lua require("nvim_cmp_config")
lua require("keymaps")
lua require("doge")
lua require("codecompanion_config")
lua require("render_markdown_config")

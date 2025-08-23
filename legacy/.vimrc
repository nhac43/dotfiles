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

"for tmux
set t_Co=256

"indentLine
"fix bug to edit Tex file
let g:indentLine_concealcursor="nc"


"========================================================
"                    My Key Bindings
"========================================================
let g:python3_host_prog='$HOME/.venv-for-vim/bin/python'
let g:python_host_prog='$HOME/.venv-for-vim/bin/python'


"========================================================
"                    My Key Bindings
"========================================================
"high light
nnoremap <ESC><ESC> :nohl<CR>

" for jupyter
nnoremap <Leader>h /# %%<CR>

" Terminal-Nomal mode
tnoremap <Esc> <C-\><C-n>

" Tabs
nnoremap <C-l> gt
nnoremap <C-h> gT
nnoremap <C-k> :q<CR>

" Copy mode toggle: Hide left column and indent line
let s:copy_mode = 0
function! CopyModeToggle()
    if s:copy_mode
        set nu
        set signcolumn=yes
        let s:copy_mode = 0
    else
        set nonu
        set signcolumn=no
        let s:copy_mode = 1
    endif
    IndentLinesToggle
endfunction
nnoremap <Leader>l :call CopyModeToggle()<CR>


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
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'sirver/ultisnips'
Plug 'heavenshell/vim-pydocstring', { 'do': 'make install', 'for': 'python' }
Plug 'cohama/lexima.vim'
Plug 'puremourning/vimspector'
Plug '907th/vim-auto-save'
" Plug 'autozimu/LanguageClient-neovim', {
"     \ 'branch': 'next',
"     \ 'do': 'bash install.sh',
"     \ }

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

" Auto save
let g:auto_save = 1  " enable AutoSave on Vim startup
let g:auto_save = 0
augroup ft_markdown
  au!
  au FileType markdown let b:auto_save = 1
augroup END


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


"========================================================
"                  coc.nvim Settings
"========================================================
" Set internal encoding of vim, not needed on neovim, since coc.nvim using some
" unicode characters in the file autoload/float.vim
set encoding=utf-8

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" " Always show the signcolumn, otherwise it would shift the text each time
" " diagnostics appear/become resolved.
" if has("nvim-0.5.0") || has("patch-8.1.1564")
"   " Recently vim can merge signcolumn and number column into one
"   set signcolumn=number
" else
"   set signcolumn=yes
" endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>


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


"========================================================
"                  Pydocstring Settings
"========================================================
" let g:pydocstring_formatter = 'numpy'
let g:pydocstring_formatter = 'google'
" let g:pydocstring_formatter = 'sphinx'

let g:pydocstring_enable_mapping = 0


"========================================================
"                  UltiSnips Settings
"========================================================
let g:ultisnips_python_style = 'google'

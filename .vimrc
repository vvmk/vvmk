execute pathogen#infect()
" General {
    filetype plugin indent on
    syntax on
    set number
    colorscheme onedark
    set history=1000 "default history 20..pitiful
    set tabpagemax=50
    set showcmd "show partial commands in status line, selected chars in v mode
    set linespace=0 "no extra linespace between rows
    autocmd Filetype gitcommit setlocal spell textwidth=72

    " Trim whitespace in py files
    autocmd BufWritePre *.py normal m`:%s/\s\+$//e ``

    " Allow color schemes to do bright colors without forcing bold.
    if &t_Co == 8 && $TERM !~# '^linux\|^Eterm'
        set t_Co=16
    endif

    "  Tim Pope says: sessions default to capturing all global options, 
    "  which includes the 'runtimepath' that pathogen.vim manipulates.  This 
    "  can cause other problems too, so I recommend turning that behavior off.
    set sessionoptions-=options
" }
" Formatting {
    set tabstop=4
    set shiftwidth=4
    set nowrap
    set expandtab "tabs are spaces
    set softtabstop=4 "backspace can delete indent
    set comments=s1:/\*,mb:\*,elx:\*/ "auto format comment blocks
    set autowrite
" }
" Key (re)Mappings {
    " easier window/tab navigation
    map <C-J> <C-W>j<C-W><CR>
    map <C-K> <C-W>k<C-W><CR>
    map <C-L> <C-W>l<C-W><CR>
    map <C-H> <C-W>h<C-W><CR>
    map <C-K> <C-W>k<C-W><CR>

    " j,k goes to next row of wrapped text, not next line to file
    nnoremap j gj
    nnoremap k gk
" }
" Shortcuts {
    "change working dir to that of the current file
    cmap cwd lcd %:p:h
    cmap cd. lcd %:p:h
" }
" ExRemappings {
    cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

    let mapleader=','
    map <leader>e :e %%
    map <leader>es :sp %%
    map <leader>ev :vsp %%
    map <leader>et :tabe %%
    map <leader>ac :EComponent<CR>
    map <leader>at :ETemplate<CR>
    map <leader>as :ESpec<CR>
    map <leader>am :EModule<CR>
    map <leader>css :EStylesheet<CR>
" }
" plugin/vars {
    let g:netrw_banner = 0

    let g:javascript_plugin_jsdoc = 1
    let g:javascript_plugin_ngdoc = 1
    let g:javascript_plugin_flow = 1

    let g:go_fmt_command = "goimports"
    let g:go_highlight_function_calls = 1
    let g:go_highlight_operators = 1
    let g:go_highlight_fields = 1
    let g:go_highlight_types = 1

    let g:angular_cli_use_dispatch = 1

    autocmd VimEnter * if globpath('.,..','node_modules/@angular') != '' | call angular_cli#init() | endif

    let python_highlight_all = 1
" }

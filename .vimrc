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

    " Make Vim more liberal about creating hidden buffers
    set hidden
" }
" Formatting {
    set tabstop=4
    set shiftwidth=4
    set expandtab "tabs are spaces
    set softtabstop=4 "backspace can delete indent
    set comments=s1:/\*,mb:\*,elx:\*/ "auto format comment blocks
    set autowrite
    set nowrap
" }
" Splits {
    map <C-J> <C-W>j<C-W><CR>
    map <C-K> <C-W>k<C-W><CR>
    map <C-L> <C-W>l<C-W><CR>
    map <C-H> <C-W>h<C-W><CR>
    map <C-K> <C-W>k<C-W><CR>

    set splitbelow
    set splitright
" }
" Shortcuts {
    "change working dir to that of the current file
    cmap cwd lcd %:p:h
    cmap cd. lcd %:p:h
" }
" ExRemappings {
    cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

    "let mapleader=','
    map <leader>e :e %%
    map <leader>es :sp %%
    map <leader>ev :vsp %%
    map <leader>et :tabe %%
    " keep an empty space after the following commands, save many keystrokes
    map <leader>ac :EComponent 
    map <leader>at :ETemplate 
    map <leader>as :ESpec 
    map <leader>am :EModule 
    map <leader>ay :EStylesheet 
    " vim-go command - go to currentfile_test.go
    map <leader>gt :GoAlternate<CR>
    map <leader>gb :GoBuild<CR>
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

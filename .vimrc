execute pathogen#infect()
" General {
    filetype plugin indent on
    syntax on
    set background=dark
    set number
    colorscheme srcery
    set history=1000 "default history 20..pitiful
    set showcmd "show partial commands in status line, selected chars in v mode
    set linespace=0 "no extra linespace between rows
    autocmd Filetype gitcommit setlocal spell textwidth=72
    " Trim whitespace in py files
    autocmd BufWritePre *.py normal m`:%s/\s\+$//e ``
" }
" Formatting {
    set tabstop=4
    set shiftwidth=4
    set nowrap
    set expandtab "tabs are spaces
    set softtabstop=4 "backspace can delete indent
    set comments=s1:/\*,mb:\*,elx:\*/ "auto format comment blocks
" }
" Key (re)Mappings {
    nnoremap ; :

    " easier window/tab navigation
    map <C-J> <C-W>j<C-W>_
    map <C-K> <C-W>k<C-W>_
    map <C-L> <C-W>l<C-W>_
    map <C-H> <C-W>h<C-W>_
    map <C-K> <C-W>k<C-W>_

    " j,k goes to next row of wrapped text, not next line to file
    nnoremap j gj
    nnoremap k gk

    " apparently stupid shift key fixes
    cmap W w
    cmap WQ wq
    cmap wQ wq
    cmap Q q
    cmap Tabe tabe   
" }
" Shortcuts {
    "change working dir to that of the current file
    cmap cwd lcd %:p:h
    cmap cd. lcd %:p:h
" }
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_ngdoc = 1
let g:javascript_plugin_flow = 1

let python_highlight_all = 1

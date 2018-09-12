execute pathogen#infect()
set nocompatible

if &t_Co == 8 && $TERM !~# '^linux\|^Eterm'
    set t_Co=16
endif

" experimental
set showmode
set smarttab
set tags=tags
set shiftround
set autoindent
set copyindent
noremap <bar> :Dispatch<CR>
noremap <leader>\ :Dispatch!<CR>
set wildignore+=*.so,*.swp,*.zip
set wildignore+=*/vendor/**
set wildignore+=*/public/forum/**
" set wildignore+=*/node_modules/** " breaks angular-vim
"end experimental

" general
filetype plugin indent on
syntax on
set number
set history=1000
set tabpagemax=50
set showcmd "show partial commands in status line, selected chars in v mode
set hidden
set tabstop=4
set shiftwidth=4
set expandtab "tabs are spaces
set softtabstop=4
set comments=s1:/\*,mb:\*,elx:\*/ "auto format comment blocks
set autowrite
set nowrap
set splitbelow
set splitright
scriptencoding utf-8
set termencoding=utf-8
set encoding=utf-8
set ambiwidth=double
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//
set timeout timeoutlen=400 ttimeoutlen=100
set backspace=indent,eol,start
set ignorecase
set smartcase
set visualbell
set noerrorbells

" colors
set background=dark
colorscheme dracula
" colorscheme badwolf
" colorscheme onedark
" colorscheme ps_color
" colorscheme ir_black
" colorscheme pyte
" colorscheme xoria256
" colorscheme mayansmoke " light

" TODO: move to a list, autoload into setcolors list
" let g:colorList = [
"             \'dracula',
"             \'ps_color',
"             \'ir_black',
"             \'pyte',
"             \'xoria256',
"             \'mayansmoke',
"             \'badwolf',
"             \]
" SetColors(g:colorList)


" TODO: this is broken now for some reason, it turns grey at column ~51
" maybe fugitive overwrites it
autocmd Filetype gitcommit setlocal spell textwidth=72

set statusline=%<%f\ %h%m%r%{FugitiveStatusline()}%=%-14.(%l,%c%V%)\ %P

"  Tim Pope says: sessions default to capturing all global options, 
"  which includes the 'runtimepath' that pathogen.vim manipulates.  This 
"  can cause other problems too, so I recommend turning that behavior off.
set sessionoptions-=options

"abbrev
cabbrev fo Focus

"maps
command WQ wq
command Wq wq
command W w
command Q q

nnoremap == gg=G``zz
imap <C-U> <Esc>gUiwea 

" splits
noremap <C-J> <C-W>j<C-W><CR>
noremap <C-K> <C-W>k<C-W><CR>
noremap <C-L> <C-W>l<C-W><CR>
noremap <C-H> <C-W>h<C-W><CR>
noremap <C-K> <C-W>k<C-W><CR>
map <leader>o :only<CR>

" files
cmap cwd lcd %:p:h cmap cd. lcd %:p:h " } ExRemappings {
cmap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'
map <leader>e :e %%
map <leader>es :sp %%
map <leader>ev :vsp %%
map <leader>et :tabe %%

" experimental
function s:MkNonExDir(file, buf)
    if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
        let dir=fnamemodify(a:file, ':h')
        if !isdirectory(dir)
            call mkdir(dir, 'p')
        endif
    endif
endfunction
augroup BWCCreateDir
    autocmd!
    autocmd BufWritePre * :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))
augroup END
" end experimental

"leaders
nmap <leader>w :w!<CR>
map <leader>q :wq<CR>
map <leader>q1 :q!<CR>
"fugitive
map <leader>gs :Gstatus<CR>
map <leader>gw :Gwrite<CR>
map <leader>gcc :Gcommit<CR>
map <leader>gaa :Dispatch git add .<CR>

"python
" Trim whitespace in py files
autocmd BufWritePre *.py normal m`:%s/\s\+$//e ``

"html
function! HTMLStart()
    let title = input('Title? ')
    exec 'normal i<!DOCTYPE html><html><head>'
    if strlen(title)
        exec 'normal o<title>' . title . '</title>' 
    endif
    exec 'normal o</head><body></body></html>kO'
    return '	'
endfunction
iabbrev htmls <C-R>=HTMLStart()<CR>

"php
autocmd BufEnter,BufRead *.blade.php set ft=html.php
iabbrev $t $this->
function! PHPClass()
    let name = input('Class name? ')
    let namespace = input('Any Namespace? ')

    if strlen(namespace)
        exec 'normal i<?php namespace ' . namespace . ';
    else
        exec 'normal i<?php
    endif

    " Open class
    exec 'normal iclass ' . name . ' {}O'

    exec 'normal i	public function __construct() { }'
    return '	'
endfunction
" map <leader>pc :call PHPClass()<CR>
iabbrev phc <C-R>=PHPClass()<CR>

function! PhpTemplateShorthand()
    let keyword = input('Keyword? ')
    let content = input('Content? ')

    exec 'normal i<?php '
    if strlen(keyword)
        if keyword == 'elseif'
            exec 'normal i elseif (' . content . ') : ?>'
            return '	'
        endif
        exec 'normal i ' . keyword . ' (' . content . ') : ?><?php end' . keyword . '; ?>O'
    endif
    return '	'
endfunction
iabbrev phts <C-R>=PhpTemplateShorthand()<CR>

function! PhpInterpolation()
    exec 'normal i<?= ?>T=a'
    return ''
endfunction
iabbrev ph[ <C-R>=PhpInterpolation()<CR>


" Add a new dependency to a PHP class
function! PHPAddDependency()
    let dependency = input('Var Name: ')
    let namespace = input('Class Path: ')

    let segments = split(namespace, '\')
    let typehint = segments[-1]

    exec 'normal gg/construct:Hf)i, ' . typehint . ' $' . dependency . '/}^>O$this->a' . dependency . ' = $' . dependency . ';?{kOprotected $' . dependency . ';?{Ouse ' . namespace . ';'

    " Remove opening comma if there is only one dependency
    exec 'normal :%s/(, /(/g'
endfunction
map <leader>pd :call PHPAddDependency()<CR>

"lara.vim
nmap <leader>lr :e routes/web.php<CR>
nmap <leader>lca :e app/config/app.php<CR>81Gf(%O
nmap <leader>lcd :e app/config/database.php<CR>
nmap <leader>lc :e composer.json<CR>
cabbrev pam Dispatch php artisan migrate
cabbrev pamm Dispatch php artisan make:model
cabbrev pamc Dispatch php artisan make:controller
cabbrev pammig Dispatch php artisan make:migration

function! LaravelNewView()
    let path = input('views/')
    if strlen(path)
        let npath = 'resources/views/' . path . '.blade.php' 
        execute 'edit' npath
    endif
endfunction
nmap <leader>lv :call LaravelNewView()<CR>

" TODO: 
function! BladeEndDirective(opening)
    exec 'normal i@' . a:opening . '@end' . a:opening . 'O'
    return ''
endfunction
" iabbrev foreach <C-R>=BladeEndDirective("foreach")<CR>
" iabbrev if <C-R>=BladeEndDirective("if")<CR>
" iabbrev while <C-R>=BladeEndDirective("while")<CR>

"go
autocmd FileType go noremap <leader>t :GoAlternate<CR>

"abbrev
iabbrev cadc complexaesthetic.com
" iabbrev @@ v@complexaesthetic.com

"arpeggio
" TODO: when angular-cli.vim is loaded, arpeggio#map 'n', '', 0, 'ng' '{???}')
" where {???} enters command-pending mode or whatever its called (like a
" <leader>.
" 'ng' will act as a leader for angular-cli.vim navigation commands.
" example: 
"   'ng' em  calls :EModule
"   'ng' vc  calls :VComponent
"   'ng' ss  calls :SService

call arpeggio#map('i', '', 0, 'jk', '<Esc>')
call arpeggio#map('n', '', 0, '`<Space>', ':Dispatch<Space>')
call arpeggio#map('n', '', 0, '`1', ':Dispatch!<Space>')
call arpeggio#map('n', '', 0, 'cl', ':ccl<CR>')
call arpeggio#map('n', '', 0, 'wv', ':vertical resize +5<CR>')
call arpeggio#map('n', '', 0, 'wh', ':resize +5<CR>')

" ng
call arpeggio#map('n', '', 0, 'ac', ':EComponent<CR>')
call arpeggio#map('n', '', 0, 'at', ':ETemplate<CR>')
call arpeggio#map('n', '', 0, 'as', ':EStylesheet<CR>')
" call arpeggio#map('n', '', 0, 'vi-', ':Vexplore! %%<CR>')
" call arpeggio#map('n', '', 0, 'h-', ':Hexplore %%<CR>')

"globals
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

let g:user_emmet_leader_key = '<C-e>'

" Many plugins assume all greps are the same. I keep this here as a
" quick/temporary solution if I don't have time/it isn't worth it to 
" submit a PR
let g:gnu_grep = 'ggrep'

autocmd VimEnter * if globpath('.,..','node_modules/@angular') != '' | call angular_cli#init() | endif

" keep an empty space after the following commands, save many keystrokes
" TODO: conditionally load only when angular_cli.vim is loaded
map <leader>ac :EComponent 
" map <leader>acc :EComponent<CR>
map <leader>at :ETemplate 
" map <leader>att :ETemplate<CR>
map <leader>as :EService 
map <leader>am :EModule 
map <leader>amm :EModule<CR>
" map <leader>ass :EStylesheet<CR> 
map <leader>t :ESpec<CR>

let python_highlight_all = 1

" hopefully avoid vim getting confused by vue file syntax
autocmd FileType vue syntax sync fromstart

let g:airline_theme='onedark'

" stop this goofy vue plugin checking for EVERY pre-processor language
let g:vue_disable_pre_processors=1

let g:ale_sign_error = '🙊'
let g:ale_sign_warning = '🙈'
let g:ale_set_highlights = 0
let g:ale_lint_on_insert_leave = 1
let g:ale_lint_on_text_changed = 0
let g:ale_sign_column_always = 0

let g:ale_fix_on_save = 1
let g:ale_fixers = {
            \ 'javascript': ['eslint'],
            \ 'typescript': ['tslint'],
            \ 'css': ['prettier'],
            \ 'scss': ['prettier'],
            \ 'vue': ['prettier'],
            \ 'markdown': ['prettier'],
            \ 'json': ['prettier'],
            \}

let g:ctrlp_working_path_mode = 'r'

let g:PHP_removeCRwhenUnix = 1

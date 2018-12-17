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
set wildignore+=*/wwwroot/**
"end experimental

func Eatchar(pat)
    let c = nr2char(getchar(0))
    return (c =~ a:pat) ? '' : c
endfunc

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
set timeout timeoutlen=300 ttimeoutlen=100
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

" Fugitive sets this to 50 for the short message. 72 is fine for the body
autocmd Filetype gitcommit setlocal spell textwidth=72

set statusline=%<%f\ %h%m%r%{FugitiveStatusline()}%=%-14.(%l,%c%V%)\ %P

"  sessions default to capturing all global options including runtimepath. not
"  good with Pathogen.
set sessionoptions-=options

"abbrev
cabbrev fo Focus

"misc maps
command WQ wq
command Wq wq
command W w
command Q q
nnoremap == gg=G``zz
" iunmap <C-U>
inoremap <C-U> <Esc>gUiwea
inoremap <C-L> <C-O>a

" splits
noremap <C-J> <C-W>j<C-W><CR>
noremap <C-K> <C-W>k<C-W><CR>
noremap <C-L> <C-W>l<C-W><CR>
noremap <C-H> <C-W>h<C-W><CR>
noremap <C-K> <C-W>k<C-W><CR>
map <leader>o :only<CR>

" files
cmap cwd lcd %:p:h cmap cd. lcd %:p:h
cmap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'
map <leader>e :e %%
map <leader>es :sp %%
map <leader>ev :vsp %%
map <leader>et :tabe %%

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

function! SubUnderCursor()
    let cw = expand("<cword>")
    let rep = input("Replace with: ")
    
    execute 'normal :%s/' . cw . '/' . rep . '/g'
endfunction
map <leader>ss :call SubUnderCursor()<CR>

"leaders
nmap <leader>w :w!<CR>
map <leader>q :wq<CR>
map <leader>q1 :q!<CR>
map <leader>sv :source ~/.vimrc<CR>
"fugitive
map <leader>gs :Gstatus<CR>
map <leader>gw :Gwrite<CR>
map <leader>gc :Gcommit<CR>
map <leader>gd :Gdiff<CR>
map <leader>g. :Dispatch git add .<CR>

"python
" Trim whitespace in py files
autocmd BufWritePre *.py normal m`:%s/\s\+$//e ``

"html
function! HTMLStart()
    let title = input('Title? ')
    execute 'normal i<!DOCTYPE html><html><head><meta charset="utf-8"><meta name="viewport" content="width=device-width, initial-scale=1">'
    if strlen(title)
        execute 'normal o<title>' . title . '</title>' 
    endif
    execute 'normal o</head><body></body></html>kO'
    return '	'
endfunction
autocmd FileType html iabbrev htmls <C-R>=HTMLStart()<CR><C-R>=Eatchar('\t')<CR>

"JavaScript
" let working = <some boolean expression>
"console.log('Dear future vince, \n\n\tViewBag.SelectStyles is', working ? 'working!' : 'not working yet.', '\n\nLove,\npast vince.');

"Vue
function! VueEmptyComponent()
    let componentName = input('Name? ')
    execute "normal iVue.component('" . componentName . "', {});kko"
    return '	'
endfunction
iabbrev vc <C-R>=VueEmptyComponent()<CR><C-R>=Eatchar('\t')<CR>

"php
autocmd BufEnter,BufRead *.blade.php set ft=html.php
iabbrev $t $this-><C-R>=Eatchar('\t')<CR>
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

" <modifier> function <cursor>() {}
function! PHPFunctionStub(modifier)
    execute "AutoCloseOff"
    execute 'normal i' . a:modifier . ' function () {}k0f(a'
    execute "AutoCloseOn"
    return ''
endfunction
autocmd FileType php iabbrev <silent> met <C-R>=PHPPublicFunction('public')<CR><C-R>=Eatchar('\s')<CR>
autocmd FileType php iabbrev <silent> metp <C-R>=PHPPublicFunction('private')<CR><C-R>=Eatchar('\s')<CR>
autocmd FileType php iabbrev <silent> metpro <C-R>=PHPPublicFunction('protected')<CR><C-R>=Eatchar('\s')<CR>

"lara.vim
nmap <leader>lr :e routes/web.php<CR>
nmap <leader>lca :e app/config/app.php<CR>81Gf(%O
nmap <leader>lcd :e app/config/database.php<CR>
nmap <leader>lc :e composer.json<CR>
cabbrev pa Dispatch php artisan
cabbrev pam Dispatch php artisan migrate
cabbrev pamm Dispatch php artisan make:model
cabbrev pamc Dispatch php artisan make:controller
cabbrev pammig Dispatch php artisan make:migration

function! LaravimNewView()
    let path = input('views/')
    if strlen(path)
        let npath = 'resources/views/' . path . '.blade.php' 
        execute 'edit' npath
    endif
endfunction
nmap <leader>lv :call LaravimNewView()<CR>

function! LaravimUseUnderCursor()
    let cw = expand("<cword>")
    let pre = input("use ")
    execute "normal gg/classkOuse " . pre . '\' . cw . ";2\<c-o>"
endfunction
autocmd FileType php noremap <leader>i :call LaravimUseUnderCursor()<CR>

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

function! GoIfErrNotNil()
    exec "AutoCloseOff"
    exec "normal iif err != nil {\<CR>}\<Esc>O"
    exec "AutoCloseOn"
    return ""
endfunction
autocmd FileType go iabbrev <silent> ifern <C-R>=GoIfErrNotNil()<CR>

"abbrev
iabbrev cadc complexaesthetic.com

"arpeggio
" TODO: when angular-cli.vim is loaded, arpeggio#map 'n', '', 0, 'ng' '{???}')
" where {???} enters command-pending mode or whatever its called (like a
" <leader>.
" 'ng' will act as a leader for angular-cli.vim navigation commands.
" example: 
"   'ng' em  calls :EModule
"   'ng' vc  calls :VComponent
"   'ng' ss  calls :SService

" experimental 
function RunTestsForProject()
    let ft = &filetype
    if (ft == 'php')
        execute 'normal:Dispatch phpunit'
    endif
    return ''
endfunction

" end experimental

call arpeggio#map('i', '', 0, 'wjk', '<Esc>:write<CR>') " escape insert mode and write
call arpeggio#map('i', '', 0, 'jk', '<Esc>')
call arpeggio#map('n', '', 0, '`<Space>', ':Dispatch<Space>')
call arpeggio#map('n', '', 0, '`1', ':Dispatch!<Space>')
call arpeggio#map('n', '', 0, 'cl', ':ccl<CR>')
call arpeggio#map('n', '', 0, 'qf', ':copen<CR>')
call arpeggio#map('n', '', 0, 'wv', ':vertical resize +5<CR>')
call arpeggio#map('n', '', 0, 'wh', ':resize +5<CR>')
call arpeggio#map('n', '', 0, 'rt', ':call RunTestsForProject()<CR>')
autocmd FileType go call arpeggio#map('n', '', 0, 'kb', ':GoDocBrowser<CR>')

" ng
autocmd FileType typescript Arpeggio noremap ac :EComponent<CR>
autocmd FileType typescript Arpeggio noremap at :ETemplate<CR>
autocmd FileType typescript Arpeggio noremap as :EStylesheet<CR>

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

let g:user_emmet_leader_key = '<C-y>'

" Many plugins assume all greps are the same. I keep this here as a
" quick/temporary solution if I don't have time/it isn't worth it to 
" submit a PR
let g:gnu_grep = 'ggrep'

autocmd VimEnter * if globpath('.,..','node_modules/@angular') != '' | call angular_cli#init() | endif
autocmd VimEnter * set wildignore+=*/node_modules/** " breaks angular-vim

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
" let g:ale_sign_error = '失'
" let g:ale_sign_warning = '失'
let g:ale_set_highlights = 0
let g:ale_lint_on_insert_leave = 1
let g:ale_lint_on_text_changed = 0
let g:ale_sign_column_always = 0

let g:ale_fix_on_save = 0
let g:ale_fixers = {
            \ 'javascript': ['eslint'],
            \ 'typescript': ['tslint'],
            \ 'css': ['prettier'],
            \ 'scss': ['prettier'],
            \ 'vue': ['prettier'],
            \ 'markdown': ['prettier'],
            \ 'json': ['prettier'],
            \ 'sh': ['shfmt'],
            \}

let g:ctrlp_working_path_mode = 'r'

let g:PHP_removeCRwhenUnix = 1

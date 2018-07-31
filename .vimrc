execute pathogen#infect()
" General {
    filetype plugin indent on
    syntax on
    set number

    colorscheme dracula
    " colorscheme onedark

    set history=1000
    set tabpagemax=50
    set showcmd "show partial commands in status line, selected chars in v mode

    " default status line + fugitive
    set statusline=%<%f\ %h%m%r%{FugitiveStatusline()}%=%-14.(%l,%c%V%)\ %P

    " TODO: this is broken now for some reason, it turns grey at column ~51
    autocmd Filetype gitcommit setlocal spell textwidth=72

    " Trim whitespace in py files
    autocmd BufWritePre *.py normal m`:%s/\s\+$//e ``

    " Allow color schemes to do bright colors without forcing bold.
    if &t_Co == 8 && $TERM !~# '^linux\|^Eterm'
        set t_Co=16
    endif

    " experiment with iTerm escape codes
    if exists('$ITERM_PROFILE')
        silent !printf '\e]50;SetProfile=LineSpaced\x7'
        autocmd VimLeave * silent !printf '\e]50;SetProfile=Default\x7'
    endif

    "  Tim Pope says: sessions default to capturing all global options, 
    "  which includes the 'runtimepath' that pathogen.vim manipulates.  This 
    "  can cause other problems too, so I recommend turning that behavior off.
    set sessionoptions-=options

    " Make Vim more liberal about creating hidden buffers
    set hidden

    command WQ wq
    command Wq wq
    command W w
    command Q q

" }
" Formatting {
    set tabstop=4
    set shiftwidth=4
    set expandtab "tabs are spaces
    set softtabstop=4 "backspace can delete indent
    set comments=s1:/\*,mb:\*,elx:\*/ "auto format comment blocks
    set autowrite
    set nowrap

    nnoremap == gg=G``
" }
" Splits {
    noremap <C-J> <C-W>j<C-W><CR>
    noremap <C-K> <C-W>k<C-W><CR>
    noremap <C-L> <C-W>l<C-W><CR>
    noremap <C-H> <C-W>h<C-W><CR>
    noremap <C-K> <C-W>k<C-W><CR>

    set splitbelow
    set splitright
" }
" Shortcuts {
    cmap cwd lcd %:p:h cmap cd. lcd %:p:h " } ExRemappings {
    cmap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

    map <leader>e :e %%
    map <leader>es :sp %%
    map <leader>ev :vsp %%
    map <leader>et :tabe %%

    " Experimental Dispatch maps
    noremap <bar> :Dispatch<CR>
    noremap <leader>\ :Dispatch!<CR>

    autocmd FileType go noremap <leader>t :GoAlternate<CR>
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

    let g:user_emmet_leader_key = '<C-e>'

    " Many plugins assume all greps are the same. I keep this here as a
    " quick/temporary solution if I don't have time/it isn't worth it to 
    " submit a PR
    let g:gnu_grep = 'ggrep'

    autocmd VimEnter * if globpath('.,..','node_modules/@angular') != '' | call angular_cli#init() | endif

    " keep an empty space after the following commands, save many keystrokes
    " TODO: conditionally load only when angular_cli.vim is loaded
    map <leader>ac :EComponent 
    map <leader>acc :EComponent<CR>
    map <leader>at :ETemplate 
    map <leader>att :ETemplate<CR>
    map <leader>as :EService 
    map <leader>am :EModule 
    map <leader>amm :EModule<CR>
    map <leader>ass :EStylesheet<CR> 
    map <leader>t :ESpec<CR>

    let python_highlight_all = 1

    " hopefully avoid vim getting confused by vue file syntax
    autocmd FileType vue syntax sync fromstart
    
    " stop this goofy vue plugin checking for EVERY pre-processor language
    let g:vue_disable_pre_processors=1
" }
" abbreviations {
    iabbrev cadc complexaesthetic.com
    iabbrev @@ v@complexaesthetic.com
" }

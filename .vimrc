" Modeline and Notes {
" vim: set sw=4 ts=4 sts=4 et tw=78 foldmarker={,} foldlevel=0 foldmethod=marker spell:
"
" @ThomasAlcala's vim configuration.
" }
"
"
set nocompatible

" sensible.vim - Defaults everyone can agree on
" Maintainer:   Tim Pope <http://tpo.pe/>
" Version:      1.2

if exists('g:loaded_sensible') || &compatible
  finish
else
  let g:loaded_sensible = 'yes'
endif

if has('autocmd')
  filetype plugin indent on
endif
if has('syntax') && !exists('g:syntax_on')
  syntax enable
endif

" Use :help 'option' to see the documentation for the given option.

set autoindent
set backspace=indent,eol,start
set complete-=i
set smarttab

set nrformats-=octal

if !has('nvim') && &ttimeoutlen == -1
  set ttimeout
  set ttimeoutlen=100
endif

set incsearch
" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
endif

set laststatus=2
set ruler
set wildmenu

if !&scrolloff
  set scrolloff=1
endif
if !&sidescrolloff
  set sidescrolloff=5
endif
set display+=lastline

if &encoding ==# 'latin1' && has('gui_running')
  set encoding=utf-8
endif

if &listchars ==# 'eol:$'
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
endif

if v:version > 703 || v:version == 703 && has('patch541')
  set formatoptions+=j " Delete comment character when joining commented lines
endif

if has('path_extra')
  setglobal tags-=./tags tags-=./tags; tags^=./tags;
endif

if &shell =~# 'fish$' && (v:version < 704 || v:version == 704 && !has('patch276'))
  set shell=/usr/bin/env\ bash
endif

set autoread

if &history < 1000
  set history=1000
endif
if &tabpagemax < 50
  set tabpagemax=50
endif
if !empty(&viminfo)
  set viminfo^=!
endif
set sessionoptions-=options
set viewoptions-=options

" Allow color schemes to do bright colors without forcing bold.
if &t_Co == 8 && $TERM !~# '^Eterm'
  set t_Co=16
endif

" Load matchit.vim, but only if the user hasn't installed a newer version.
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &runtimepath) ==# ''
  runtime! macros/matchit.vim
endif

if empty(mapcheck('<C-U>', 'i'))
  inoremap <C-U> <C-G>u<C-U>
endif
if empty(mapcheck('<C-W>', 'i'))
  inoremap <C-W> <C-G>u<C-W>
endif

" vim:set ft=vim et sw=2:

" -----------
" Environment
" -----------

set scrolloff=3
set wrap
set wrapmargin=2
set textwidth=79
set linebreak
set nolist
display+=lastline
set textwidth=80
set formatoptions+=t

" Encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
set ttyfast

" Tabs. May be overridden by autocmd rules
set tabstop=4
set softtabstop=0
set shiftwidth=4
set expandtab

" Map leader to ,
let mapleader=','

" Enable hidden buffers
set hidden

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase
set number

silent function! OSX()
    return has('macunix')
endfunction
silent function! LINUX()
    return has('unix') && !has('macunix') && !has('win32unix')
endfunction
silent function! WINDOWS()
    return  (has('win32') || has('win64'))
endfunction

"" Copy/Paste/Cut
if has('unnamedplus')
  set clipboard=unnamed,unnamedplus
endif

" use system clipboard
" " https://anuragpeshne.github.io/essays/vim/7.html
" noremap y "*y
" noremap yy "*yy
" noremap Y "*y$
" noremap x "*x
" noremap dd "*dd

set omnifunc=syntaxcomplete#Complete
set spell

" Smart mapping for tab completion
" https://vim.fandom.com/wiki/Smart_mapping_for_tab_completion
function! Smart_TabComplete()
  let line = getline('.')                         " current line

  let substr = strpart(line, -1, col('.')+1)      " from the start of the current
                                                  " line to one character right
                                                  " of the cursor
  let substr = matchstr(substr, "[^ \t]*$")       " word till cursor
  if (strlen(substr)==0)                          " nothing to match on empty string
    return "\<tab>"
  endif
  let has_period = match(substr, '\.') != -1      " position of period, if any
  let has_slash = match(substr, '\/') != -1       " position of slash, if any
  if (!has_period && !has_slash)
    return "\<C-X>\<C-P>"                         " existing text matching
  elseif ( has_slash )
    return "\<C-X>\<C-F>"                         " file matching
  else
    return "\<C-X>\<C-O>"                         " plugin matching
  endif
endfunction

" inoremap <tab> <c-r>=Smart_TabComplete()<CR>
noremap D "*D

set completefunc+=emoji#complete

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-sensible'
Plug 'lifepillar/vim-mucomplete'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-obsession'
Plug 'raimondi/delimitmate'
Plug 'ctrlpvim/ctrlp.vim'

Plug 'dense-analysis/ale'

Plug 'lifepillar/vim-solarized8'

Plug 'junegunn/vim-easy-align'
Plug 'mg979/vim-visual-multi'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'itchyny/lightline.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'mhinz/vim-startify'
Plug 'pechorin/any-jump.vim'
Plug 'machakann/vim-highlightedyank'
Plug 'reedes/vim-thematic'
Plug 'airblade/vim-gitgutter'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

Plug 'reedes/vim-colors-pencil'
Plug 'andreypopp/vim-colors-plain'

Plug 'reedes/vim-pencil', { 'for': ['text', 'notes', 'markdown', 'mkd'] }
Plug 'reedes/vim-wordy', { 'for': ['text', 'notes', 'markdown', 'mkd'] }
Plug 'reedes/vim-lexical', { 'for': ['text', 'notes', 'markdown', 'mkd'] }
Plug 'junegunn/vim-emoji'

call plug#end()
"
" Copy to clipboard
noremap <Leader>y "*y
noremap <Leader>p "*p
noremap <Leader>Y "+y
noremap <Leader>P "+p

augroup FiletypeGroup
    autocmd!
    au BufNewFile,BufRead *.jsx set filetype=javascript.jsx
augroup END

let g:ale_linter_aliases = {
            \ 'jsx': ['css', 'javascript'],
            \ 'vue': ['eslint', 'vls']
            \}

let g:ale_linters = {
            \ 'jsx': ['stylelint', 'eslint'],
            \ 'rust': ['analyzer', 'cargo', 'rls'],
            \ 'vim': ['vint'],
            \ 'zsh': ['shell', 'shellcheck'],
            \}


let g:ale_fixers = {
            \ '*': ['remove_trailing_lines', 'trim_whitespace'],
            \ 'rust': ['rustfmt'],
            \}

let g:ale_fix_on_save = 1

let g:ale_sign_column_always = 1
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_lint_on_insert_leave = 1
let g:ale_lint_on_enter = 1
let g:ale_set_loclist = 1
let g:ale_set_quickfix = 1
let g:ale_open_list = 1
let g:ale_list_window_size = 5

if has('gui_running')
  if has('gui_gtk2')
    set guifont=Dank\ Mono\ Regular:h12
  elseif has('gui_macvim')
    set guifont=Dank\ Mono\ Regular:h12
  elseif has('gui_win32')
    set guifont=Dank\ Mono\ Regular:h12
  endif
endif

nnoremap <silent> <leader>z :Goyo<cr>
augroup no_distraction
    autocmd! User GoyoEnter Limelight
    autocmd! User GoyoLeave Limelight!
augroup END

" lightline configuration
set laststatus=2
if !has('gui_running')
    set t_Co=256
endif
set noshowmode
let g:lightline = {
\ 'colorscheme': 'wombat',
\ }

" Normal mode: Jump to definition under cursore
nnoremap <leader>j :AnyJump<CR>
"
" " Visual mode: jump to selected text in visual mode
xnoremap <leader>j :AnyJumpVisual<CR>
"
" " Normal mode: open previous opened file (after jump)
nnoremap <leader>ab :AnyJumpBack<CR>
"
" " Normal mode: open last closed search window again
nnoremap <leader>al :AnyJumpLastResults<CR>

" Show line numbers in search rusults
let g:any_jump_list_numbers = 0
"
" " Auto search references
let g:any_jump_references_enabled = 1
"
" " Auto group results by filename
let g:any_jump_grouping_enabled = 0

if LINUX() || OSX()
    set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
else
    set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows
endif

let g:thematic#themes = {
\ 'solarized8'  : { 'typeface': 'Dank Mono',
\                  'font-size': 18,
\                },
\ 'plain_dark'  : { 'colorscheme': 'plain',
\                  'background': 'dark',
\                  'typeface': 'Dank Mono',
\                  'font-size': 18,
\                },
\ 'plain_light'  : { 'colorscheme': 'plain',
\                  'background': 'light',
\                  'typeface': 'Dank Mono',
\                  'font-size': 18,
\                },
\ 'pencil_dark' :{ 'colorscheme': 'pencil',
\                  'background': 'dark',
\                  'airline-theme': 'badwolf',
\                  'ruler': 1,
\                  'laststatus': 0,
\                  'typeface': 'Source Code Pro Light',
\                  'font-size': 20,
\                  'transparency': 10,
\                  'linespace': 8,
\                },
\ 'pencil_lite' :{ 'colorscheme': 'pencil',
\                  'background': 'light',
\                  'airline-theme': 'light',
\                  'laststatus': 0,
\                  'ruler': 1,
\                  'typeface': 'Source Code Pro',
\                  'fullscreen': 1,
\                  'transparency': 0,
\                  'font-size': 20,
\                  'linespace': 6,
\                },
\ }

nnoremap <Leader>T :ThematicNext<CR>
nnoremap <Leader>D :Thematic pencil_dark<CR>
nnoremap <Leader>L :Thematic pencil_lite<CR>

let g:thematic#theme_name = 'pencil_dark'

let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_custom_ignore = {
\ 'dir':  '\v[\/]\.(git|hg|svn)$',
\ 'file': '\v\.(exe|so|dll)$',
\ 'link': 'some_bad_symbolic_links',
\ }

" Trigger configuration. You need to change this to something other than <tab>
" if you use one of the following:
" " - https://github.com/Valloric/YouCompleteMe
" " - https://github.com/nvim-lua/completion-nvim
let g:UltiSnipsExpandTrigger='<c-c>'
let g:UltiSnipsJumpForwardTrigger='<c-b>'
let g:UltiSnipsJumpBackwardTrigger='<c-z>'

let g:wordy#ring = [
\ 'weak',
\ ['being', 'passive-voice', ],
\ 'business-jargon',
\ 'weasel',
\ 'puffery',
\ ['problematic', 'redundant', ],
\ ['colloquial', 'idiomatic', 'similies', ],
\ 'art-jargon',
\ ['contractions', 'opinion', 'vague-time', 'said-synonyms', ],
\ 'adjectives',
\ 'adverbs',
\ ]

augroup pencil
    autocmd!
    autocmd FileType markdown,mkd,text,note call pencil#init()
    \ | call lexical#init()
    \ | call wordy#init()
    " \ | call litecorrect#init()
    " \ | call textobj#quote#init()
    " \ | call textobj#sentence#init()
    let g:pencil#wrapModeDefault = 'soft'
    " set wrap
augroup END

noremap <silent> <F8> :<C-u>NextWordy<cr>
xnoremap <silent> <F8> :<C-u>NextWordy<cr>
inoremap <silent> <F8> <C-o>:NextWordy<cr>

nnoremap <leader>e :setlocal spell spelllang=en_US<CR>
nnoremap <leader>f :setlocal spell spelllang=fr_FR<CR>
nnoremap <leader>s :setlocal spell spelllang=es_MX<CR>

nnoremap <leader>g :exe ':silent !firefox % %'<CR>
nnoremap <leader>b :exe ':silent !brave-browser % %'<CR>
nnoremap <leader>c :exe ':silent !chromium-browser % %'<CR>

" noremap ]s )s

nnoremap <Leader>e :s/:\([^:]\+\):/\=emoji#for(submatch(1), submatch(0))/g<CR>
nnoremap <Leader>E :%s/:\([^:]\+\):/\=emoji#for(submatch(1), submatch(0))/g<CR>

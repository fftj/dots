set nocompatible
let mapleader=" "

"=============================================================
" PLUGIN MANAGER: Vundle
"===================== VUNDLE BEGIN ==========================
filetype off  
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
"Install: git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim

"---------------------
" AG SEARCH:
" --------------------
Plugin 'rking/ag.vim'

"=============================================================
" COLOR SCHEME:
"=============================================================
Plugin 'NLKNguyen/papercolor-theme'

"=============================================================
" GENERAL USAGE:
"=============================================================
" Better Tabline Display:
" Plugin 'mkitt/tabline.vim'
" https://github.com/mkitt/tabline.vim

Plugin 'tpope/vim-flagship'

" Text Surrounding:
Plugin 'tpope/vim-surround'
" https://github.com/tpope/vim-surround
" Comment Toggling:
Plugin 'tpope/vim-commentary'  
" https://github.com/tpope/vim-commentary

" File Finder:
Plugin 'kien/ctrlp.vim'
" https://github.com/kien/ctrlp.vim

" Rainbow Parentheses:
Plugin 'kien/rainbow_parentheses.vim'
" https://github.com/kien/rainbow_parentheses.vim
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces
" au Syntax * RainbowParenthesesLoadChevrons
nnoremap <leader>R :RainbowParenthesesToggleAll<CR>
" au VimEnter * RainbowParenthesesToggleAll

" Text Alignment:
Plugin 'godlygeek/tabular'
" https://github.com/godlygeek/tabular
" http://vimcasts.org/episodes/aligning-text-with-tabular-vim/

" Plugin 'junegunn/vim-easy-align'
"start interactive EasyAlign in visual mode (e.g. vip<Enter>)
" vmap <Enter> <Plug>(EasyAlign)

" " Start interactive EasyAlign for a motion/text object (e.g. gaip)
" nmap ga <Plug>(EasyAlign)

" Directory Browser:
Plugin 'tpope/vim-vinegar'
" https://github.com/tpope/vim-vinegar

" Doxygen Tool:
" Plugin 'vim-scripts/DoxygenToolkit.vim'
" https://github.com/mrtazz/DoxygenToolkit.vim

" Git Fugitive Plugin:
Plugin 'tpope/vim-fugitive'

" Source Code Outline Viewer:
"Plugin 'majutsushi/tagbar'
" https://github.com/majutsushi/tagbar

"let g:tagbar_left=1
"nnoremap <leader>t :TagbarOpen j<CR>
"nnoremap <leader>T :TagbarToggle<CR>
"=============================================================
" LANGUAGE SYNTAX ENHANCEMENT:
"=============================================================
" C:
Plugin 'NLKNguyen/c-syntax.vim'

" CPP:
Plugin 'octol/vim-cpp-enhanced-highlight'

" Assembly MIPS:
Plugin 'vim-scripts/mips.vim'
" Assembly GAS:
Plugin 'Shirk/vim-gas'
" DTrace:
Plugin 'vim-scripts/dtrace-syntax-file'

" SystemTap:
Plugin 'nickhutchinson/vim-systemtap'

" Go:
Plugin 'fatih/vim-go'

" PlantUML:
Plugin 'aklt/plantuml-syntax'

" Markdown:
Plugin 'plasticboy/vim-markdown'

" Haskell:
Plugin 'raichoo/haskell-vim'

call vundle#end()            " required
filetype plugin indent on    " required
"====================== VUNDLE END ===========================
" filetype plugin on
set omnifunc=syntaxcomplete#Complete

" Set Color Scheme:
set t_Co=256
color PaperColor " https://github.com/NLKNguyen/papercolor-theme.git

"=============================================================
" Common:
"=============================================================
syntax enable

set hidden

set nobackup
set noswapfile

set encoding=utf-8
set showcmd " display incomplete commands "
set number        " always show line numbers
set ruler laststatus=2  " always show status bar and ruler
set showtabline=2
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P


set expandtab
set tabstop=2     " a tab is four spaces
set backspace=indent,eol,start
                    " allow backspacing over everything in insert mode
set autoindent    " always set autoindenting on
set copyindent    " copy the previous indentation on autoindenting
set smartindent 
set shiftwidth=2  " number of spaces to use for autoindenting
set shiftround    " use multiple of shiftwidth when indenting with '<' and '>'
" set showmatch     " set show matching parenthesis
set ignorecase    " ignore case when searching
set smartcase     " ignore case if search pattern is all lowercase,
                    "    case-sensitive otherwise
set smarttab      " insert tabs on the start of a line according to
                    "    shiftwidth, not tabstop
set hlsearch      " highlight search terms
set incsearch     " show search matches as you type

set history=1000         " remember more commands and search history
set undolevels=1000      " use many muchos levels of undo
set wildignore=*.swp,*.bak,*.pyc,*.class
set title                " change the terminal's title
set visualbell           " don't beep
set noerrorbells         " don't beep

set list
set listchars=tab:>.,trail:.,extends:#,nbsp:.  " highlight whitespaces
au Filetype html,xml setlocal listchars-=tab:>.  " but not in some file types

set nowrap
" set pastetoggle=<F2>
"=============================================================
" Pasting From System Clipboard Without Having To PasteToggle:
"=============================================================
function! WrapForTmux(s)
  if !exists('$TMUX')
    return a:s
  endif

  let tmux_start = "\<Esc>Ptmux;"
  let tmux_end = "\<Esc>\\"

  return tmux_start . substitute(a:s, "\<Esc>", "\<Esc>\<Esc>", 'g') . tmux_end
endfunction

let &t_SI .= WrapForTmux("\<Esc>[?2004h")
let &t_EI .= WrapForTmux("\<Esc>[?2004l")

function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

"=============================================================
" Open And Reload Vimrc:
"=============================================================
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leaver>rv :update <bar> so $MYVIMRC<CR>

"=============================================================
" Toggle Color Column:
"=============================================================
function! ToggleColorFromColumn(columnNumber)
  if &colorcolumn != ''
    set colorcolumn&
  else
    execute "set colorcolumn=" . join(range(a:columnNumber,335), ',')
    " setlocal colorcolumn=+1
  endif
endfunction
 
nnoremap  <space>c :call ToggleColorFromColumn(81)<CR>
"=============================================================


"=============================================================
" Navigation:
"=============================================================
" Easier navigation between opened buffers
nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>

"" Easier navigation between split windows
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

"" Easier navigation between tabs
noremap <leader>` :tabnew<CR>
noremap <leader>n :tabnext<CR>
noremap <leader>b :tabprevious<CR>
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt
noremap <leader>0 :tablast<CR>
noremap <leader>- :Texplore<CR>

" Natural line jumping between wrapped lines
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

"=============================================================
" Folding:
"=============================================================
" TODO: Work on this
"" Folding
set foldlevelstart=99
" au Syntax c,cpp,vim,xml,html,xhtml setlocal foldmethod=syntax
" au Syntax c,cpp,vim,xml,html,xhtml,perl normal zR
"=============================================================



"=============================================================
" Plugin Tabularize: common alignment usage
"=============================================================
nmap <leader>a= :Tabularize /=<CR>
vmap <leader>a= :Tabularize /=<CR>

nmap <leader>a: :Tabularize /:\zs<CR>
vmap <leader>a: :Tabularize /:\zs<CR>

nmap <leader>a, :Tabularize /,<CR>
vmap <leader>a, :Tabularize /,<CR>

nmap <leader>a( :Tabularize /(<CR>
vmap <leader>a( :Tabularize /(<CR>

nmap <leader>a) :Tabularize /)<CR>
vmap <leader>a) :Tabularize /)<CR>

nmap <leader>a{ :Tabularize /{<CR>
vmap <leader>a{ :Tabularize /{<CR>

nmap <leader>a} :Tabularize /}<CR>
vmap <leader>a} :Tabularize /}<CR>

nmap <leader>a[ :Tabularize /[<CR>
vmap <leader>a[ :Tabularize /[<CR>

nmap <leader>a] :Tabularize /]<CR>
vmap <leader>a] :Tabularize /]<CR>

nmap <leader>a<bar> :Tabularize /<bar><CR>
vmap <leader>a<bar> :Tabularize /<bar><CR>

" align the first occurence of ;
nmap <leader>a; :Tabularize /^[^;]*\zs;/l0r1<CR>
vmap <leader>a; :Tabularize /^[^;]*\zs;/l0r1<CR>
" nmap <leader>a; :Tabularize /;/l0<CR>
" vmap <leader>a; :Tabularize /;/l0<CR>

" align the first occurence of #
nmap <leader>a# :Tabularize /^[^#]*\zs#/l0r1<CR>
vmap <leader>a# :Tabularize /^[^#]*\zs#/l0r1<CR>
" nmap <leader>a# :Tabularize /#/l0<CR>
" vmap <leader>a# :Tabularize /#/l0<CR>


nmap <leader>a\ :Tabularize /^[^\n]*\zs\<CR>
vmap <leader>a\ :Tabularize /^[^\n]*\zs\<CR>
"=============================================================
"QUICKFIX: shortcuts
"=============================================================
nnoremap Q :copen<CR>
" map <F3> :cprevious<CR>
" map <F4> :cnext<CR>
map [q :cprevious<CR>
map ]q :cnext<CR>
map [Q :cfirst<CR>
map ]Q :clast<CR>



"=============================================================
" Convenient Way To Send Command To The Shell:
"=============================================================
let thisFileName      = "%"
let thisFileNameNoExt = "%:r"
let absFilePath       = "%:p"
let absFilePathNoExt  = "%:p:r"
let absDirectoryPath  = "%:p:h"

function! SendToShell(command)
  :exec("!" . "printf \"\033c\"; " . a:command)
endfunction

function! RunCmd(command)
  return 'echo "$ ' . a:command . '" && ' . a:command
endfunction

function! RunChainCmd(command)
  return 'echo "$ ' . a:command . '" && ' . a:command . " && "
endfunction

"=============================================================
" Command Line Argument:
"=============================================================
let args=""

"=============================================================
" Execute Any Script:
"=============================================================
" ./thisFileName
nnoremap <leader>rr :update <bar> call SendToShell(
      \ RunCmd ("./" . thisFileName . " " . args) )<CR>

nmap <F9> <leader>rr
imap <F9> <esc><leader>rr

" sudo ./thisFileName
nnoremap <leader>sr :update <bar> call SendToShell(
      \ RunCmd ("sudo ./" . thisFileName . " " . args) )<CR>

if has("gui_running")
    set guifont=Droid\ Sans\ Mono\ 16
    map <silent> <S-Insert> "+p
    set guioptions-=m
    set guioptions-=T
    set guioptions-=L
    set guioptions-=r
    set guioptions-=e
    imap <silent> <S-Insert> <Esc>"+pa
    imap jj <Esc>
    map jj <Esc>
endif

nnoremap <Leader>o :CtrlP<CR>
nnoremap <Leader>w :w<CR>
let g:ctrlp_map = '<Leader>t'
let g:ctrlp_match_window_bottom = 1
let g:ctrlp_match_window_reversed = 0
let g:ctrlp_custom_ignore = '\v\~$|\.(o|swp|pyc|wav|mp3|ogg|blend)$|(^|[/\\])\.(hg|git|bzr)($|[/\\])|__init__\.py'
let g:ctrlp_working_path_mode = 0
let g:ctrlp_dotfiles = 0
let g:ctrlp_switch_buffer = 0
let g:ctrlp_use_caching = 0
if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor

    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
else
  let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
  let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<space>', '<cr>', '<2-LeftMouse>'],
    \ }
endif

let g:tablabel =
      \ "%N%{flagship#tabmodified()} %{flagship#tabcwds('shorten',',')}"

vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]
set timeoutlen=200
set keymap=apl
map <Leader><Enter> :w <CR> :! apl -q --noColor -f % <CR>
nnoremap \ :Ag<SPACE>

function! CleverTab()
    if strpart( getline('.'), 0, col('.')-1 ) =~ '^\s*$'
      return "\<Tab>"
    else
      return "\<C-N>"
    endif
endfunction
inoremap <Tab> <C-R>=CleverTab()<CR>

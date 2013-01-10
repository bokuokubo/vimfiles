" Stuff that needs to be called right at the start
" Remove vi backwards compatibility & set up pathogen
" This filetype toggling is for compatibility with mac & debian;
" see http://andrewho.co.uk/weblog/vim-pathogen-with-mutt-and-git
filetype on
filetype off
set nocompatible
call pathogen#infect()
call pathogen#helptags()
filetype plugin indent on

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" General settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nowrap                     " Don't wrap lines
set ts=4                       " A tab is four spaces
set sw=4                       " Autoindent tab is four spaces
set tw=80                      " Column width 80 characters
set backspace=indent,eol,start " Allow backspacing over everything in insert mode
set autoindent                 " Always set autoindenting on
set copyindent                 " Copy the previous indentation on autoindenting
set number                     " Always show line numbers
set ruler                      " Show line and column number in status bar
set ls=2                       " Always show status bar

" Mouse support (https://wincent.com/blog/tweaking-command-t-and-vim-for-use-in-the-terminal-and-tmux)
if has('mouse')
  set mouse=a
  if &term =~ "xterm" || &term =~ "screen"
    " for some reason, doing this directly with 'set ttymouse=xterm2'
    " doesn't work -- 'set ttymouse?' returns xterm2 but the mouse
    " makes tmux enter copy mode instead of selecting or scrolling
    " inside Vim -- but luckily, setting it up from within autocmds
    " works
    autocmd VimEnter * set ttymouse=xterm2
    autocmd FocusGained * set ttymouse=xterm2
    autocmd BufEnter * set ttymouse=xterm2
  endif
endif

" Folds
set foldmethod=syntax
set foldlevel=20               " Default to have all folds open

" Change the mapleader from \ to ,
let mapleader=","
let g:mapleader=","

" Show tabs
set list
set listchars=tab:>-

" Tab expansion
set wildmode=longest,list

" Fancy searching
set hlsearch
set incsearch

" Check file modified on cursor move
au CursorHold * checktime
au FocusGained * checktime

" Disable vim backup
set nobackup
set noswapfile

" Big history
set history=1000
set undolevels=1000

" Easy window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" I use ack (http://betterthangrep.com/)
" (Temporarily disabled)
"set grepprg=ack-grep\ --column
"set grepformat=%f:%l:%c:%m

" I want to use a login shell so I get all my .profile settings in :shell
set shell=bash\ --login

" Set tags files
set tags+=~/.tags/cpp.tags
set tags+=~/.tags/ctr_sdk.tags
set tags+=~/.tags/ctr_nw.tags
set tags+=~/.tags/ctr_nex.tags
set tags+=~/.tags/ctr_pia.tags

" Generate and set local tags file
command GenerateTags :silent execute "!exctags -R . &" | redraw!
command GenerateCPPTags :silent execute "!exctags --c++-kinds=+p --fields=+iaS --extra=+q --language-force=C++ -R . &" | redraw!
command GenerateSourceTags :silent execute "!exctags --c++-kinds=+p --fields=+iaS --extra=+q --language-force=C++ -R source/ &" | redraw!
set tags+=./tags

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Language settings (Spoken)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set encoding=utf-8
set fileencodings=utf-8,iso-2022-jp,euc-jp,cp932
set ambiwidth=double            "~/.Xresources should have XTerm*cjkWidth: true
let $LANG='ja'


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Syntax / Colour settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Turn on syntax highlighting and filetype detection
syntax on
hi Todo cterm=BOLD ctermbg=red ctermfg=white

" Mark after textwidth-defined column
" Only for code (and when not diffing)
if &diff
else
au FileType c,cpp exec 'match Todo /\%>' . &textwidth . 'v.\+/'
endif

" Theme settings
set background=dark
colorscheme solarized

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Language settings (programming)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Some C Shortcuts
ab #d #define
ab #i #include
ab #e #endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Leader keymappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>t :tabe

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Miscellaneous
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Session shortcuts -- I use this to save and restore a complete session
"                      including all tabs that may be open
set sessionoptions=blank,buffers,curdir,folds,help,resize,tabpages,winsize
map s  :source ~/.vim/.session<cr>t sessionoptions=blank,buffers,curdir,folds,help,resize,tabpages,winsize
map f  :source ~/.vim/.session<cr>

" I work with a scripting language called pawn a lot.
" I've copied the C syntax file into syntax/pawn for this purpose
let filetype_p = "pawn"
let filetype_inc = "pawn"

" Support visual-studio style error output
set errorformat+=\ %#%f(%l\\\,%c):\ %m

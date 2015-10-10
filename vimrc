set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

Bundle 'L9'

Plugin 'tpope/vim-fugitive'
Plugin 'flazz/vim-colorschemes'
Plugin 'vim-scripts/fountain.vim'
Plugin 'vim-scripts/fountainwiki.vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'kchmck/vim-coffee-script'
Plugin 'airblade/vim-rooter'
Plugin 'tpope/vim-surround'
Plugin 'kien/ctrlp.vim'
Plugin 'bling/vim-airline'
Plugin 'majutsushi/tagbar'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

"" Numbers and  length
set number
set autoindent
set nocompatible
filetype plugin on
filetype indent on
syntax on

"" Color
set t_Co=256

colorscheme molokai
set background=light

"" Easier moving of code blocks
vnoremap < <gv 
vnoremap > >gv 

"" The alternative Esc.
inoremap jj <esc>l

"" Four spaces instead of tab.
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set smarttab

"" Easier split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

"" More natural split opening
set splitbelow
set splitright

"" Basic tab completion
imap <Tab> <C-P>

" Settings for VimClojure
let vimclojure#HighlightBuiltins = 1    " Highlight Clojure's builtins
let vimclojure#ParenRainbow = 1         " Rainbow parentheses'!

" Settings for pydoc plugin
let g:pydoc_open_cmd = 'vsplit' 

" NERDTree side panel
map \\ :NERDTreeToggle<CR>

"" FuzzyFinder
nmap ,f :FufFileWithCurrentBufferDir<CR>
nmap ,b :FufBuffer<CR>
nmap ,t :FufTaggedFile<CR>

" Vim 80 column
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%81v.\+/

" Two spaces indentation
autocmd Filetype ruby setlocal ts=2 sts=2 sw=2
autocmd Filetype eruby setlocal ts=2 sts=2 sw=2
autocmd Filetype java setlocal ts=2 sts=2 sw=2
autocmd Filetype html setlocal ts=2 sts=2 sw=2
autocmd Filetype css setlocal ts=2 sts=2 sw=2
autocmd BufNewFile,BufReadPost *.coffee setl shiftwidth=2 expandtab

au BufRead,BufNewFile *.fountain set filetype=fountain

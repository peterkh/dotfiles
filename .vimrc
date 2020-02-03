" Create the autocmd group used by all my autocmds (cleared when sourcing vimrc)
augroup vimrc
  autocmd!
augroup END

" This has to be before everything else because the rest only works if vim-plug
" is installed
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Specify a directory for plugins
call plug#begin('~/.vim/plugged')

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } " Install fzf for user
Plug 'junegunn/fzf.vim'                                           " Fzf vim plugin
Plug 'airblade/vim-gitgutter'                                     " Git integration
Plug 'jiangmiao/auto-pairs'                                       " Auto pairs
Plug 'hashivim/vim-terraform'                                     " Syntax for terraform
Plug 'ekalinin/Dockerfile.vim'                                    " Syntax for docker
Plug 'Yggdroot/indentLine'                                        " Show indented lines
Plug 'godlygeek/tabular'                                          " Better tab
Plug 'scrooloose/nerdtree'                                        " File tree browser
Plug 'scrooloose/nerdcommenter'                                   " Code commenter


" Initialize plugin system
call plug#end()

" Install missing plugins automatically on startup

autocmd vimrc VimEnter *
      \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
      \|   PlugInstall --sync | q | runtime vimrc
      \| endif


syntax on
syntax enable
set nocompatible
set mouse=a

set clipboard=unnamed
set clipboard=unnamedplus

set number
" set relativenumber
set cursorline

set background=dark

set autoindent
set smartindent
set smarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab

filetype plugin on
filetype indent on

" autoline terraform blocks
let g:terraform_align=1

" nuke all trailing space before a write
au BufWritePre * :%s/\s\+$//e

" enable swapfile
set swapfile
set directory=$HOME/.vim/swap

" Automatically create directory for swapfiles if it does not exist
if !isdirectory(expand('~').'/.vim/swap')
  !mkdir -p $HOME/.vim/swap
endif

" fuzzy completion
set runtimepath+=/.fzf

" set utf8 encoding by default
set encoding=utf8


" NERDTree ----------------------------------
autocmd vimenter * if !argc() | NERDTree | endif
autocmd bufenter * if (winnr('$') == 1 && exists('b:NERDTreeType') && b:NERDTreeType == 'primary') | q | endif
nmap <silent><F6> :NERDTreeToggle<CR>
syn match NERDTreeTxtFile #^\s\+.*txt$#
highlight NERDTreeTxtFile ctermbg=red ctermfg=magenta
let NERDTreeRespectWildIgnore=1

" Show hidden files
let NERDTreeShowHidden=1

" Disable editor mode in default bar
set noshowmode

" Detect file encoding
if has('multi_byte')
  if &termencoding ==# ''
    let &termencoding = &encoding
    endif
  set encoding=utf-8
  setglobal fileencoding=utf-8
  setglobal bomb
  set fileencodings=ucs-bom,utf-8,latin1
endif

" install vim-plug if not present
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

function! BuildYCM(info)
  if a:info.status == 'installed' || a:info.force
    " Compile with C-family, Java-/Typescript, and Java support
    !./install.py --clangd-completer --ts-completer --java-completer
  endif
endfunction


" ============ Plugins ============

call plug#begin('~/.vim/plugged')

Plug 'ycm-core/YouCompleteMe', { 'do': function('BuildYCM') }
Plug 'preservim/nerdtree'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf', { 'do': { -> fzf#install()  }  }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'flazz/vim-colorschemes'
Plug 'dense-analysis/ale'

call plug#end()

" YCM
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_extra_conf_globlist = [ '~/Uni/Master/AdvCompProg/contests/.ycm_extra_conf.py' ]

" quit vim if the last window is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif 

" colorscheme
set t_Co=256
colorscheme Tomorrow-Night-Eighties
" use IncSearch style for Search
" hi clear Search
" hi IncSearch ctermfg=234 ctermbg=75 cterm=NONE guifg=#1C1C1C guibg=#5FAFFF gui=NONE
" hi Search ctermfg=234 ctermbg=75 guifg=#1C1C1C guibg=#5FAFFF

" ALE
let g:ale_fixers = {'python': ['autopep8']}

" ============ Keybinds ============

" jump forward/backward
nnoremap <C-k> <C-o>
nnoremap <C-j> <C-i>

nnoremap <leader>g :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>G :YcmCompleter GoToDefinition<CR>

" open fzf
nnoremap <C-o> :Files<CR>

" open NERDTree
nnoremap <C-p> :NERDTreeToggle<Cr>


" ============ General ============

syntax enable        " enable syntax processing

set showcmd          " show command in bottom bar

set hlsearch         " highlight matches
set incsearch        " search as characters are entered

set relativenumber   " Add line numbersr
set number

" set cursorline       " highlight current line

set autoindent       " copy indent from current line when starting new line
set smartindent      " add and remove indents when it makes sense
set tabstop=2        " number of visual spaces per TAB
set softtabstop=-1   " number of spaces in tab while editing. Same as tabstop
set shiftwidth=2     " the number of spaces in an 'indent'
set expandtab        " write spaces instead of tabs when pressing TAB

set ignorecase       " ignore case during search
set smartcase        " don't ignore case during search if upper case character is used

" allow backspacing over lines, indents, the start of insertion
set backspace=eol,indent,start      
set scrolloff=3      " always display lines above/below cursor
" share clipboard with OS
set clipboard=unnamed

filetype indent on   " load filetype-specific indent files

autocmd FileType markdown setlocal spell " Enable spell checking for markdown files


" Prevent vim from starting in replace mode on ubuntu
nnoremap <esc>^[ <esc>^[

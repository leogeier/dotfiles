" install vim-plug if not present
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

function! BuildYCM(info)
  if a:info.status == 'installed' || a:info.force
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
Plug 'tpope/vim-commentary'
Plug 'dikiaap/minimalist'

call plug#end()

" YCM
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'

" quit vim if the last window is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif 

" colorscheme
set t_Co=256
colorscheme minimalist


" ============ Keybinds ============

" open fzf
:nnoremap <C-o> :Files<CR>

" open NERDTree
:nnoremap <C-p> :NERDTreeToggle<Cr>


" ============ General ============

syntax enable        " enable syntax processing

set showcmd          " show command in bottom bar

" allow backspacing over lines, indents, the start of insertion
set backspace=eol,indent,start      

set hlsearch         " highlight matches
set incsearch        " search as characters are entered

set relativenumber   " Add line numbersr
set number

" set cursorline       " highlight current line

set tabstop=2        " number of visual spaces per TAB
set softtabstop=2    " number of spaces in tab while editing
set shiftwidth=2     " the number of spaces in an 'indent'
set expandtab        " write spaces instead of tabs when pressing TAB

set scrolloff=3      " always display lines above/below cursor

filetype indent on   " load filetype-specific indent files

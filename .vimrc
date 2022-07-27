"install vim-plug if not present
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

function! BuildYCM(info)
  if a:info.status == 'installed' || a:info.force
    " Compile with C-family, Java-/Typescript, and Java support
    !./install.py --clangd-completer --ts-completer --java-completer --rust-completer
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
Plug 'dense-analysis/ale'
Plug 'bfrg/vim-cpp-modern'
Plug 'joshdick/onedark.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'habamax/vim-godot'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'

call plug#end()

" YCM
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_extra_conf_globlist = [ '~/Uni/Master/AdvCompProg/contests/.ycm_extra_conf.py',
                                \ '/home/leo/Uni/Master/SysCpp/exercises/.ycm_extra_conf.py' ]
let g:ycm_always_populate_location_list = 1
let g:ycm_language_server = [
  \   {
  \     'name': 'cmake',
  \     'cmdline': ['cmake-language-server'],
  \     'filetypes': ['cmake'],
  \   },
  \   {
  \     'name': 'godot',
  \     'filetypes': ['gdscript'],
  \     'project_root_files': ['project.godot'],
  \     'port': 6008,
  \   },
  \ ]
  " \     'project_root_files': ['build/'],

" quit vim if the last window is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif 

" colorscheme
set t_Co=256
colorscheme onedarksalad
" use IncSearch style for Search
" hi clear Search
" hi IncSearch ctermfg=234 ctermbg=75 cterm=NONE guifg=#1C1C1C guibg=#5FAFFF gui=NONE
" hi Search ctermfg=234 ctermbg=75 guifg=#1C1C1C guibg=#5FAFFF

" ALE
autocmd BufRead,BufNewFile *.geojson set filetype=json " geojson handled like json

let g:ale_fixers = {'python': ['autopep8'],
                  \ 'javascript': ['eslint'],
                  \ 'typescript': ['eslint', 'prettier', 'tslint'],
                  \ 'typescriptreact': ['eslint', 'prettier'],
                  \ 'json': ['prettier'],
                  \ 'cpp': ['clang-format', 'clangtidy']}
let g:ale_python_auto_pipenv = 1
" let g:ale_linter_aliases = {'typescriptreact': 'typescript'}

" ============ Keybinds ============

" jump forward/backward
nnoremap <C-k> <C-o>
nnoremap <C-j> <C-i>

nnoremap <leader>g :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>G :YcmCompleter GoToDefinition<CR>

nnoremap <leader>r :YcmCompleter GoToReferences<CR>
nnoremap <leader>d :YcmCompleter FixIt<CR>

nnoremap <leader>n :YcmCompleter RefactorRename 

nnoremap <leader>q :YcmRestartServer<CR>

nnoremap <leader>h :bp<CR>
nnoremap <leader>l :bn<CR>

nnoremap <C-h> :tabp<CR>
nnoremap <C-l> :tabn<CR>

" navigate location list
nnoremap <C-n> :lbelow<CR>
nnoremap <C-m> :labove<CR>

" open fzf
nnoremap <C-o> :Files<CR>
nnoremap <C-i> :Rg<CR>

" open NERDTree
nnoremap <C-p> :NERDTreeToggle<Cr>

" autofix lint
nnoremap <leader>f :ALEFix<CR>

" Remove highlight
nnoremap <leader>H :noh<CR>

" Enable file select on <Enter> in quickfix window
autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>
" Open quickfix files in new tab
autocmd FileType qf nnoremap <C-t> <C-W><Enter><C-W>T

" ============ General ============

syntax enable        " enable syntax processing

set showcmd          " show command in bottom bar

set hlsearch         " highlight matches
set incsearch        " search as characters are entered

set relativenumber   " Add line numbersr
set number

" set cursorline       " highlight current line

" set autoindent       " copy indent from current line when starting new line
" set smartindent      " add and remove indents when it makes sense
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
set cinoptions=g0

autocmd FileType markdown setlocal spell " Enable spell checking for markdown files

set directory=$HOME/.vim/swapfiles  " put swapfiles in this dir, not the one containing the file

set colorcolumn=80,100,120 " Add line length markers
set cursorline       " Highlight line of cursor

set laststatus=2 " always show status line

set formatoptions+=rco

set splitright " vertical splits put the new buffer on the right

" Prevent vim from starting in replace mode on ubuntu
nnoremap <esc>^[ <esc>^[

set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'scrooloose/nerdtree'
Plugin 'airblade/vim-gitgutter'
Plugin 'rust-lang/rust.vim'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-fugitive'
call vundle#end()
filetype plugin indent on


set number
set numberwidth=1
set relativenumber
set autoindent
set nowrap
set cursorline
set cursorcolumn
syntax on
set incsearch
set t_Co=256
set background=dark
colorscheme thaumaturge
let g:thaumaturge_termcolors=256

set hidden
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'

nnoremap tt  :edit<Space>
nnoremap td  :bp <BAR> bd #<CR>
nnoremap tj  :bnext<CR>
nnoremap tk  :bprevious<CR>
nnoremap tl  :ls<CR>
nnoremap <C-n> :NERDTreeToggle<CR>

"<F9> does the build process and then runs
"<F10> does a special run (nocompile, test, etc.)
autocmd FileType java    map <buffer> <F9>  :wa <C-v><C-j> !javac % -Xdiags:verbose<C-v><C-j> !java %:r <CR><CR>
autocmd FileType java    map <buffer> <F10> :wa <C-v><C-j> !javac % <CR><CR>
autocmd FileType cpp     map <buffer> <F9>  :wa <C-v><C-j> !g++ -std=c++14 -Wall -Wextra -Wpedantic -Wdouble-promotion -Wformat-nonliteral -Wformat-security -Wformat-y2k -Wformat-signedness -Wmissing-include-dirs -Wswitch-enum -Wuninitialized -Wcast-qual -Wcast-align -Wzero-as-null-pointer-constant -Wdate-time -Wlogical-op -Winline -Winvalid-pch -o %:p:r % <C-v><C-j> !%:p:r <CR><CR>
autocmd FileType cpp     map <buffer> <F10> :wa <C-v><C-j> !g++ -std=c++14 -Wall -Wextra -Wpedantic -Wdouble-promotion -Wformat-nonliteral -Wformat-security -Wformat-y2k -Wformat-signedness -Wmissing-include-dirs -Wswitch-enum -Wuninitialized -Wcast-qual -Wcast-align -Wzero-as-null-pointer-constant -Wdate-time -Wlogical-op -Winline -Winvalid-pch -o %:p:r % <CR><CR>
autocmd FileType c       map <buffer> <F9>  :wa <C-v><C-j> !gcc -Wall -Wextra -Wpedantic -Wdouble-promotion -Wformat-nonliteral -Wformat-security -Wformat-y2k -Wmissing-include-dirs -Wswitch-enum -Wuninitialized -Wcast-qual -Wcast-align -Wlogical-op -Winline -Winvalid-pch -o %:p:r % <C-v><C-j> !%:p:r <CR><CR>
autocmd FileType c       map <buffer> <F10> :wa <C-v><C-j> !gcc -Wall -Wextra -Wpedantic -Wdouble-promotion -Wformat-nonliteral -Wformat-security -Wformat-y2k -Wmissing-include-dirs -Wswitch-enum -Wuninitialized -Wcast-qual -Wcast-align -Wlogical-op -Winline -Winvalid-pch -o %:p:r % <CR>
autocmd FileType ruby    map <buffer> <F9>  :wa <C-v><C-j> !ruby % <CR>
autocmd FileType rust    map <buffer> <F9>  :wa <C-v><C-j> !cargo run <CR>
autocmd FileType rust    map <buffer> <F10> :wa <C-v><C-j> !cargo +nightly clippy<CR>
autocmd FileType rust    map <buffer> <C-F10> :wa <C-v><C-j> !cargo test -- --nocapture<CR>
autocmd FileType haskell map <buffer> <F9>  :wa <C-v><C-j> !ghc --make %:p:r <C-v><C-j> !%:p:r <CR><CR>
autocmd FileType haskell map <buffer> <F10> :wa <C-v><C-j> !ghc --make %:p:r <CR>
autocmd FileType prolog  map <buffer> <F9>  :wa <C-v><C-j> !swipl %:p <CR>

"File-specific indentations here
autocmd FileType haskell setlocal shiftwidth=4 tabstop=4 expandtab

"Turn on English spellcheck in .txt and .md files along with linewrapping
autocmd BufRead,BufNewFile *.md,*.txt setlocal wrap linebreak nolist spell spelllang=en_us
"Upgrade movement commands to move on the graphical line, not the textual line (for wrapping files)
autocmd FileType text map <buffer> j gj
autocmd FileType text map <buffer> k gk
autocmd FileType markdown map <buffer> j gj
autocmd FileType markdown map <buffer> k gk

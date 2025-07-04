set nocompatible
filetype off
set nomodeline

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
Plugin 'lervag/vimtex'
" Colorschemes
Plugin 'baines/vim-colorscheme-thaumaturge'
Plugin 'ajmwagar/vim-deus'
Plugin 'altercation/vim-colors-solarized'
" Other Stuff
"Plugin 'vim-syntastic/syntastic'
Plugin 'tidalcycles/vim-tidal'
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
set lazyredraw
"set undofile
set t_Co=256
set background=dark
"colorscheme thaumaturge
colorscheme deus
let g:thaumaturge_termcolors=256
" set clipboard^=unnamed " Use system clipboard for yank and paste
"Turn on English spellcheck
"(in code files, will only apply to comments if syntax is correctly declared)
set spell spelllang=en_us
" Allows editing past the end of the line
"set virtualedit=all

set hidden
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'

" Set up LaTeX according to
" https://castel.dev/post/lecture-notes-1/
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
"let g:vimtex_quickfix_mode=0
"set conceallevel=1
"let g:tex_conceal='abdmg'

nnoremap tt  :edit<Space>
nnoremap td  :bp <BAR> bd #<CR>
nnoremap tj  :bnext<CR>
nnoremap tk  :bprevious<CR>
nnoremap tl  :ls<CR>
nnoremap <C-n> :NERDTreeToggle<CR>
map <Leader>s :Gstatus<CR>

"<F9> does the build process and then runs
"<F10> does a special run (nocompile, test, etc.)
autocmd FileType java    map <buffer> <F9>  :wa <C-v><C-j> !javac % -Xdiags:verbose<C-v><C-j> !java %:r <CR><CR>
autocmd FileType java    map <buffer> <F10> :wa <C-v><C-j> !javac % <CR><CR>
" switch enum was causing errors even with a default
autocmd FileType cpp     map <buffer> <F9>  :wa <C-v><C-j> !g++ -std=c++14 -Wall -Wextra -Wpedantic -Wdouble-promotion -Wformat-nonliteral -Wformat-security -Wformat-y2k -Wformat-signedness -Wmissing-include-dirs -Wuninitialized -Wcast-qual -Wcast-align -Wdate-time -Wlogical-op -Winline -Winvalid-pch -o %:p:r % <C-v><C-j> !%:p:r <CR><CR>
autocmd FileType cpp     map <buffer> <F10> :wa <C-v><C-j> !g++ -std=c++14 -Wall -Wextra -Wpedantic -Wdouble-promotion -Wformat-nonliteral -Wformat-security -Wformat-y2k -Wformat-signedness -Wmissing-include-dirs -Wuninitialized -Wcast-qual -Wcast-align -Wdate-time -Wlogical-op -Winline -Winvalid-pch -o %:p:r % <CR><CR>
autocmd FileType c       map <buffer> <F9>  :wa <C-v><C-j> !gcc -Wall -Wextra -Wpedantic -Wdouble-promotion -Wformat-nonliteral -Wformat-security -Wformat-y2k -Wmissing-include-dirs -Wswitch-enum -Wuninitialized -Wcast-qual -Wcast-align -Wlogical-op -Winline -Winvalid-pch -o %:p:r % <C-v><C-j> !%:p:r <CR><CR>
autocmd FileType c       map <buffer> <F10> :wa <C-v><C-j> !gcc -Wall -Wextra -Wpedantic -Wdouble-promotion -Wformat-nonliteral -Wformat-security -Wformat-y2k -Wmissing-include-dirs -Wswitch-enum -Wuninitialized -Wcast-qual -Wcast-align -Wlogical-op -Winline -Winvalid-pch -o %:p:r % <CR>
autocmd FileType ruby    map <buffer> <F9>  :wa <C-v><C-j> !ruby % <CR>
autocmd FileType rust    map <buffer> <F9>  :wa <C-v><C-j> !cargo run <CR>
autocmd FileType rust    map <buffer> <F10> :wa <C-v><C-j> !cargo clippy<CR>
autocmd FileType rust    map <buffer> <C-F10> :wa <C-v><C-j> !cargo test -- --nocapture<CR>
autocmd FileType haskell map <buffer> <F9>  :wa <C-v><C-j> !ghc --make %:p:r <C-v><C-j> !%:p:r <CR><CR>
autocmd FileType haskell map <buffer> <F10> :wa <C-v><C-j> !hlint %:p <CR>
autocmd FileType prolog  map <buffer> <F9>  :wa <C-v><C-j> !swipl %:p <CR>
autocmd FileType perl    map <buffer> <F9>  :wa <C-v><C-j> !perl % <CR>
autocmd FileType python    map <buffer> <F9>  :wa <C-v><C-j> !python % <CR>

"File-specific settings here
autocmd FileType haskell setlocal shiftwidth=4 tabstop=4 expandtab
autocmd FileType asm setlocal shiftwidth=4 tabstop=4 expandtab
autocmd FileType scheme setlocal shiftwidth=2 tabstop=2 expandtab

"Turn on English spellcheck in text files along with linewrapping
autocmd BufRead,BufNewFile *.md,*.txt,*.tex setlocal wrap linebreak nolist spell spelllang=en_us
"Upgrade movement commands to move on the graphical line, not the textual line (for wrapping files)
autocmd FileType text map <buffer> j gj
autocmd FileType text map <buffer> k gk
autocmd FileType markdown map <buffer> j gj
autocmd FileType markdown map <buffer> k gk
autocmd FileType tex map <buffer> j gj
autocmd FileType tex map <buffer> k gk
autocmd FileType markdown set textwidth=65
autocmd FileType javascript set ts=2 sw=2 sts=2 et

autocmd BufRead,BufNewFile *.cabal setlocal expandtab

"Add utility command for hex-editing files
:command Hex %!xxd
:command Unhex %!xxd -r

" Supercharge :set list
" From https://askubuntu.com/a/1044625
set listchars=tab:→\ ,space:·,nbsp:␣,trail:•,eol:¶,precedes:«,extends:»

" Leader
let mapleader = " "

set termguicolors
set number                " turn on line numbers
set nowrap                " don't wrap lines that go over a screens width
set cursorline            " highlight the line the cursor is on
set showmatch
set incsearch             " search as characters are entered
set hlsearch              " highlight matches when searching
set autoread              " Set to auto read when a file is changed from the outside
set lazyredraw            " Don't redraw while executing macros (good performance config)
set nrformats=            " treat all numbers as decimal not octal
set noswapfile            " don't create swap files
set smartcase             " case insensitive search
set mouse=a               " turn the mouse on
set spell spelllang=en_us " spell checking on
set complete+=kspell

:cab f FZF
:cab t Tags

" Fugitive short cuts
:cab gb Gblame

syntax on             " Enable syntax highlighting
filetype on           " Enable filetype detection
filetype indent on    " Enable filetype-specific indenting
filetype plugin on    " Enable filetype-specific plugins
runtime macros/matchit.vim

set expandtab
set tabstop=2 shiftwidth=2 softtabstop=2
set autoindent
set hidden

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Quicker window movement inside terminal session
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-l> <C-\><C-n><C-w>l

" pbcopy clipboard sharing with MacOS
vnoremap \y y:call system("pbcopy", getreg("\""))<CR>
nnoremap \p :call setreg("\"", system("pbpaste"))<CR>p

noremap YY "+y<CR>
noremap P "+gP<CR>
noremap XX "+x<CR>

" Open NERDTree on CTRL + N
map <C-n> :NERDTreeToggle<CR>

" Display extra whitespace
set list listchars=tab:»·,trail:·,nbsp:·

" Use one space, not two, after punctuation.
set nojoinspaces

" Make it obvious where 100 characters is
set textwidth=100
set colorcolumn=+1

" Tab completion
" will insert tab at beginning of line,
" will use completion if not at beginning
set wildmode=list:longest,list:full
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<Tab>"
    else
        return "\<C-p>"
    endif
endfunction
inoremap <Tab> <C-r>=InsertTabWrapper()<CR>
inoremap <S-Tab> <C-n>

" Switch between the last two files
nnoremap <Leader><Leader> <C-^>

" Get off my lawn
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>

" Always use vertical diffs
set diffopt+=vertical

call plug#begin('~/.vim/plugged')

Plug 'morhetz/gruvbox', { 'as': 'gruvbox' }

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'jlanzarotta/bufexplorer'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-commentary'
Plug 'djoshea/vim-autoread'
Plug 'https://github.com/tpope/vim-fugitive.git'

if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
Plug 'wakatime/vim-wakatime'
Plug 'tbodt/deoplete-tabnine', { 'do': './install.sh' }
Plug 'prettier/vim-prettier'

call plug#end()

" Enable autocomplete via deoplete
let g:deoplete#enable_at_startup = 1

""""""""""""
"  Airline
""""""""""""
" set laststatus=2
" let g:airline#extensions#tabline#enabled = 1
" let g:airline#extensions#tabline#fnamemod = ':t'
" let g:airline_theme = 'gruvbox'

set background=dark
let g:gruvbox_contrast_dark = 'hard'

" Trim white space on save
" let g:better_whitespace_enabled=1
" let g:strip_whitespace_on_save=1


" NERDTress File highlighting
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
 exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
 exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

let NERDTreeShowHidden=1

call NERDTreeHighlightFile('ini', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('yml', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('conf', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('json', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('js', 'Red', 'none', '#ffa500', '#151515')
call NERDTreeHighlightFile('rb', 'Magenta', 'none', '#ff00ff', '#151515')
call NERDTreeHighlightFile('ex', 'Magenta', 'none', '#ff00ff', '#151515')

" Colorscheme
colorscheme gruvbox

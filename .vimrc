set nocompatible              " be iMproved
filetype off                  " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'

"==========================
"       Github Repos 
"==========================
Bundle 'majutsushi/tagbar'
Bundle 'shawncplus/phpcomplete.vim'
Bundle 'bling/vim-airline'
Bundle 'L9'
Bundle 'scrooloose/nerdtree'
Bundle 'jistr/vim-nerdtree-tabs'
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/syntastic'
"Bundle 'Valloric/YouCompleteMe'
Bundle 'Valloric/MatchTagAlways'
Bundle 'mattn/emmet-vim'
Bundle 'sjl/gundo.vim.git'
Bundle 'jelera/vim-javascript-syntax'
Bundle 'othree/javascript-libraries-syntax.vim'
Bundle 'Shougo/vimproc'
Bundle 'kien/ctrlp.vim'
Bundle 'naquad/vim-picker'
Bundle 'Shougo/neocomplete.vim'

filetype plugin indent on     " required!
syntax on

" ======================
"      GVim stuff
" ======================
if has("gui_running") 
    set guioptions+=a "Global copying of selected text
    set guioptions+=b "Add Bottom scrollbar
    set guioptions-=T "Remove toolbar

    colorscheme hybrid 
else 
    colorscheme jellybeans
    set t_Co=256
endif

set fillchars+=vert:\│

hi VertSplit ctermbg=0 ctermfg=0

"==================================
"       General configuration 
"==================================

"Use system clipboard
set clipboard=unnamedplus

"some stuff to get the mouse going in term
set mouse=a
set ttymouse=xterm2

set backspace=indent,eol,start
set history=1000

set showcmd
set showmode
set number
set ruler

set incsearch
set hlsearch

set nowrap
set linebreak

" Wild menu
set wildmenu
set wildmode=list:longest,full

"default indent settings
set shiftwidth=4
set softtabstop=4
set expandtab
set autoindent

"folding settings
set foldmethod=indent   "fold based on indent
set foldnestmax=3       "deepest fold is 3 levels
set nofoldenable        "dont fold by defaulti

"javascript syntax libraries 
let g:used_javascript_libs = 'jquery'

" VIM Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_left_sep = '▶'
let g:airline_right_sep = '◀'
let g:airline_section_c = '%t'
let g:airline_theme='tomorrow'

" NERD TREE
"autocmd vimenter * NERDTree
let NERDTreeShowBookmarks = 1

" Gundo ( undo tree )
let g:gundo_width = 30
let g:gundo_right = 1

" Load Tags file from cwd
set tags=tags;
" Remove Preview / scratch window
set completeopt-=preview

"===============
" Youcompleteme
"===============
"
" YCM specific settings
"let g:ycm_collect_identifiers_from_tags_files = 1
"let g:ycm_complete_in_strings = 1
"let g:ycm_seed_identifiers_with_syntax = 1
"let g:ycm_add_preview_to_completeopt = 0

" phpcomplete - stop it from loading matches for everything when it can't find
" it
let g:phpcomplete_complete_for_unknown_classes = 0 

"===================
" NeoComplete Cache
"===================
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_auto_select = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#max_list = 35
let g:neocomplete#enable_fuzzy_completion = 0
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
   let g:neocomplete#sources#omni#input_patterns = {}
endif
let g:neocomplete#sources#omni#input_patterns.php = '[^.\t]->\h\w*\|\h\w*::'

"===============
"   Filetypes  
"===============
let g:mta_filetypes = {
    \ 'html' : 1,
    \ 'xhtml' : 1,
    \ 'xml' : 1,
    \ 'jinja' : 1,
    \ 'php' : 1
    \}

"==============
"   Mappings 
"==============

map <f2> :NERDTreeTabsToggle<CR>
map <f3> :TagbarToggle<CR>
map <f4> :GundoToggle<CR>
set pastetoggle=<f5>

" Force write of files using :w!! 
cmap w!! w !sudo tee % >/dev/null

"================
"     Events
"================

" Rsync the cwd based on the rsync file 
autocmd BufWritePost * :call RsyncCwd()

"If it has an rsync command execute on save
function! RsyncCwd()
    if filereadable( expand( getcwd() . "/rsync.sh" ))
        echo expand( getcwd() . "/rsync.sh" )
      execute "!./rsync.sh" 
    endif
endfunction

"Autocompletion engines
autocmd BufRead, BufNewFile *.phtml setfiletype html
autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTag
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags




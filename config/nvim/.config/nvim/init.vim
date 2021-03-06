let $NVIM_TUI_ENABLE_TRUE_COLOR=1
syntax on

let mapleader=" "
filetype indent on                  " load filetype-specific indent files

set autoread                        " automatically re-read files if unmodified inside Vim. "
set backspace=indent,eol,start      " allow backspace in insert mode "
set belloff=all                     " no sound and flashing "
set clipboard=unnamed               " use normal clipboard
set cmdheight=1                     " command line height "
set noswapfile                      " disable swap files "
set display+=lastline               " always try to show a paragraph’s last line. "
set encoding=utf-8                  " use an encoding that supports unicode "
set expandtab                       " tabs are spaces
set foldenable                      " enable folding
set foldlevelstart=10               " open most folds by default
set foldnestmax=10                  " 10 nested fold max
set formatoptions-=t                " do not automatically wrap text when typing "
set history=1000                    " increase the undo limit "
set hlsearch                        " highlight matches
set ignorecase                      " ignore case when searching "
set incsearch                       " search as characters are entered
set laststatus=2                    " always show status line "
set lazyredraw                      " redraw only when we need to | performance
set linespace=0
set list                            " show “invisible” characters "
set nocursorcolumn                  " don't paint cursor column | performance
set noerrorbells                    " no error bells "
set nospell                         " remove spelling check"
set nowrap                          " do not automatically wrap on load " set number                          " line numbers " set relativenumber                  " relative numbers "
set number                          " line numbers "
set ruler                           " show the line number on the bar "
set scrolljump=8                    " scroll 8 lines at a time at bottom/top | performance
set scrolloff=5                     " keep at least 5 lines above/below "
set showbreak=+++	                " Wrap-broken line prefix "
set sidescrolloff=5                 " keep at least 5 lines left/right "
set showcmd                         " show command in bottom bar, showcmd shows the last command entered in the very bottom right
set showmatch                       " highlight matching [{()}]
set title                           " set the window’s title, reflecting the file currently being edited. "
set wildignore+=.pyc,.swp,ctags     " ignore files matching these patterns when opening files based on a glob pattern "
set wildmenu                        " enhance command-line completion "
set background=dark

" highlight line "
set cursorline
hi cursorline cterm=none term=none
autocmd WinEnter * setlocal cursorline
autocmd WinLeave * setlocal nocursorline
highlight CursorLine guibg=#303000 ctermbg=234

" ctrl + [j,k,l,h] to move in plits "
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>


call plug#begin()

Plug 'Raimondi/delimitMate'                     " automatic closing of quotes, parenthesis, brackets, etc "
Plug 'SirVer/ultisnips'                         " snippets engine."
Plug 'alvan/vim-closetag'                       " Auto-close HTML nodes "
Plug 'ap/vim-css-color'                         " color values as a color in css "
Plug 'editorconfig/editorconfig-vim'            " set editorconfig "
Plug 'fgsch/vim-varnish'                        " Varnish syntax highlighting "
Plug 'honza/vim-snippets'                       " snippets preset "
Plug 'https://github.com/khzaw/vim-conceal'     " visual eye candy "
Plug 'mhinz/vim-startify'                       " startup screen "
Plug 'mileszs/ack.vim'                          " search string "
Plug 'mxw/vim-jsx'                              " Syntax highlighting and indenting for JSX "
Plug 'pangloss/vim-javascript'                  " provides syntax highlighting and improved indentation "
Plug 'isruslan/vim-es6'                         " replacement for vim javascript "
Plug 'posva/vim-vue'                            " .vue support "
Plug 'qpkorr/vim-bufkill'                       " nload, delete or wipe a buffer without closing the window or split "
Plug 'valloric/youcompleteme'                   " fuzzy-search code completion engine "
Plug 'w0rp/ale'                                 " linter "
Plug 'majutsushi/tagbar'                        " tagbar with definitions "
Plug 'tpope/vim-fugitive'
Plug 'leafgarland/typescript-vim'               " Typescript "
Plug 'peitalin/vim-jsx-typescript'              " Typescript with JSX "
Plug 'christoomey/vim-tmux-navigator'           " vim style navigating between tmux and vim "
Plug 'altercation/vim-colors-solarized'         " Solarized theme "
Plug 'dracula/vim', { 'as': 'dracula' }         " Dracula theme "

Plug 'aklt/plantuml-syntax'                     " PlantUML "
Plug 'tyru/open-browser.vim'                    " required by PlantUML previewer"
Plug 'weirongxu/plantuml-previewer.vim'         " PlantUML previewer "

"
" ctrlp
"
Plug 'kien/ctrlp.vim'                           " fuzzy search "
Plug 'tacahiroy/ctrlp-funky'                    " fuzzy find extension to search through definitions "
nmap <leader>p :CtrlP<cr>
nnoremap <leader>. :CtrlPTag<cr>                " Search in Ctags
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](node_modules|bower_components|dist|build|coverage)|(\.(git|hg|svn)|\_site)$',
  \ 'file': '\v\.(exe|so|dll|class|png|jpg|jpeg,ctags,tags)$',
\}

"
" nerdtree
"
Plug 'scrooloose/nerdtree'                      " sitemap in sidebar "
Plug 'ryanoasis/vim-devicons'                   " icons in sidebar "
nmap <leader>n :NERDTreeToggle<cr>
let NERDTreeShowHidden=1                        " show hidden files "

let g:NERDTreeChDirMode       = 2               " Use NerdTree folder as CTRL search directory
let g:ctrlp_working_path_mode = 'rw'
let g:NERDTreeIgnore = ['\.pyc$', '\.swp']

"
" airline
"
Plug 'vim-airline/vim-airline'                  " git status bar "
Plug 'vim-airline/vim-airline-themes'           " git status bar themes "
let g:airline#extensions#tabline#enabled = 1    " Automatically displays all buffers when there's only one tab open. "
let g:airline_powerline_fonts = 1
let g:airline_theme='dracula'

"
" vim-gutter
"
Plug 'airblade/vim-gitgutter'                   " git diff next to ruler "
set updatetime=250                              " refresh rate for diff makers "

"
" vim-indent-guides
"
Plug 'nathanaelkane/vim-indent-guides'          " indent lines "
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_auto_colors = 0
let g:indent_guides_guide_size = 1
hi IndentGuidesOdd  ctermbg=black
hi IndentGuidesEven ctermbg=black

"
" prettier
"
Plug 'prettier/vim-prettier',{ 'do': 'npm install' }" Makes code pretty "
let g:prettier#autoformat = 0
" autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue PrettierAsync "Auto prettier when saving

"
" semantic-highlight
" every variable in different color
"
Plug 'jaxbot/semantic-highlight.vim'
Plug 'roman/golden-ratio'

call plug#end()

colorscheme dracula

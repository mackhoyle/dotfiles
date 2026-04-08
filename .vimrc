call plug#begin('~/.vim/plugged')

  Plug 'airblade/vim-gitgutter'
  Plug 'arcticicestudio/nord-vim'
  Plug 'ctrlpvim/ctrlp.vim'
  Plug 'dracula/vim', { 'as': 'dracula' }
  Plug 'easymotion/vim-easymotion'
  Plug 'flazz/vim-colorschemes'
  Plug 'ghifarit53/tokyonight-vim'
  Plug 'godlygeek/tabular'
  Plug 'herrbischoff/cobalt2.vim'
  Plug 'https://github.com/bkad/CamelCaseMotion'
  Plug 'https://github.com/kristijanhusak/vim-dadbod-ui'
  Plug 'https://github.com/morhetz/gruvbox'
  Plug 'https://github.com/sainnhe/gruvbox-material'
  Plug 'https://github.com/tpope/vim-dadbod'
  Plug 'https://github.com/yegappan/mru'
  Plug 'joshdick/onedark.vim'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'kaicataldo/material.vim', { 'branch': 'main' }
  Plug 'luochen1990/rainbow'
  Plug 'ntpeters/vim-better-whitespace'
  Plug 'preservim/nerdtree'
  Plug 'psliwka/vim-smoothie'
  Plug 'ryanoasis/vim-devicons'
  Plug 'scrooloose/nerdcommenter'
  Plug 'scrooloose/syntastic'
  Plug 'severin-lemaignan/vim-minimap'
  Plug 'tpope/vim-fugitive'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'vim-scripts/dbext.vim'
  Plug 'voldikss/vim-floaterm'
  Plug 'thaerkh/vim-indentguides'
  Plug 'ghifarit53/tokyonight-vim'
  Plug 'embark-theme/vim', { 'as': 'embark', 'branch': 'main' }
  Plug 'mkarmona/materialbox'
  Plug 'sainnhe/everforest'
  Plug 'mbbill/undotree'
  Plug 'christoomey/vim-tmux-navigator'
  Plug 'tribela/vim-transparent'



" Initialize plugin system
call plug#end()

runtime defaults.vim

let generofiles=expand($FGLDIR . "/vimfiles")
if isdirectory(generofiles)
   let &rtp=generofiles.','.&rtp
endif

" SET VIM CONFIG PARAMETERS
set tabstop=8 softtabstop=2 expandtab shiftwidth=2 smarttab autoindent "set tab properties
set nocompatible "use vim improvements
set mouse-=a "set mouse off
"set number  "set line numbers on
set ruler "show the cursor position
set bs=2 "set backspace
set hlsearch "highlight all search patterns
set ic "ingore case in searches
set wildignore=*.42? "ignore .42? files when opening vim (tab complete filename)
set omnifunc=syntaxcomplete#Complete "set syntax autocompletion
set encoding=utf-8
set number
set relativenumber
set nrformats+=alpha

set list
set listchars=tab:»\ ,extends:›,precedes:‹,nbsp:·,trail:·
set updatetime=100

"autocmd ColorScheme * highlight ExtraWhitespace ctermbg=lightblue guibg=lightblue
"" Show trailing whitespace:
"au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
"au InsertLeave * match ExtraWhitespace /\s\+$/
"

let g:camelcasemotion_key = '<leader>'
set background=dark

filetype indent on "turn on filetype detection, turn on plugins, turn on indent settings
syntax on "turn on syntax highlighting

" TURN ON SYNTAX HIGLIGHING FOR THE FOLLOWING EXTENSIONS
au BufNewFile,BufRead *.4gl setlocal filetype=fgl
au BufNewFile,BufRead *.all setlocal filetype=fgl
au BufNewFile,BufRead *.err setlocal filetype=fgl
au BufNewFile,BufRead *.inc setlocal filetype=fgl
au BufNewFile,BufRead *.per setlocal filetype=per
au BufNewFile,BufRead *.4ad set filetype=xml
au BufNewFile,BufRead *.4st set filetype=xml
au BufNewFile,BufRead *.4tb set filetype=xml
au BufNewFile,BufRead *.4tm set filetype=xml
au BufNewFile,BufRead *.xcf set filetype=xml
au BufNewFile,BufRead *.handlebars set filetype=html



"FUNCTION
" used to remove all trailing whitespace and convert tabs to spaces based on
" your tabstop
:command WHITE %s/\s\+$// | retab
"END FUNCTION

"FUNCTION
"Configure <f2> to go into/out of paste mode for pasting windows buffer
"without auto indent messing up lines
nnoremap <F2> :set invpaste paste?<CR>

"Map make commands
nnoremap gb :MRU<CR>
nnoremap gp :CtrlP<CR>
nnoremap gv :DBUI<CR>
nnoremap mf :!cd $VDXDIR && make fast<CR>
nnoremap mm :!cd $VDXDIR && make<CR>
nnoremap mc :!cd $VDXDIR && make clean all<CR>
nnoremap gn :NERDTreeToggle<CR>
nnoremap tt :IndentGuidesToggle<CR>
nnoremap gu :UndotreeToggle<CR>
nnoremap gs :let @/ = expand('<cword>') \| execute 'grep! -Ir --exclude-dir=.git --exclude-dir=.svn --include=*.4gl --include=*.per ' . shellescape(@/) . ' .' \| copen<CR>
nnoremap gs :let @/ = expand('<cword>') \| silent! execute 'grep! -Ir --exclude-dir=.git --exclude-dir=.svn --include=*.4gl --include=*.per ' . shellescape(@/) . ' .' \| copen \| cc<CR>

noremap <space> :

nnoremap <silent> ,t   :FloatermToggle<CR>
tnoremap <silent> ,t   <C-\><C-n>:FloatermToggle<CR>

vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>
vnoremap <C-e> "hy:.,$s/<C-r>h//gc<left><left><left>

"Move around omni completion with j and k
inoremap <expr> j ((pumvisible())?("\<C-n>"):("j"))
inoremap <expr> k ((pumvisible())?("\<C-p>"):("k"))

set clipboard=unnamed


"set Airline theme variables for theme
let mapleader = ","

" Airline settings
let g:airline_powerline_fonts = 1
let g:airline_theme = 'gruvbox'
" Tell Vim to show a tabline always (top line)
set showtabline=2
" Let airline use the tabline as the statusline
let g:airline#extensions#tabline#enabled = 1

let g:indent_guides_guide_size=1

let g:gitgutter_sign_added = '│'
let g:gitgutter_sign_modified = '│'
let g:gitgutter_sign_removed = '_'
let g:gitgutter_sign_removed_first_line = '‾'
let g:gitgutter_sign_modified_removed = '~'




let g:dbs = {
\  'dev' : 'postgres://postgres:vtm001@pgsdb12-2:5438/usrecdev',
\  'qa'  : 'postgres://postgres:vtm001@pgsdb12-2:5438/usrec81qa'
\ }

let g:db_ui_use_nerd_fonts=1

set background=dark

colorscheme everforest

let g:rainbow_active = 1

" Create default mappings
let g:NERDCreateDefaultMappings = 1
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
let g:tmux_navigator_no_mappings = 1

nnoremap <silent> {Left-Mapping} :<C-U>TmuxNavigateLeft<cr>
nnoremap <silent> {Down-Mapping} :<C-U>TmuxNavigateDown<cr>
nnoremap <silent> {Up-Mapping} :<C-U>TmuxNavigateUp<cr>
nnoremap <silent> {Right-Mapping} :<C-U>TmuxNavigateRight<cr>
nnoremap <silent> {Previous-Mapping} :<C-U>TmuxNavigatePrevious<cr>

"


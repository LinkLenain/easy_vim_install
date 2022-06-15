" ======== VUNDLE CONFIG ============
set nocompatible              " be iMproved, required
filetype off                  " required

let g:ale_disable_lsp = 1

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
"Plugin 'gmarik/Vundle.vim'
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" plugin Syntastic
Plugin 'scrooloose/syntastic'
"DoxygenTool
Plugin 'DoxygenToolkit.vim'

"To be activated to try clang-format
""Vim operator
Plugin 'kana/vim-operator-user'
""Clang format
Plugin 'rhysd/vim-clang-format'

" Plugin to get type coloration + clang format integration for C/C++
Plugin 'w0rp/ale'
Plugin 'jackguo380/vim-lsp-cxx-highlight'
Plugin 'neoclide/coc.nvim', {'branch': 'release'}

"Indent for python file
Plugin 'Vimjas/vim-python-pep8-indent'
"Dockerfiler coloration
Plugin 'ekalinin/dockerfile.vim'
" Jsonnet coloration
Plugin 'google/vim-jsonnet'
" Helm coloration
Plugin 'towolf/vim-helm'
" Terraform coloration
Plugin 'hashivim/vim-terraform'
" Groovy coloration
Plugin 'groovy.vim'
" JenkinsFile coloration
Plugin 'thanethomson/vim-jenkinsfile'
" All of your Plugins must be added before the following line

call vundle#end()            " required
"filetype plugin indent on    " required


"
" ========= GLOBAL ============
if &diff
   colorscheme monokai
   "Ignore whitespace during vimdiff
   set diffopt+=iwhite
   setlocal nospell
else
   highlight SpellBad ctermbg=Yellow
endif

set nohlsearch

"Deactivate bracketed paste mode in vi
set t_BE=
set t_fd=
set t_fe=

"enable syntax color
syntax enable

let maplocalleader = "\\"

"Show line number on the left side
set number

"Highlight tab in current file
highlight TabLine ctermbg=Blue
match TabLine /\t/

" group of command to improve the display of numbers, the display of errors
" and tabs on the screen
augroup displayAfterInsert
   autocmd InsertEnter * :set norelativenumber
   " highlight in "Error" style white caracters at the end of lines
   autocmd InsertLeave * match Error /\s\+$/
   autocmd InsertLeave * match TabLine /\t/
   autocmd InsertLeave * :set relativenumber
augroup END

" highlight the delimiter which matches the one under the cursor
set showmatch

"Command to display constantly the current filename
set statusline=%f%m%r%h%w\ [Line=%04l/%04.8L]\ [%p%%]
set statusline +=%{fugitive#statusline()}

"Customize status line. Use a Blue background for the focused window
hi StatusLine ctermfg=white     ctermbg=DarkBlue     cterm=bold

" use space instead of tab
setlocal expandtab
" Configuring how many space we want
setlocal shiftwidth=2
setlocal softtabstop=2
"
"Prefer split below with :split
setlocal splitbelow
""Prefer split on the right with :vsplit
setlocal splitright

" ========= Syntastic =========
if &diff
   "Deactivate syntastic during a vimdiff
   let g:syntastic_mode_map = { 'mode': 'passive',}
else
    let g:syntastic_aggregate_errors = 1
    let g:syntastic_always_populate_loc_list = 1
    let g:syntastic_auto_loc_list = 1
    let g:syntastic_check_on_open = 0
    let g:syntastic_check_on_wq = 0

    let g:syntastic_c_checkers=['cppcheck', 'cland_tidy', 'clang_check']
    let g:syntastic_cpp_checkers=['cppcheck', 'cland_tidy', 'clang_check']
    let g:syntastic_c_remove_include_errors = 1

    " let clang_check use the compilation database
    let g:syntastic_c_clang_check_post_args = ""
    let g:syntastic_cpp_clang_check_post_args = ""
    let g:syntastic_c_clang_tidy_post_args = ""
    let g:syntastic_cpp_clang_tidy_post_args = ""

    let g:syntastic_python_checkers=['pylint']
    let g:syntastic_python_pylint_exec = '~/.local/bin/pylint'
    let g:syntastic_python_python_exec = '/usr/bin/python3'

endif



" ======== ALE syntax coloration =====
let g:coc_disable_startup_warning = 1

let g:ale_cpp_cppcheck_executable = "/home/clacroix/bin_perso/cppcheckwrapper"
let g:ale_c_cppcheck_executable = "/home/clacroix/bin_perso/cppcheckwrapper"
let g:ale_open_list = 1
let g:ale_cpp_cppcheck_options = '--enable=style --library=googletest --library=boost --library=std --library=gnu --library=zlib --platform=unix64 --inline-suppr'
let g:ale_c_cppcheck_options = '--enable=style --library=googletest --library=boost --library=std --library=gnu --library=zlib --platform=unix64 --inline-suppr'
let g:ale_hover_cursor = 0
let g:ale_echo_cursor = 0
let g:ale_hover_to_preview = 0
let g:ale_use_global_executables = 1
"" Use quickfix window to display errors
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1

augroup CloseLoclistWindowGroup
   autocmd!
   autocmd QuitPre * if empty(&buftype) | lclose | endif
augroup END


" ========= REMAPPING =========
"Mapping scroll on ctrl q
nnoremap <c-q>  <c-y>
"Beginning of the interesting config

" use jk keystroke to emluate escape keystroke during insert mode
inoremap jk <esc>
"
" CAUTION, ONLY FOR EXPERIMENTED VIM USERS (SOME OF DEVS BECAME CRAZY)
vnoremap   <Up>     <nop>
vnoremap   <Down>   <nop>
vnoremap   <Left>   <nop>
vnoremap   <Right>  <nop>
inoremap   <Up>     <nop>
inoremap   <Down>   <nop>
inoremap   <Left>   <nop>
inoremap   <Right>  <nop>
inoremap   <esc>    <nop>
nnoremap   <Up>     <nop>
nnoremap   <Down>   <nop>
nnoremap   <Left>   <nop>
nnoremap   <Right>  <nop>

"Creating shortcut to move easily from another windows
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
"Mapping for merge tools
nnoremap ,2 "<ESC>:diffg LO<ENTER><ESC>:diffu<ENTER><ESC>"
nnoremap ,3 "<ESC>:diffg BA<ENTER><ESC>:diffu<ENTER><ESC>"
nnoremap ,4 "<ESC>:diffg RE<ENTER><ESC>:diffu<ENTER><ESC>"

"Clang configuration
let g:clang_format#style_options = {
         \ "BasedOnStyle": "Google",
         \ "AlignConsecutiveAssignments": "true",
         \ "AlignConsecutiveDeclarations": "true",
         \ "BinPackArguments": "false",
         \ "BinPackParameters": "false",
         \ "ColumnLimit": 120,
         \ "DerivePointerAlignment": "false",
         \ "PointerAlignment": "Right",
         \ "Standard": "Cpp03" }

" map to <Leader>cf in C++ code
autocmd FileType c,cpp,objc nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
autocmd FileType c,cpp,objc vnoremap <buffer><Leader>cf :ClangFormat<CR>
"
" if you install vim-operator-user
"autocmd FileType c,cpp,objc map <buffer><Leader>x <Plug>(operator-clang-format)
" Toggle auto formatting:
nnoremap <Leader>f :SyntasticToggleMode<CR>
nnoremap <Leader>sp :SyntasticCheck<CR>

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)


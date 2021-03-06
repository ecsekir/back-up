"
"  Date:         Sunday, 2015.03.08 
"  Revision:     1.0
"  Author:       stefano basile
"  File:         .vimrc
"
"
"  wget  https://github.com/basilest/back-up/raw/master/.vimrc
"
"
"
"
set t_Co=256
" <VUNDLE> I added .vimrc modification to use vundle 
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" First point on GitHub to Vundle itself (so it can be autoapdated
" from vi)
Plugin 'gmarik/vundle'
"
"  To ident code with |
"<INDENT LINE>
"              Plugin 'Yggdroot/indentLine'
"              let g:indentLine_color_term = 239
"              let g:indentLine_color_gui = '#09AA08'
"              let g:indentLine_char = '│'
"              let g:indentLine_fileTypeExclude = ['text', 'sh']
"              :set list lcs=tab:\|\ 
"</INDENT LINE>
"
"<NERDTREE>
Plugin 'scrooloose/nerdtree.git'
"</NERDTREE>
"<AIRLINE>
Plugin 'vim-airline/vim-airline'
set laststatus=2
set ttimeoutlen=50        "fast transition from Insert mode to Normal

"Plugin 'vim-airline/vim-airline-themes'  "temes fo airtime 
"</AIRLINE>
"<CTRLP>
Plugin 'ctrlp.vim'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
let g:ctrlp_max_height=70
"</CTRLP>
"<LIGHTLINE>
"                  Plugin 'itchyny/lightline.vim'
"                  set laststatus=2
"                  let g:lightline = {
"                        \ 'colorscheme': 'wombat',
"                        \}
"if !has('gui_running')
"      set t_Co=256
"endif

"</LIGHTLINE>
"<PYTHON-MODE>   plugin for Python
" Python-Mode ---------------------- {{{
"                    Plugin 'klen/python-mode'
"                    " Keys:
"                    " K             Show python docs
"                    " <Ctrl-Space>  Rope autocomplete
"                    " <Ctrl-c>g     Rope goto definition
"                    " <Ctrl-c>d     Rope show documentation
"                    " <Ctrl-c>f     Rope find occurrences
"                    " <Leader>b     Set, unset breakpoint (g:pymode_breakpoint enabled)
"                    " <Leader>r     run
"                    " [[            Jump on previous class or function (normal, visual, operator modes)
"                    " ]]            Jump on next class or function (normal, visual, operator modes)
"                    " [M            Jump on previous class or method (normal, visual, operator modes)
"                    " ]M            Jump on next class or method (normal, visual, operator modes)
"                    let g:pymode_rope = 1
"                   "let g:pymode_rope_complete_on_dot = 0 when working with YouCompleteMe plugin
"                   "let g:pymode_rope_completion = 0  to cancel the pymode completion totally.
"                    let g:pymode_rope_complete_on_dot = 0
"                   
"                    " Documentation
"                    let g:pymode_doc = 1
"                    let g:pymode_doc_key = 'K'
"                   
"                    "Linting
"                    let g:pymode_lint = 1
"                    let g:pymode_lint_checker = "pyflakes,pep8"
"                    " Auto check on save
"                    let g:pymode_lint_write = 1
"                   
"                    " Support virtualenv
"                    let g:pymode_virtualenv = 1
"                   
"                    " Enable breakpoints plugin
"                    let g:pymode_breakpoint = 1
"                    let g:pymode_breakpoint_bind = '<leader>b'
"                   
"                    " syntax highlighting
"                    let g:pymode_syntax = 1
"                    let g:pymode_syntax_all = 1
"                    let g:pymode_syntax_indent_errors = g:pymode_syntax_all
"                    let g:pymode_syntax_space_errors = g:pymode_syntax_all
"                   
"                    " Don't autofold code
"                    let g:pymode_folding = 0

"</PYTHON-MODE>
" }}}
"<FUGITIVE>   plugin for Git
Plugin 'tpope/vim-fugitive'
"</FUGITIVE>
"
" A plugin can be installed referencing with its name
" Plugin 'Buffergator'
"
"
"      ----------------  HERE COMMON COMMANDs TO USE VINDLE:
"
"      :PluginInstall        to install a new plugin written above
"      :bdelete              to close the splitted winow inside vi
"
"      :PluginUpdate         to update installed plugin
"      :PluginInstall!                idem
"      
"      :Plugins              to search for plugins on vim site
"      :PluginSearch!
"
"      :PluginList           to listed my installed plugins
"      :PluginSearch!
"
"      :PluginClean          Remove filesystem dir remained of installed
"                            plugins, if they are not listed here anymore.
"                            So, to rm a plugin remove its line where above
"                            and call :PluginClean
"
" </VUNDLE> 
" <COLOR SCEHEME>
" use Wombat - Dark gray
" put related .vim in ~/.vim/colors and type :colo wombat
":color wombat
" </COLOR SCEHEME>
"
" <SETTINGS FOR C/C++>
"Plugin 'Valloric/YouCompleteMe'
"             let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py"
"             augroup project
"                   autocmd!
"                   autocmd BufRead,BufNewFile *.h,*.c set filetype=c.doxygen
"             augroup END
"             call vundle#end()
"             filetype plugin indent on
"</SETTINGS FOR C/C++>
"
"
" Vimscript MY FUNCTIONS ---------------------- {{{
"---- My_Date_1 --- returns today date using external  bash 'date'
function! My_Date_1()
    let date = system ("date +'%A %F'")
    "let date = get(list, 0, 'default')
    "silent! execute:("!date|sed  -e 's/\([^,]*\),.*/\1/") 
    echom date
    :exe ":normal A" . " " . date 
    "ap
endfunction
"---- My_Date --- returns today date using internal vim 'strtime'
function! My_Date()
    let date = strftime("%A %F")
    :exe ":normal A" . " " . date
endfunction
function! My_Menu_Item(num_item)
    echom a:num_item
    let cmd = "perl -n -e'/^\s*(\d+)[-\s\.]*(.*)/ && ($1==" . a:num_item . ") && print \"$2\"' list.txt"
    echom cmd
    let menu_item = system (cmd)
    echom menu_item

endfunction
function! My_DocPerl(word)
    let user = system ("tr -d '\n' <<< \"${USER}\"")
    let time = system ("date +\"%s\" | tr -d '\n'")
    let tmp_file = "/tmp/" . user . time
    let clean_path = substitute(a:word, "^qw(", "", "")   "nb. no nedd to remove spaces as cWORD does not return any
    let clean_path = substitute(clean_path, "[(;)]", "", "g")
    let cmd = "perl ~/bin/docpl.pl " . clean_path . "> ". tmp_file
    "echom cmd
    let a = system (cmd)
    :exe "split " . tmp_file
endfunction
function! My_Jump_to_file(word)    
    let clean_path = substitute(a:word, "^qw(", "", "")   "nb. no nedd to remove spaces as cWORD does not return any
    let clean_path = substitute(clean_path, "[(;)]", "", "g")
    let cmd = "perl -I ~/bin -MpathConversion -e 'pathConversion::main(\"" . clean_path . "\")'"
    echom cmd
    let file_path = system (cmd)
    :exe "split " . file_path
endfunction

" }}}
" Vimscript MY file settings MAIN ---------------------- {{{
set mouse=a
set nu
"set relativenumber
set hlsearch
set incsearch
set showcmd
set ic

set tabstop=4
set shiftwidth=4
set expandtab
set autoindent 
filetype plugin indent on
filetype on

    
"set colorcolumn=80
"highlight ColorColumn ctermbg=darkgray

:let mapleader=","
:nnoremap <leader>ev :split $MYVIMRC<cr>
:nnoremap <leader>sv :source $MYVIMRC<cr>
:nnoremap <leader>a  ea'<esc>hbi'<esc>
":nnoremap <leader>d  :exe ":normal A" . strftime("%A %F")<cr>
:nnoremap <leader>d   :call My_DocPerl(expand("<cWORD>"))<cr>
:nnoremap <leader>f   :call My_Jump_to_file(expand("<cWORD>"))<cr>
":nnoremap <leader>d  :call My_Date()<cr>
:nnoremap <leader>m  :call My_Menu_Item(2)<cr>

:nnoremap <leader>F  :CtrlP .<cr>
:nnoremap <leader>g :set operatorfunc=<SID>GrepOperator<cr>g@
:vnoremap <leader>g :<c-u>call <SID>GrepOperator(visualmode())<cr>
function! s:GrepOperator(type)
    let saved_unnamed_register = @@

    if a:type ==# 'v'
        normal! `<v`>y
    elseif a:type ==# 'char'
        normal! `[v`]y
    else
        return
    endif

    "silent execute "grep! -R " . shellescape(@@) . " ."
    echo  "grep! -R " . shellescape(@@) . " ."
    copen

    let @@ = saved_unnamed_register
endfunction
" }}}

" Vimscript MY file settings AUGROUP TYPE-VIM  ---------------------- {{{
:augroup filetype_vim
:        autocmd!
:        autocmd FileType vim setlocal foldmethod=marker
:augroup END
" }}}

" <SYNTAX> Here setting for syntax stuff 
"syntax=on
"
"
" </SYNTAX> 
":set tags=./tags;~/legislative2015/
let g:tex_conceal = ""

color desert


"                set gcr=a:block
"                
"                " mode aware cursors
"                set gcr+=o:hor50-Cursor
"                set gcr+=n:Cursor
"                set gcr+=i-ci-sm:InsertCursor
"                set gcr+=r-cr:ReplaceCursor-hor20
"                set gcr+=c:CommandCursor
"                set gcr+=v-ve:VisualCursor
"                
"                set gcr+=a:blinkon0
"                
"                hi InsertCursor  ctermfg=15 guifg=#fdf6e3 ctermbg=37  guibg=#2aa198
"                hi VisualCursor  ctermfg=15 guifg=#fdf6e3 ctermbg=125 guibg=#d33682
"                hi ReplaceCursor ctermfg=15 guifg=#fdf6e3 ctermbg=65  guibg=#dc322f
"                hi CommandCursor ctermfg=15 guifg=#fdf6e3 ctermbg=166 guibg=#cb4b16

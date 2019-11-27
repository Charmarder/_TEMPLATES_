source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

"=====================================================
" Vundle Plugin Manager settings
"=====================================================
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
let $myvimdir = ($OS =~ "Windows") ? $VIM."/vimfiles" : '~/.vim'
set rtp+=$myvimdir/bundle/Vundle.vim
call vundle#begin('$myvimdir/bundle')           " pass a path where Vundle should install plugins

Plugin 'VundleVim/Vundle.vim'                   " let Vundle manage Vundle, required
"---------=== Code/project navigation ===-------------
Plugin 'taglist.vim'                            " Source code browser (supports C/C++, java, perl, python, tcl, sql, php, etc)
"Plugin 'majutsushi/tagbar'                      " Class/module browser
Plugin 'scrooloose/nerdtree'                    " A tree explorer plugin for vim
Plugin 'Shougo/unite.vim'                       " Navigation between buffers and files

"------------------=== Other ===----------------------
Plugin 'sessionman.vim'                         " Vim session manager
Plugin 'tpope/vim-fugitive'                     " A Git wrapper so awesome, it should be illegal
Plugin 'vim-airline/vim-airline'                " Lean & mean status/tabline for vim that's light as air
Plugin 'vim-airline/vim-airline-themes'         " Themes for vim-airline
Plugin 'rosenfeld/conque-term'                  " Consoles as buffers
Plugin 'tpope/vim-surround'                     " Parentheses, brackets, quotes, XML tags, and more

"--------------=== Snippets support ===---------------
Plugin 'garbas/vim-snipmate'                    " Snippets manager
Plugin 'MarcWeber/vim-addon-mw-utils'           " Dependencies #1
Plugin 'tomtom/tlib_vim'                        " Dependencies #2
Plugin 'honza/vim-snippets'                     " Snippets repo

"---------------=== Languages support ===-------------
Plugin 'scrooloose/syntastic'                   " Automatic syntax checking
Plugin 'tpope/vim-commentary'                   " Comment stuff out
Plugin 'mitsuhiko/vim-sparkup'                  " Sparkup (XML/jinja/htlm-django/etc.) support

" --- CSS ---
Plugin 'JulesWang/css.vim'                      " CSS syntax file
Plugin 'groenewege/vim-less'                    " Vim syntax for LESS (dynamic CSS)

" --- JavaScript ---
Plugin 'pangloss/vim-javascript'                " Vastly improved Javascript indentation and syntax support in Vim

" --- HTML ---
Plugin 'othree/html5.vim'                       " HTML5 omnicomplete and sytnax
Plugin 'idanarye/breeze.vim'                    " Html navigation like vim-easymotion, tag matching, tag highlighting and DOM navigation

" --- Perl ---
Plugin 'WolfgangMehner/perl-support'            "Perl IDE -- Insert code snippets, run and profile the code and look up help

" --- Python ---
Plugin 'klen/python-mode'                       " Vim python-mode. PyLint, Rope, Pydoc, breakpoints from box
Plugin 'davidhalter/jedi-vim'                   " Awesome Python autocompletion with VIM
Plugin 'mitsuhiko/vim-jinja'                    " Jinja support for vim
Plugin 'mitsuhiko/vim-python-combined'          " Combined Python 2/3 for Vim
Plugin 'hynek/vim-python-pep8-indent'           " PEP8 indent
Plugin 'jmcantrell/vim-virtualenv'              " Virtualenv support in VIM

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

"=====================================================
" General settings
"=====================================================
autocmd GUIEnter * simalt ~X        " Maximize the Vim window on startup
set langmenu=none
"lan en

syntax on               " Enable Syntax Colors
colorscheme desert
set gfn=Courier_New:h12:cRUSSIAN
set guioptions=egmrLtT
" set guioptions=egmrLt

set visualbell t_vb=    " turn off error beep/flash
set cursorline
set number              " show line numbers
set showcmd             " Show (partial) currently executed command in the last line of the screen
set laststatus=2        " always show statusline

set winminheight=0      " Minimal windows height
set winminwidth=0       " Minimal windows width
set wrap                " Switch on line wrap
set linebreak           " Wrap lines by words, not letters
set nowrapscan          " Stop searching when end of file is reached
set ignorecase          " Ignore case letters when searching

" Turn on the mouse even in text mode.
" Very convenient when copying from the terminal, because without this option tabs are laid out in a bunch of spaces).
set mouse=a

" Tab, Shift, Indent Settings
set tabstop=4           " Number of spaces for <Tab>
set expandtab           " replace tabs with spaces
set shiftwidth=4        " Shift size when pressing the << and >> keys
set autoindent          " Copy indent from previous line
set smartindent         " Do smart autoindenting when starting a new line.

" Folding method
"set foldmethod=manual
"set foldmethod=marker
set foldmethod=syntax
set formatoptions+=mM
set formatoptions-=r

" File settings
set enc=utf-8                                 " utf-8 default encoding
set ffs=unix,dos                              " file end-of-line (<EOL>) formats
set nobomb                                    " writing file with BOM (Byte Order Mark)
set fileencodings=utf-8,cp1251,koi8-r,cp866   " List of file encodings for auto detection
set nobackup                                  " Turn off the creation of backups
set noswapfile                                " Turn off the creation of swap files
set noundofile                                " Turn off the creation of undo history
"set backupdir=$myvimdir/backup/,/tmp//        " Location all backup files
"set directory=$myvimdir/swp/,/tmp//           " Location all swap files
"set undodir=$myvimdir/undo/,/tmp//            " Location all undo history files

" Common abbreviations
iabbrev Br      Best regards,
iabbrev Btw     By the way

" Show additional info in status line
"set statusline=%F%m%r%h%w\ [TYPE:%Y\ %{&ff}\ %{&fenc}%{(&bomb?\"-BOM\":\"\")}]\ [SESSION:%{MySessionName()}]\ %=\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04v,%04l][%p%%]\ [LEN=%L]

set sessionoptions=curdir,folds,tabpages,unix
set tags=./tags

function! MySessionName()
return substitute(v:this_session, '\(.*\)\\\(.*\)$', '\2', '')
endfunction

"function! RestoreSession()
"  if argc() == 0 "vim called without arguments
"    execute 'SessionOpenLast'
"  end
"endfunction
"autocmd VimEnter * call RestoreSession()

" save and restore global variables that start with an uppercase letter, and don't contain a lowercase letter
set viminfo+=!

if ($OS =~ "Windows")
    " paj using PSCP on Windows. Works best with Pageant.
    let g:netrw_cygwin = 0
    let g:netrw_scp_cmd='c:\dev\Putty\PSCP.EXE -q -batch'
"    let g:netrw_scp_cmd='c:\"Documents and Settings"\ianchuvi\"My Documents"\APPS\Putty\PSCP.EXE -pw 08MakUBS22 -q -batch'
    let g:netrw_sftp_cmd= 'c:\dev\Putty\PSFTP.EXE'
    let g:netrw_silent = 1  "This will run scp asynchronously (like using !start)

    " Name of the viminfo file
    set viminfo+=n$VIM/_viminfo
endif


"=====================================================
" Set own functions for Tab Labels and Tab Tooltips
"=====================================================
"set showtabline=2 " always show tabs in gvim, but not vim

" set up tab labels with tab number, buffer name, number of windows
function! GuiTabLabel()
  let label = ''
  let bufnrlist = tabpagebuflist(v:lnum)
  " Add '[+]' if one of the buffers in the tab page is modified
  for bufnr in bufnrlist
    if getbufvar(bufnr, "&modified")
      let label = '[+] '
      break
    endif
  endfor
  " Append the tab number
  let label .= v:lnum.': '
  " Append the buffer name
  let name = bufname(bufnrlist[tabpagewinnr(v:lnum) - 1])
  if name == ''
    " give a name to no-name documents
    if &buftype=='quickfix'
      let name = '[Quickfix List]'
    else
      let name = '[No Name]'
    endif
  else
    if  &buftype=='help'
      " get only the file name
      let name = fnamemodify(name,":t") . ' [help]'
    else
      let name = pathshorten(name)
    endif
  endif
  let label .= name
  " Append the number of windows in the tab page
  let wincount = tabpagewinnr(v:lnum, '$')
  return label . '  [' . wincount . ']'
endfunction

set guitablabel=%{GuiTabLabel()}
set tabline=%m\ %N:\ %t%X
"set guitablabel=%m\ %N:\ %t

" set up tab tooltips with every buffer name
function! GuiTabToolTip()
  let tip = ''
  let bufnrlist = tabpagebuflist(v:lnum)
  for bufnr in bufnrlist
    " separate buffer entries
    if tip!=''
      let tip .= " \n "
    endif
    " Add name of buffer
    let name=bufname(bufnr)
    if name == ''
      " give a name to no name documents
      if getbufvar(bufnr,'&buftype')=='quickfix'
        let name = '[Quickfix List]'
      else
        let name = '[No Name]'
      endif
    endif
    let tip.=name
    " add modified/modifiable flags
    if getbufvar(bufnr, "&modified")
      let tip .= ' [+]'
    endif
    if getbufvar(bufnr, "&modifiable")==0
      let tip .= ' [-]'
    endif
  endfor
  return tip
endfunction

set guitabtooltip=%{GuiTabToolTip()}


"=====================================================
" Own Menus
"=====================================================
" Menu Spell Checker -->
  if version >= 700
    " By default spell checker is turn off
    set spell spelllang=
    set nospell

    menu Spell.off :setlocal spell spelllang= :setlocal nospell
    menu Spell.Russian+English :setlocal spell spelllang=ru,en
    menu Spell.Russian :setlocal spell spelllang=ru
    menu Spell.English :setlocal spell spelllang=en
    menu Spell.-SpellControl- :
    menu Spell.Word\ Suggest<Tab>z= z=
    menu Spell.Add\ To\ Dictionary<Tab>zg zg
    menu Spell.Add\ To\ TemporaryDictionary<Tab>zG zG
    menu Spell.Remove\ From\ Dictionary<Tab>zw zw
    menu Spell.Remove\ From\ Temporary\ Dictionary<Tab>zW zW
    menu Spell.Previous\ Wrong\ Word<Tab>[s [s
    menu Spell.Next\ Wrong\ Word<Tab>]s ]s
  endif
" Menu Spell Checker <--

" Menu Encoding -->
  " Encoding in which to read the file -->
  set wildmenu
  set wcm=<Tab>
  menu Encoding.Read.utf-8<Tab><F7> :e ++enc=utf8 <CR>
  menu Encoding.Read.windows-1251<Tab><F7> :e ++enc=cp1251<CR>
  menu Encoding.Read.koi8-r<Tab><F7> :e ++enc=koi8-r<CR>
  menu Encoding.Read.cp866<Tab><F7> :e ++enc=cp866<CR>
  map <F7> :emenu Encoding.Read.<TAB>
  " Encoding in which to read the file <--

  " Encoding in which to save the file -->
  set wildmenu
  set wcm=<Tab>
  menu Encoding.Write.utf-8<Tab><S-F7> :set fenc=utf8 <CR>
  menu Encoding.Write.windows-1251<Tab><S-F7> :set fenc=cp1251<CR>
  menu Encoding.Write.koi8-r<Tab><S-F7> :set fenc=koi8-r<CR>
  menu Encoding.Write.cp866<Tab><S-F7> :set fenc=cp866<CR>
  map <S-F7> :emenu Encoding.Write.<TAB>
  " Encoding in which to save the file <--

  " Line-end format (dos - <CR><NL>, unix - <NL>, mac - <CR>) -->
  set wildmenu
  set wcm=<Tab>
  menu Encoding.End_line_format.unix<Tab><C-F7> :set fileformat=unix<CR>
  menu Encoding.End_line_format.dos<Tab><C-F7> :set fileformat=dos<CR>
  menu Encoding.End_line_format.mac<Tab><C-F7> :set fileformat=mac<CR>
  map <C-F7> :emenu Encoding.End_line_format.<TAB>
  " Line-end format (dos - <CR><NL>, unix - <NL>, mac - <CR>) <--
" Menu Encoding <--


"=====================================================
" Plugins specific settings
"=====================================================
" SnipMate settings
let g:snippets_dir = "$myvimdir/vim-snippets/snippets"

" NERDTree
nmap <F1> <nop>                 " unmap <F1> with help
map <F1> :NERDTreeToggle<CR>    " browse the list of files in the current directory

" Unite settings
nnoremap <F2> :Unite buffer<CR> " browse a list of the currently opened buffers

" ConqueTerm
nnoremap <F5> :ConqueTermSplit ipython<CR> " run python-scripts at <F5>
nnoremap <F6> :exe "ConqueTermSplit ipython " . expand("%")<CR> " and debug-mode for <F6>
let g:ConqueTerm_StartMessages = 0
let g:ConqueTerm_CloseOnEnd = 0

" Jedi-vim
let g:jedi#show_call_signatures = 1 " show call signatures
let g:jedi#popup_on_dot = 1         " enable autocomplete on dot
let g:jedi#popup_select_first = 0   " disable first select from auto-complete

" Syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_enable_signs = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_aggregate_errors = 1
noremap <f7> :w<CR>:SyntasticCheck<CR>

" Better :sign interface symbols
let g:syntastic_error_symbol = 'X'
let g:syntastic_style_error_symbol = 'X'
let g:syntastic_warning_symbol = 'x'
let g:syntastic_style_warning_symbol = 'x'

" Taglist settings
let Tlist_Show_Menu = 1
nnoremap <silent> <F8> :TlistToggle<CR>

" Vim-Airline
let g:airline_theme='powerlineish'

"=====================================================
" Python-mode settings
"=====================================================
" Python-mode
" Activate rope
" Keys:
" K Show python docs
" <Ctrl-Space> Rope autocomplete
" <Ctrl-c>g Rope goto definition
" <Ctrl-c>d Rope show documentation
" <Ctrl-c>f Rope find occurrences
" <Leader>b Set, unset breakpoint (g:pymode_breakpoint enabled)
" [[ Jump on previous class or function (normal, visual, operator modes)
" ]] Jump on next class or function (normal, visual, operator modes)
" [M Jump on previous class or method (normal, visual, operator modes)
" ]M Jump on next class or method (normal, visual, operator modes)
let g:pymode_rope = 0

" Documentation
let g:pymode_doc = 0
let g:pymode_doc_key = 'K'
" Linting
let g:pymode_lint = 1
let g:pymode_lint_checkers = ['pylint', 'pep8']
let g:pymode_lint_cwindow = 1
let g:pymode_lint_ignore="E501,W601,C0110,C0111"
let g:pymode_lint_write = 0

" Support virtualenv
let g:pymode_virtualenv = 1

" Enable breakpoints plugin
let g:pymode_breakpoint = 1
let g:pymode_breakpoint_key = '<leader>b'

" Syntax highlighting
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
let g:pymode_syntax_indent_errors = g:pymode_syntax_all
let g:pymode_syntax_space_errors = g:pymode_syntax_all

" Don't autofold code
let g:pymode_folding = 0

" Get possibility to run Python code
let g:pymode_run = 0

" Other options
let g:pymode_options_colorcolumn = 0
if has("gui_running")
"    let g:airline_powerline_fonts = 1
else
"    let g:airline_powerline_fonts = 0
endif

"=====================================================
" User hotkeys
"=====================================================
" Faster text movement
nmap <C-H> 5h
nmap <C-J> 5j
nmap <C-K> 5k
nmap <C-L> 5l

" Turn on navigation on the wrapped lines
imap <silent> <Down> <C-o>gj
imap <silent> <Up> <C-o>gk
nmap <silent> <Down> gj
nmap <silent> <Up> gk

" After shifting the selected block with the keys < and >, the selection is not removed
vnoremap < <gv
vnoremap > >gv

" Move windows and resize them to hang on a combination with arrows:
" Moving windows
nnoremap <C-Down> <C-W>J
nnoremap <C-Up> <C-W>K
nnoremap <C-Right> <C-W>L
nnoremap <C-Left> <C-W>H
" Resizing windows
nnoremap <A-Down> <C-W>+
nnoremap <A-Up> <C-W>-
nnoremap <A-Left> <C-W><
nnoremap <A-Right> <C-W>>


" Auto-completion options - include only the menu with the available options
" autocompletion (also, for example, for Omni Completion can be preview window).
"set completeopt=menu

" Autocomplete hang on <Tab>
function! Tab_Or_Complete()
  if col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
    return "\<C-N>"
  else
    return "\<Tab>"
  endif
endfunction
inoremap <Tab> <C-R>=Tab_Or_Complete()<CR>
set dictionary="/usr/dict/words"
set complete=.,w,b,u,t


"=====================================================
" Languages support
"=====================================================
" --- C/C++/C# ---
autocmd FileType c setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab
autocmd FileType cpp setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab
autocmd FileType cs setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab
autocmd FileType c setlocal commentstring=/*\ %s\ */
autocmd FileType cpp,cs setlocal commentstring=//\ %s
let c_no_curly_error=1
let g:syntastic_cpp_include_dirs = ['include', '../include']
let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_c_include_dirs = ['include', '../include']
let g:syntastic_c_compiler = 'clang'

" --- CSS ---
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType css setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4
autocmd FileType css setlocal commentstring=/*\ %s\ */

" --- JavaScript ---
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd BufNewFile,BufRead *.json setlocal ft=javascript
autocmd FileType javascript setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType javascript setlocal commentstring=//\ %s
autocmd FileType javascript let b:javascript_fold = 0
let javascript_enable_domhtmlcss=1
let g:syntastic_javascript_checkers = ['jshint']
let g:syntastic_javascript_jshint_args='--config $myvimdir/extern-cfg/jshint.json'

" --- HTML ---
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType html setlocal commentstring=<!--\ %s\ -->
autocmd FileType html setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2

" --- Perl ---
" folding section
let perl_fold = 1
let perl_fold_blocks = 0
let perl_nofold_packages = 0
let html_fold = 1

" --- Python ---
let python_highlight_all=1
let python_highlight_exceptions=0
let python_highlight_builtins=0
let python_slow_sync=1
autocmd FileType python setlocal completeopt-=preview
autocmd FileType python setlocal expandtab shiftwidth=4 tabstop=8
\ formatoptions+=croq softtabstop=4 smartindent
\ cinwords=if,elif,else,for,while,try,except,finally,def,class,with
autocmd FileType pyrex setlocal expandtab shiftwidth=4 tabstop=8 softtabstop=4 smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class,with
let g:syntastic_python_checkers = ['flake8', 'python']
let g:syntastic_python_flake8_args='--ignore=E121,E128,E711,E301,E261,E241,E124,E126,E721
\ --max-line-length=80'

" --- Vim ---
autocmd FileType vim setlocal expandtab shiftwidth=2 tabstop=8 softtabstop=2


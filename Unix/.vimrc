set nocompatible
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction


" Настройки GUI
set langmenu=none
"lan en
" Maximize the Vim window on startup
autocmd GUIEnter * simalt ~X
colorscheme desert
set gfn=Courier_New:h12:cRUSSIAN
set guioptions=egmrLtT
" set guioptions=egmrLt
set cursorline
set number

" Включаем мышку даже в текстовом режиме
" (очень удобно при копировании из терминала, т. к. без этой опции,
" например, символы табуляции раскладываются в кучу пробелов).
set mouse=a

" Включаем подсветку синтаксиса
syntax on

" Минимальная высота окна
set winminheight=0
" Минимальная ширина окна
set winminwidth=0



" Опции автодополнения - включаем только меню с доступными вариантами
" автодополнения (также, например, для omni completion может быть
" окно предварительного просмотра).
"set completeopt=menu

"Автодополнение повесить на <Tab>
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


" Размер табуляции
set tabstop=4
" Размер сдвига при нажатии на клавиши << и >>
set shiftwidth=4
" заменять табы пробелами
set expandtab
" Копирует отступ от предыдущей строки
set autoindent
" Включаем 'умную' автоматическую расстановку отступов
set smartindent

" Всегда отображать statusline
set laststatus=2
" Всегда отображать tabline
set stal=2
" Включаем отображение дополнительной информации в статусной строке
set statusline=%F%m%r%h%w\ [TYPE:%Y\ %{&ff}\ %{&fenc}%{(&bomb?\"-BOM\":\"\")}]\ [SESSION:%{MySessionName()}]\ %=\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04v,%04l][%p%%]\ [LEN=%L]
" set statusline=%<%f%h%m%r%=format=%{&fileformat} file=%{&fileencoding} enc=%{&encoding} %b 0x%B %l,%c%V %P

" Включаем перенос строк
set wrap
" Перенос строк по словам, а не по буквам
set linebreak

" Останавливать поиск при достижении конца файла
set nowrapscan
" Игнорировать регистр букв при поиске
set ignorecase


" Метод фолдинга - вручную (для обычных файлов)
"set foldmethod=manual
"set foldmethod=marker
set foldmethod=syntax
" Perl folding section 
let perl_fold = 1
let perl_fold_blocks = 0
let perl_nofold_packages = 0
let html_fold = 1

set formatoptions+=mM
set formatoptions-=r

" Common abbreviations
iabbrev Br      Best regards,
iabbrev Btw     By the way

" Включаем отображение выполняемой в данный момент команды в правом нижнем углу экрана.
" К примеру, если вы наберете 2d, то в правом нижнем углу экрана Vim отобразит строку 2d.
set showcmd


" Настройки файлов -->
    set enc=utf-8
    set ffs=unix,dos
    set nobomb
    " Список кодировок файлов для автоопределения
    set fileencodings=utf-8,cp1251,koi8-r,cp866

    " Отключаем создание бэкапов
    set nobackup
    " Отключаем создание swap файлов
    set noswapfile
    " Все swap файлы будут помещаться в эту папку
    "set dir=~/.vim/swp
" Настройки файлов <--


" Горячие клавиши -->
    " Ускоренное передвижение по тексту
    nmap <C-H> 5h
    nmap <C-J> 5j
    nmap <C-K> 5k
    nmap <C-L> 5l

    " Включаем навигацию по перенесенным строкам
    imap <silent> <Down> <C-o>gj
    imap <silent> <Up> <C-o>gk
    nmap <silent> <Down> gj
    nmap <silent> <Up> gk

    nnoremap <silent> <F8> :TlistToggle<CR>

	" После сдвига выделенного блока клавишами < и >, выделение не убирать
	vnoremap < <gv
	vnoremap > >gv

	"Перемещение окон и изменение их размера повесить на сочетания со стрелками:
	"Moving windows
	nnoremap <C-Down> <C-W>J
	nnoremap <C-Up> <C-W>K
	nnoremap <C-Right> <C-W>L
	nnoremap <C-Left> <C-W>H
	"Resizing windows (на этих клавишах работает выделение)
	"nnoremap <S-Down> <C-W>+
	"nnoremap <S-Up> <C-W>-
	"nnoremap <S-Left> <C-W><
	"nnoremap <S-Right> <C-W>>
	
	
" Горячие клавиши <--

let Tlist_Show_Menu = 1

set sessionoptions=curdir,folds,tabpages,unix
set tags=./tags

function! MySessionName()
return substitute(v:this_session, '\(.*\)\\\(.*\)$', '\2', '')
endfunction


" Задаем собственные функции для назначения имен заголовкам табов и всплывающих подсказок -->
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
"	set guitablabel=%m\ %N:\ %t


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
" Задаем собственные функции для назначения имен заголовкам табов и всплывающих подсказок <--

" Меню -->
    " Проверка орфографии -->
        if version >= 700
            " По умолчанию проверка орфографии выключена.
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
    " Проверка орфографии <--

    " Меню Encoding -->
        " Выбор кодировки, в которой читать файл -->
            set wildmenu
            set wcm=<Tab>
            menu Encoding.Read.utf-8<Tab><F7> :e ++enc=utf8 <CR>
            menu Encoding.Read.windows-1251<Tab><F7> :e ++enc=cp1251<CR>
            menu Encoding.Read.koi8-r<Tab><F7> :e ++enc=koi8-r<CR>
            menu Encoding.Read.cp866<Tab><F7> :e ++enc=cp866<CR>
            map <F7> :emenu Encoding.Read.<TAB>
        " Выбор кодировки, в которой читать файл <--

        " Выбор кодировки, в которой сохранять файл -->
            set wildmenu
            set wcm=<Tab>
            menu Encoding.Write.utf-8<Tab><S-F7> :set fenc=utf8 <CR>
            menu Encoding.Write.windows-1251<Tab><S-F7> :set fenc=cp1251<CR>
            menu Encoding.Write.koi8-r<Tab><S-F7> :set fenc=koi8-r<CR>
            menu Encoding.Write.cp866<Tab><S-F7> :set fenc=cp866<CR>
            map <S-F7> :emenu Encoding.Write.<TAB>
        " Выбор кодировки, в которой сохранять файл <--

        " Выбор формата концов строк (dos - <CR><NL>, unix - <NL>, mac - <CR>) -->
            set wildmenu
            set wcm=<Tab>
            menu Encoding.End_line_format.unix<Tab><C-F7> :set fileformat=unix<CR>
            menu Encoding.End_line_format.dos<Tab><C-F7> :set fileformat=dos<CR>
            menu Encoding.End_line_format.mac<Tab><C-F7> :set fileformat=mac<CR>
            map <C-F7> :emenu Encoding.End_line_format.<TAB>
        " Выбор формата концов строк (dos - <CR><NL>, unix - <NL>, mac - <CR>) <--
    " Меню Encoding <--
" Меню <--

" save and restore global variables that start with an uppercase letter, and don't contain a lowercase letter
set viminfo+=!

if ($OS =~ "Windows")
    " paj using PSCP on Windows. Works best with Pageant.
	let g:netrw_cygwin = 0
	let g:netrw_scp_cmd='c:\dev\Putty\PSCP.EXE -q -batch'
"	let g:netrw_scp_cmd='c:\"Documents and Settings"\ianchuvi\"My Documents"\APPS\Putty\PSCP.EXE -pw 08MakUBS22 -q -batch'
	let g:netrw_sftp_cmd= 'c:\dev\Putty\PSFTP.EXE'
	let g:netrw_silent = 1	"This will run scp asynchronously (like using !start)

    " Name of the viminfo file
    set viminfo+=n$VIM/_viminfo
endif

"function! RestoreSession()
"  if argc() == 0 "vim called without arguments
"    execute 'SessionOpenLast'
"  end
"endfunction
"autocmd VimEnter * call RestoreSession()


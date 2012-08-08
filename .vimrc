set nocompatible

"let $LANG = 'en'
"set langmenu=none

" Windows options
if has('win32')
	set encoding=cp1251
	set guifont=Courier_New:h10:cRUSSIAN::
	set iskeyword=@,a-z,A-Z,48-57,_,128-175,192-255
"	let &guioptions = substitute(&guioptions, "t", "", "g")
else
	set encoding=utf-8
	set termencoding=utf-8
endif

" Don't use Ex mode, use Q for formatting
map Q gq
inoremap <C-U> <C-G>u<C-U>

" Gvim menu and tabs
if has('gui')
"	set guioptions-=e
"	set guioptions-=t
"	set guioptions-=r
endif

" Gvim font 
if has('gui_running')
	set guifont=Courier\ New\ 10
endif

"augroup myvimrc
"	au!
"	au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc so $MYVIMRC 
"augroup END

" Convenient the difference 
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

" Formatting
if has("autocmd")
  filetype plugin indent on
  augroup vimrcEx
  au!
  autocmd FileType text setlocal textwidth=78
  autocmd BufReadPost *
	\ if line("'\"") > 1 && line("'\"") <= line("$") |
	\   exe "normal! g`\"" |
	\ endif
  augroup END
else
  set autoindent
endif

" Options
let loaded_matchparen = 1
set backspace=indent,eol,start
set backup
set history=150
set ruler
set showcmd
set incsearch
set ignorecase
syntax on
set hlsearch
set tabstop=4
set mousehide
set shiftwidth=4
set number
set backspace=2
set noeb vb t_vb=
set novisualbell
set linebreak
set fileencodings=utf-8,cp1251
set mouse=a
set nocursorline
set nocursorcolumn
syntax sync minlines=256
set wrap
set tw=80
set scrolljump=2
set scrolloff=2
"set showbreak=__
colorscheme slate

hi StatusLine ctermfg=15  guifg=#ffffff ctermbg=236 guibg=#4e4e4e cterm=bold gui=bold
hi StatusLineNC ctermfg=249 guifg=#b2b2b2 ctermbg=232 guibg=gray12 cterm=none gui=none
hi Normal ctermfg=252 guifg=#d0d0d0 ctermbg=0 guibg=#000000 cterm=none gui=none
hi Cursor ctermbg=214 guibg=#ffaf00
hi CursorLine ctermbg=235 guibg=gray11 cterm=none gui=none
hi NonText ctermfg=10  guifg=#00FF00 ctermbg=0 guibg=#000000
hi Visual ctermfg=15  guifg=#ffffff ctermbg=8 guibg=#556b2f cterm=none
hi VisualNOS ctermfg=255 guifg=#eeeeee ctermbg=60guibg=#5f5f87
hi LineNr ctermfg=130 guifg=#daa520 ctermbg=0 guibg=gray4
hi Comment ctermfg=magenta  guifg=#e036df
hi Search ctermfg=white guifg=#ffffff ctermbg=19 guibg=#4682b4
hi IncSearch ctermfg=white guifg=#ffffff ctermbg=19 guibg=#4684b4 
hi Todo ctermfg=0 guifg=#000000 ctermbg=184 guibg=#dfdf00
hi Underlined ctermfg=39 guifg=#00afff cterm=underline gui=underline
hi VertSplit ctermfg=7 guifg=#ffffff ctermbg=235 guibg=gray25 cterm=none gui=none
hi PreProc guifg=green guibg=black ctermfg=green
hi Error ctermfg=red guifg=red ctermbg=gray guibg=#cccccc gui=bold
hi Pmenu ctermfg=0 guifg=#000000 ctermbg=250 guibg=#bcbcbc
hi PmenuSel ctermfg=255 guifg=#eeeeee ctermbg=243 guibg=#767676
hi PmenuSbar ctermbg=252 guibg=#d0d0d0
hi PmenuThumb ctermfg=243 guifg=#767676
"hi TabLine      ctermfg=fg  guifg=fg      ctermbg=242 guibg=#666666 cterm=none gui=none

" Transparency for UXRVT
if &term =~ "xterm\\|rxvt-256color"
	hi Normal ctermbg=NONE
	hi Cursorline ctermbg=236
	hi NonText ctermbg=NONE 
	hi LineNr ctermbg=NONE 
endif

" переключение на русскую/английскую раскладку Ctrl + F
set laststatus=2
set keymap=russian-jcukenwin
set iminsert=0
set imsearch=0

cmap <silent> <C-F> <C-^>
imap <silent> <C-F> <C-^>X<Esc>:call MyKeyMapHighlight()<CR>a<C-H>
nmap <silent> <C-F> a<C-^><Esc>:call MyKeyMapHighlight()<CR>
vmap <silent> <C-F> <Esc>a<C-^><Esc>:call MyKeyMapHighlight()<CR>gv

function MyKeyMapHighlight()
	if &iminsert == 0
		hi StatusLine ctermfg=15  guifg=#ffffff ctermbg=236 guibg=#4e4e4e cterm=bold gui=bold
	else
		hi StatusLine ctermbg=darkred ctermfg=white guifg=White guibg=#A52A2A
	endif
endfunction
call MyKeyMapHighlight()
au WinEnter * :call MyKeyMapHighlight()

" Cursor mode toggle
if &term =~ "xterm\\|rxvt-256color"
  " use an orange cursor in insert mode
  let &t_SI = "\<Esc>]12;orange\x7"
  " use a white cursor otherwise
  let &t_EI = "\<Esc>]12;white\x7"
  silent !echo -ne "\033]12;white\007"
  " reset cursor when vim exits
  autocmd VimLeave * silent !echo -ne "\033]112\007"
endif

" Encodings menu
set wildmenu 
set wcm=<Tab> 
menu Enc.koi8-r :e ++enc=koi8-r<CR> 
menu Enc.windows-1251 :e ++enc=cp1251<CR> 
menu Enc.ibm-866 :e ++enc=ibm866<CR>
menu Enc.866 :e ++enc=cp866<CR>
menu Enc.utf-8 :e ++enc=utf-8<CR>
map <F8> :emenu Enc.<TAB>

" Movements in normal mode
nmap j gj
nmap <DOWN> gj
nmap k gk
nmap <UP> gk

" Cursosline toggle
nnoremap <F4> :set invcursorline<cr>

" Paste toggle
nnoremap <F3> :set invpaste paste?<cr>
set pastetoggle=<F3>
set showmode

" Mouse toggle
nnoremap <F2> :call ToggleMouse()<CR>
function! ToggleMouse()
  if &mouse == 'a'
	set mouse=
	echo "Mouse usage disabled"
  else
	set mouse=a
	echo "Mouse usage enabled"
  endif
endfunction

function! s:Gm()
  execute 'normal! ^'
  let first_col = virtcol('.')
  execute 'normal! g_'
  let last_col  = virtcol('.')
  execute 'normal! ' . (first_col + last_col) / 2 . '|'
endfunction
nnoremap <silent> gm :call <SID>Gm()<CR>

"For windows
"" Screen size restore
"if has("gui_running")
"  function! ScreenFilename()
"    if has('amiga')
"      return "s:.vimsize"
"    elseif has('win32')
"      return $HOME.'\_vimsize'
"    else
"      return $HOME.'/.vimsize'
"    endif
"  endfunction
"
"  function! ScreenRestore()
"    " Restore window size (columns and lines) and position
"    " from values stored in vimsize file.
"    " Must set font first so columns and lines are based on font size.
"    let f = ScreenFilename()
"    if has("gui_running") && g:screen_size_restore_pos && filereadable(f)
"      let vim_instance = (g:screen_size_by_vim_instance==1?(v:servername):'GVIM')
"      for line in readfile(f)
"        let sizepos = split(line)
"        if len(sizepos) == 5 && sizepos[0] == vim_instance
"          silent! execute "set columns=".sizepos[1]." lines=".sizepos[2]
"          silent! execute "winpos ".sizepos[3]." ".sizepos[4]
"          return
"        endif
"      endfor
"    endif
"  endfunction
"
"  function! ScreenSave()
"    " Save window size and position.
"    if has("gui_running") && g:screen_size_restore_pos
"      let vim_instance = (g:screen_size_by_vim_instance==1?(v:servername):'GVIM')
"      let data = vim_instance . ' ' . &columns . ' ' . &lines . ' ' .
"            \ (getwinposx()<0?0:getwinposx()) . ' ' .
"            \ (getwinposy()<0?0:getwinposy())
"      let f = ScreenFilename()
"      if filereadable(f)
"        let lines = readfile(f)
"        call filter(lines, "v:val !~ '^" . vim_instance . "\\>'")
"        call add(lines, data)
"      else
"        let lines = [data]
"      endif
"      call writefile(lines, f)
"    endif
"  endfunction
"
"  if !exists('g:screen_size_restore_pos')
"    let g:screen_size_restore_pos = 1
"  endif
"  if !exists('g:screen_size_by_vim_instance')
"    let g:screen_size_by_vim_instance = 1
"  endif
"  autocmd VimEnter * if g:screen_size_restore_pos == 1 | call ScreenRestore() | endif
"  autocmd VimLeavePre * if g:screen_size_restore_pos == 1 | call ScreenSave() | endif
"endif

autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType tt2html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete

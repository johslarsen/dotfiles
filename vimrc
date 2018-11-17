" Plugins {{{1
set nocompatible " explicitly get out of vi-compatible mode
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'Ron89/thesaurus_query.vim' " ,cs
"Plugin 'Valloric/YouCompleteMe'
Plugin 'airblade/vim-gitgutter'
"Plugin 'alepez/vim-gtest' " does not work that well
Plugin 'ciaranm/googletest-syntax'
Plugin 'confluencewiki.vim'
Plugin 'csexton/trailertrash.vim'
"Plugin 'dajero/VimLab' " MATLAB
Plugin 'derekwyatt/vim-fswitch'
"Plugin 'elixir-lang/vim-elixir'
"Plugin 'ervandew/screen' " VimLab dependency
Plugin 'gavinbeatty/dragvisuals.vim'
Plugin 'gnupg'
Plugin 'jiangmiao/auto-pairs'
Plugin 'johslarsen/clang_complete' " fix <CR> mapping
Plugin 'johslarsen/vim-endwise' " #endif /*foo*/
Plugin 'johslarsen/vim-hashrocket'
Plugin 'jmirabel/vim-cmake'
Plugin 'lervag/vimtex'
Plugin 'majutsushi/tagbar' " ctag source browser
Plugin 'mattn/calendar-vim'
Plugin 'michaeljsmith/vim-indent-object'
Plugin 'mileszs/ack.vim'
Plugin 'nixon/vim-vmath'
Plugin 'scrooloose/syntastic'
Plugin 'sjl/gundo.vim' " undo history
Plugin 'stevearc/vim-arduino'
Plugin 'sunaku/vim-ruby-minitest'
Plugin 'thinca/vim-template'
"Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-apathy'
Plugin 'tpope/vim-dadbod'
Plugin 'tpope/vim-dispatch'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-eunuch'
Plugin 'tpope/vim-fugitive' " git
Plugin 'tpope/vim-rhubarb' " github
Plugin 'tpope/vim-sensible' " lots of defaults
Plugin 'tpope/vim-speeddating'
Plugin 'tpope/vim-tbone' " tmux :Tyank, :Tput
Plugin 'tpope/vim-unimpaired' " lots of shortcuts
"Plugin 'tpope/vim-vinegar' " extended filebrowser, WARN: causes problem with block completion <NL> mapping
Plugin 'yssl/QFEnter' " QF: prev:<CR>/<2-LeftMouse> |:<leader><CR> -:<leaeder><Space> tab:<leader><Tab>

" colorschemes
Plugin 'sjl/badwolf'
Plugin 'tomasr/molokai'
Plugin 'altercation/Vim-colors-solarized'
call vundle#end()
filetype plugin indent on
" Keyboard Shortcuts {{{1
let mapleader="," " WARN: must precede <leader> mappings
noremap <c-,> ,

nnoremap          <leader>a     :Gstatus<cr>
nnoremap          <leader>A     :SyntasticCheck<cr>
nnoremap          <leader>b     :buffers<cr>:buffer<Space>
nnoremap          <leader>B     :call SelectaBuffer()<cr>
nnoremap          <leader><C-b> :buffers!<cr>:buffer<Space>
nnoremap <silent> <leader>c     :e $MYVIMRC<cr>:keeppatterns /^" Keyboard Shortcuts<cr>zo:nohlsearch<cr>
nnoremap <silent> <leader>C     :so $MYVIMRC<cr>
nnoremap <silent> <leader>CAL   :CalendarVR<cr>
nnoremap <silent> <leader>d     :Gblame<cr>
nnoremap <silent> <leader>D     :Gvdiff<cr>
nnoremap <silent> <leader><C-d> :Gsdiff<cr>
nnoremap <silent> <leader>e     :Explore<cr>
nnoremap <silent> <leader>E     :Vexplore<cr>
nnoremap <silent> <leader><c-e> :Sexplore<cr>
nnoremap <silent> <leader>f     :set invcursorline invcursorcolumn<cr>
nnoremap <silent> <leader>F     :call SelectaCommand('git grep -lE "\\<<C-r><C-w>\\>"', '', ':vsplit')<cr>
vnoremap <silent> <leader>F     "vy:call SelectaCommand('git grep -lE "<C-r>v"', '', ':vsplit')<cr>
nnoremap <silent> <leader><C-f> :call SelectaCommand('ag -lw "<C-r><C-w>"', '', ':vsplit')<cr>
vnoremap <silent> <leader><C-f> "vy:call SelectaCommand('ag -l "<C-r>v"', '', ':vsplit')<cr>
nnoremap <silent> <leader>g     :vimgrep /\<<C-r><C-w>\>/gj %<cr>
vnoremap <silent> <leader>g     "vy:vimgrep /<C-r>v/gj %<cr>
nnoremap <silent> <leader>G     :Ggrep! -E "\\<<C-r><C-w>\\>"<cr><cr>
vnoremap <silent> <leader>G     "vy:Ggrep! -E "<C-r>v"<cr><cr>
nnoremap <silent> <leader><C-g> :Ack! -w '<C-r><C-w>'<cr>
vnoremap <silent> <leader><C-g> "vy:Ack! '<C-r>v'<cr>
nnoremap <silent> <leader>h     :FSHere<cr>
nnoremap <silent> <leader>H     :FSSplitLeft<cr>
nnoremap <silent> <leader><c-h> :FSSplitAbove<cr>
nnoremap <silent> <leader>i     gg=G
nnoremap <silent> <leader>I     :call g:retab_indents()<cr>
nnoremap <silent> <leader>k     :psearch <C-r><C-w><cr>
nnoremap <silent> <leader>K     :psearch <C-r><C-a><cr>
nnoremap <silent> <leader>l     :TagbarToggle<cr>
nnoremap <silent> <leader>L     :set list!<cr>
nnoremap <silent> <leader><C-l> :let &spl = &spl == 'en_us' ? 'nb' : 'en_us'<CR>
nnoremap <silent> <leader>m     :Make -j=g:number_of_processors<cr><cr>
nnoremap          <leader>M     :Make -j=g:number_of_processors<cr><space>
nnoremap <silent> <leader><c-m> :CMake<cr>
nnoremap <silent> <leader>n     :nohlsearch<cr>
nnoremap <silent> <leader>N     :set invnumber invrelativenumber<cr>
nnoremap          <leader>o     :call SelectaCommand("~/.bin/findSourceFiles.sh", "", ":e")<cr>
nnoremap          <leader>O     :call SelectaCommand("~/.bin/findSourceFiles.sh", "", ":vsplit")<cr>
nnoremap          <leader><C-o> :call SelectaCommand("~/.bin/findSourceFiles.sh", "", ":split")<cr>
nnoremap          <leader>p     :help<space>
vnoremap <silent> <leader>p     "vy:help <C-r>v<cr>
nnoremap <silent> <leader>P     :helpclose<cr>
nnoremap          <leader><C-p> :lhelpgrep<space>
vnoremap <silent> <leader><C-p> "vy:lhelpgrep <C-r>v<cr>
nnoremap <silent> <leader>q     :copen<cr>
nnoremap <silent> <leader>Q     :cclose<cr>:clist<cr>
nnoremap          <leader>r     :%s/\<<C-r><C-w>\>//g<Left><Left>
vnoremap          <leader>r     "vy:%s/<C-r>v//g<Left><Left>
nnoremap          <leader>R     :%s/\<<C-r><C-a>\>//g<Left><Left>
nnoremap          <leader>s     :split<Space>
nnoremap          <leader>S     :vsplit<Space>
nnoremap <silent> <leader>t     :edit =ToggleSourceTestFilename()<cr><cr>
nnoremap <silent> <leader>T     :vsplit =ToggleSourceTestFilename()<cr><cr>
nnoremap <silent> <leader><c-t> :split =ToggleSourceTestFilename()<cr><cr>
nnoremap <silent> <leader>u     :call g:ClangUpdateQuickFix()<cr>
nnoremap <silent> <leader>U     :GundoToggle<CR>
nnoremap <silent> <leader>w     :lopen 4<cr>
nnoremap <silent> <leader>W     :lclose<cr>:llist<cr>
nnoremap <silent> <leader>ye    :GTestCaseToggle<cr>
nnoremap <silent> <leader>yy    :MakeCheckGTest *<cr>
nnoremap          <leader>yY    :MakeCheckGTest *
nnoremap          <leader>x     :Dispatch<space>
nnoremap          <leader>X     :Dispatch!<space>
nnoremap          <leader><C-x> :Start!<space>
nnoremap          <leader>7     :call ToggleStaticColorcolumn(73)<cr>
nnoremap          <leader>8     :call ToggleStaticColorcolumn(81)<cr>
nnoremap          <leader>%     :%s//gc<Left><Left><Left>
nnoremap          <leader>"     :call AutoPairsToggle()<CR>
nnoremap          <leader>+     :Gstatus<cr>
nnoremap          <leader>?     :Glog<cr>

vmap <expr> ++ VMATH_YankAndAnalyse()
nmap        ++ vip++

" unimpaired-like {{{2
nmap <silent> coa :let b:syntastic_mode = SyntasticIsPassive() ? 'active' : 'passive'<CR>

" Convenience {{{2
nnoremap Q <nop>
nnoremap <space> za

" Norwegian keyboard layout requires AltGr for lots of useful buttons, so remap the characters that are on the location that these are in the US keyboard layout
noremap § ~
noremap ¤ $
nmap T <c-]>
nmap <CR> <c-]>
nmap <C-w><C-t> <C-w>}
" these are just very close
map ø [
map æ ]
map Ø {
map Æ }

" toggle between this and previous buffer
nnoremap <C-e> :buffer #<CR>
" Movement {{{2
noremap <NL> gj

nnoremap <silent> [G gg:keeppatterns /^TEST<cr>
nnoremap <silent> [g   :keeppatterns ?^TEST<cr>
nnoremap <silent> ]g   :keeppatterns /^TEST<cr>
nnoremap <silent> ]G  G:keeppatterns ?^TEST<cr>

nnoremap <silent> <c-g>      :call ChangeNextPlaceholder()<cr>
inoremap <silent> <c-g> <ESC>:call ChangeNextPlaceholder()<cr>

vmap <expr> D       DVB_Duplicate()
vmap <expr> <s-LEFT>  DVB_Drag('left')
vmap <expr> <s-DOWN>  DVB_Drag('down')
vmap <expr> <s-UP>    DVB_Drag('up')
vmap <expr> <s-RIGHT> DVB_Drag('right')
" Insert {{{2
inoremap <c-c> <Esc>

" custom completion, neatly located between ^n (next, completion) and ^p (previous)
inoremap <c-k> <c-x><c-o>

" nbsp = space
inoremap   <Space>
" Command Line {{{2
" BASH-like command line movement
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <C-d> <Delete>
cnoremap <M-b> <S-Left>
cnoremap <M-f> <S-Right>
" Syntax {{{1
syntax on

set noexpandtab
set softtabstop=0
set tabstop=4
set shiftwidth=4
set cindent

set foldmethod=syntax
set foldlevel=0

set spell
set spelllang=en_us
set spellfile= " '': <runtimepath>/behaviour/<lang>.<encoding>.add
set spellcapcheck=

set formatoptions-=t " do not wrap by default
set nrformats=hex,alpha
set nojoinspaces
" UI Look {{{1
set background=dark
colorscheme badwolf

highlight SpellBad term=reverse cterm=bold,underline
highlight SpellLocal term=reverse cterm=underline ctermfg=brown ctermbg=NONE
highlight SpellRare term=reverse cterm=underline ctermfg=yellow ctermbg=NONE

set listchars=eol:$,tab:>-,nbsp:%,precedes:<,extends:>
highlight NonText    cterm=bold ctermfg=magenta
highlight SpecialKey cterm=NONE ctermfg=black ctermbg=brown

set laststatus=2
set statusline=%< " truncate from left
set statusline+=%#ErrorMsg#%{SyntasticStatuslineFlag()}%{SyntasticIsPassive()?'[PASSIVE]':''}%*
set statusline+=%{fugitive#statusline()}
set statusline+=%y[%{&fo}][%{strlen(&fenc)?&fenc:&enc},%{&ff}][%{&spl}]
set statusline+=\ %f\  " the file name
set statusline+=%#ModeMsg#%h%m%*
set statusline+=%#WarningMsg#%{&paste?'[PASTE]':''}%q%w%r%a%*
set statusline+=%=0x%B\ (%4l/%-4L,%2c%-2V)\ %P " on right side
highlight StatusLine term=bold cterm=bold ctermfg=darkgreen  ctermbg=darkred
set noshowmode " keep info when cmdline is not in use

set number
set relativenumber
set nocursorline
set colorcolumn=+1
highlight ColorColumn ctermbg=magenta

set title
set titlestring=''
set titleold=''
" UI Feel {{{1
set visualbell t_vb=
set mouse=a
if has("mouse_sgr")
  set ttymouse=sgr
else
  set ttymouse=xterm2
end

set showmatch " bracket,...
set hlsearch
set ignorecase
set smartcase

set completeopt=menu,preview
set completefunc=syntaxcomplete#Complete
highlight Pmenu ctermfg=white ctermbg=blue
highlight PmenuSel ctermfg=blue ctermbg=white

set concealcursor=nv
set conceallevel=2

set diffopt=vertical
" Buffers {{{1
set hidden " instead of closing buffers

set noswapfile
set backupdir=~/tmp,/tmp
set history=1000
set undolevels=1000
"}}}
" Plugins (alphabetized) {{{
let g:AutoPairsShortcutBackInsert = '<C-b>'
let g:AutoPairsShortcutFastWrap = ''
let g:AutoPairsShortcutJump = ''
let g:AutoPairsShortcutToggle = ''

let g:DVB_TrimWS = 1

let g:arduino_dir = '/usr/share/arduino' " location on archlinux

let g:calendar_mark = 'left-fit'
let g:calendar_monday = 1
let g:calendar_weeknm = 5

let g:clang_auto_user_options = 'includeCurrentHeaders,.clang_complete,path'
let g:clang_close_preview = 1
let g:clang_complete_macros = 1
let g:clang_complete_optional_args_in_snippets = 0
let g:clang_jumpto_declaration_in_preview_key = '<C-W>}'
let g:clang_snippets = 1
let g:clang_trailing_placeholder = 1
let g:clang_user_options = "-std=c++14 -Idefs -Iinclude -I. -L."

let g:gitgutter_diff_args = '-w'
let g:gitgutter_escape_grep = 1
let g:gitgutter_map_keys = 0

let g:html_indent_inctags = "html,body,head,tbody"
let g:html_indent_script1="inc"
let g:html_indent_style1="inc"

let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_classes_in_global = 1
let g:rubycomplete_rails = 1

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_wq = 0
"let g:syntastic_debug = 3 "0,1,3,33
"let g:syntastic_quiet_messages = { "type": "style" }
let g:syntastic_stl_format = "[E%e W%w]"

let s:W = ' -Wall'
"let s:W .= ' -fno-syntax-only -c -o/dev/null' " lots of warnings in compliation stages
let s:W .= ' -Wextra -pedantic'
let s:W .= ' -Wformat=2 -Wformat-overflow=2 -Wwrite-strings'
let s:W .= ' -Wnull-dereference -fcheck-pointer-bounds -mmpx -Wchkp'
let s:W .= ' -Wsuggest-override -Wsuggest-attribute=pure -Wsuggest-attribute=const -Wsuggest-attribute=noreturn'
let s:W .= ' -Wswitch-default -Wduplicated-branches -Wduplicated-cond'
let s:W .= ' -Wtrampolines -Wfloat-equal -Wlogical-op -Wshadow=global'
let s:W .= ' -Wrestrict -Winline'
let s:W .= ' -Wstack-protector -fstack-protector'
"let s:W .= ' -Weffc++ -Wpadded'
let g:syntastic_c_compiler_options = s:W . ' -std=c11 -Wbad-function-cast -Wstrict-prototypes -Wold-style-definition -Wc++-compat'
let g:syntastic_cpp_compiler_options = s:W . ' -std=c++14 -Wregister -Wstrict-null-sentinel -Wold-style-cast -Wzero-as-null-pointer-constant'
let g:syntastic_cpp_check_header = 1

let g:syntastic_python_checkers = ['python']
let g:syntastic_python_python_exec = 'python2'

let g:syntastic_ruby_checkers = ['mri', 'rubocop']
let g:syntastic_ruby_rubocop_args = '-l'

let g:tagbar_autoclose = 1
let g:tagbar_autofocus = 1
let g:tagbar_compact = 1
let g:tagbar_ctags_bin = '/usr/bin/ctags' " defaults to ctags-exuberant for some reason

let g:template_free_pattern = "_WILDCARD_"

let g:tex_flavor = "latex"
let g:tex_fold_enabled = 1

let g:tq_use_vim_autocomplete=0

let g:zipPlugin_ext = '*.zip,*.jar,*.xpi,*.ja,*.war,*.ear,*.celzip,*.oxt,*.kmz,*.wsz,*.xap,*.docx,*.docm,*.dotx,*.dotm,*.potx,*.potm,*.ppsx,*.ppsm,*.pptx,*.pptm,*.ppam,*.sldx,*.thmx,*.crtx,*.vdw,*.glox,*.gcsx,*.gqsx'
" Autocommands {{{1
let g:number_of_processors = system('nproc')+0
augroup vimrc
  au VimEnter * if filereadable('CMakeLists.txt') | let &makeprg='cmake --build '.shellescape(get(g:, 'cmake_build_dir', 'build')).' --' | endif
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif " jump to last position
  au User plugin-template-loaded call s:template_init()

  " no folding whilst inserting text (mostly relevant for TeX)
  au InsertEnter * if !exists('w:last_fdm') | let w:last_fdm=&foldmethod | setlocal foldmethod=manual | endif
  au InsertLeave,WinLeave * if exists('w:last_fdm') | let &l:foldmethod=w:last_fdm | unlet w:last_fdm | endif

  au BufEnter *.jira set ft=confluencewiki

  au! BufEnter *.cpp let b:fswitchdst = 'hpp,hh,h'
  au! BufEnter *.cc let b:fswitchdst = 'hh,hpp,h'
  au! BufEnter *.c let b:fswitchdst = 'h,hpp,hh'
  au! BufEnter *.cu let b:fswitchdst = 'cuh,hpp,hh,h'
  au! BufEnter *.hpp let b:fswitchdst = 'cpp,cc,c,cu,ipp,tpp'
  au! BufEnter *.h let b:fswitchdst = 'c,cpp,cc,cu,ipp,tpp'
  au! BufEnter *.{ipp,tpp}
        \ set ft=cpp |
        \ let b:fswitchdst = 'hpp,hh,h' |
        \ let b:fswitchlocs = 'reg:/src/include/,reg:|src|include/**|,../include' |
        \ let b:syntastic_cpp_cflags = '-include '.shellescape(fnamemodify(expand('%:r').'.hpp', ':p'))

  au! BufEnter fugitive:/* setl statusline=%{fugitive#statusline()}%<\ %f\ %=0x%B
  au! BufEnter *.fugitiveblame setl statusline=%f

augroup END
" Functions (alphabetized) {{{1
function! ColonsToSlash(namespace)
  return substitute(a:namespace, '::', '\/', 'g')
endfunction

function! ChangeNextPlaceholder()
  if search('#\u\+#', 'w')
    echo matchlist(getline('.'), '#\([A-Z]\+\)#')[1]
    execute 'normal!' "cf#"
  endif
endfunction

command! GTestCaseToggle call _GTestCaseToggle()
function! _GTestCaseToggle()
  let l:cursor = getcurpos()
  if match(getline('.'), '^TEST', '')
    :keeppatterns ?^TEST
  endif
  s/\(TEST.*([^,]*,[ \t\n]*\)\(DISABLED_\)\?/\=submatch(1).ToggleEmptyOr('DISABLED_', submatch(2))/
  call setpos('.', l:cursor)
endfunction

function! IndentationString(indentation_level)
    if &expandtab
        return repeat(repeat(" ", &shiftwidth), a:indentation_level)
    else
        return repeat("\t", a:indentation_level)
    endif
endfunction

command! -nargs=* MakeCheck call _MakeCheck(<f-args>)
function! _MakeCheck(...)
  let l:target = 'check'
  if filereadable('CMakeLists.txt')
    let l:target = 'test ARGS=-V'
  endif
  exec 'Make' l:target join(a:000)
endfunction
command! -nargs=1 MakeCheckGTest call _MakeCheckGTest(<f-args>)
function! _MakeCheckGTest(filter)
  let l:errorformat=&errorformat

  let s:ctest_prefix=''
  if filereadable('CMakeLists.txt')
    let s:ctest_prefix='%c: ' " might as well show ctest id, so put it as column number
  endif

  let &errorformat  =  s:ctest_prefix.'%.%#: %f:%l: %m' " C/C++ assertions
  let &errorformat .= ',%A'.s:ctest_prefix.'%f:%l: %t%[ar]%[ir]%[lo]%[ur]%.%#'
  let &errorformat .= ',%Z'.s:ctest_prefix.'[%.%#] %m'
  let &errorformat .= ',%C'.s:ctest_prefix.'%m'

  " NOTE: ctest specific
  let &errorformat .= ',%E%c/%l Test #%\d%#: %f .%#***%m' " hacky way to catch segfault errors++
  " NOTE: gtester specific
  let &errorformat .= ',%EFAIL: %f' " segfuault, exceptions, ...

  let $GTEST_COLOR='no' " causes problems in output
  let $GTEST_FILTER=a:filter
  call _MakeCheck()
  let &errorformat=l:errorformat
endfunction

function! RPath(path)
  return fnamemodify(expand(a:path),":~:.")
endfunction

function! RetabIndents()
  execute '%s@^\(\ \{'.&ts.'\}\)\+@\=repeat("\t", len(submatch(0))/'.&ts.')@e'
endfunction

function! SelectaBuffer()
  let bufnrs = filter(range(1, bufnr("$")), 'buflisted(v:val)')
  let buffers = map(bufnrs, 'bufname(v:val)')
  call SelectaCommand('echo "' . join(buffers, "\n") . '"', "", ":b")
endfunction


function! SelectaCommand(choice_command, selecta_args, vim_command)
  try
    let selection = system(a:choice_command . " | selecta " . a:selecta_args)
  catch /Vim:Interrupt/
    " Swallow the ^C so that the redraw below happens; otherwise there will be
    " leftovers from selecta on the screen
    redraw!
    return
  endtry
  redraw!
  exec a:vim_command . " " . selection
endfunction

function! SlashToColons(path)
  return substitute(a:path, '\/', '::', 'g')
endfunction

function! SyntasticIsPassive()
  return exists('b:syntastic_mode') && b:syntastic_mode == 'passive'
endfunction

function! ToCamel(str_with_underscore)
  let l:without_underscores = substitute(a:str_with_underscore, '_\(\a\)', '\u\1', 'g')
  return substitute(l:without_underscores, '\(^\|\A\)\(\a\)', '\1\u\2', 'g')
endfunction

function! ToSnake(camel_case_str)
  let l:without_intra_camel = substitute(a:camel_case_str, '\(\l\)\(\u\)', '\1_\l\2', 'g')
  return substitute(l:without_intra_camel, '\(\u\)', '\l\1', 'g')
endfunction

function! ToggleEmptyOr(needle, haystack)
  return a:haystack != a:needle ? a:needle : ''
endfunction

function! ToggleStaticColorcolumn(width)
  let &colorcolumn = &colorcolumn == a:width ? -1 : a:width
endfunction

function! s:template_init()
  silent %s/#=\(.\{-\}\)#/\=eval(submatch(1))/ge
  silent %s/\t/\=IndentationString(1)/ge
  :0
  execute 'set nofoldenable'
  syntax match Todo "#\u\+#" containedin=ALL
  if search('#CURSOR#')
    execute 'normal! "_df#'
  endif
endfunction
" }}}
" vim:foldmethod=marker:foldlevel=0

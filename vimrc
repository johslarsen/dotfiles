" Plugins {{{1
set nocompatible " explicitly get out of vi-compatible mode
filetype off

if has('python3') | endif " make sure none loads python2 accidentally

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

" Syntax/Language {{{2
Plugin 'andrewstuart/vim-kubernetes'
Plugin 'chrisbra/csv.vim'
Plugin 'ciaranm/googletest-syntax'
Plugin 'confluencewiki.vim'
Plugin 'fatih/vim-go'
Plugin 'jmirabel/vim-cmake'
Plugin 'lervag/vimtex'
"Plugin 'mzlogin/vim-markdown-toc'
Plugin 'rust-lang/rust.vim'
Plugin 'saltstack/salt-vim'
Plugin 'sirtaj/vim-openscad'
Plugin 'stevearc/vim-arduino'
Plugin 'sunaku/vim-ruby-minitest'

" IDE-like {{{2
Plugin 'johslarsen/vim-clang-format'
Plugin 'johslarsen/vim-endwise' " #endif /*foo*/
Plugin 'johslarsen/vim-racer'
Plugin 'johslarsen/vim-testcov'
Plugin 'majutsushi/tagbar' " ctag source browser
Plugin 'neoclide/coc.nvim'
Plugin 'scrooloose/syntastic'
Plugin 'tpope/vim-dispatch' " :Make
Plugin 'tpope/vim-apathy' " more sane include++ path defaults

" Version control {{{2
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-fugitive' " git
Plugin 'tpope/vim-rhubarb' " github

" Buffer management {{{2
Plugin 'derekwyatt/vim-fswitch' " .c/.h toggle
Plugin 'junegunn/fzf.vim'
Plugin 'mattn/calendar-vim'
Plugin 'wellle/visual-split.vim' " vip,s: split with the selected paragraph
Plugin 'ronakg/quickr-preview.vim' " quick/loc: ,<space>: preview

" Text objects {{{2
Plugin 'michaeljsmith/vim-indent-object' " ii
Plugin 'wellle/targets.vim' " 2i(: nth enclosing (), n(: following (...)
Plugin 'tpope/vim-commentary' " gcip toggle comment on paragraph
Plugin 'tpope/vim-speeddating' " d<C-a>: replace with UTC, d<C-x>: replace with local time
Plugin 'tpope/vim-tbone' " tmux :Tyank, :Tput

" Visual indicators {{{2
Plugin 'csexton/trailertrash.vim'

" Snippets {{{2
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'thinca/vim-template'

" Colorschemes {{{2
Plugin 'sjl/badwolf'
Plugin 'altercation/vim-colors-solarized'

" Miscellaneous {{{2
Plugin 'sjl/gundo.vim' " undo history
Plugin 'tpope/vim-sensible' " lots of defaults

let g:loaded_matchit=1 " stop vim-unimpaired from loading it
Plugin 'tpope/vim-unimpaired' " lots of shortcuts

Plugin 'gnupg'
Plugin 'tpope/vim-eunuch' " :SudoWrite
Plugin 'tpope/vim-dadbod' " in *.sql, e.g. :!DB mysql://
Plugin 'nixon/vim-vmath' " vip++: sum/avg/... of numbers in paragraph

Plugin 'c9s/helper.vim'
Plugin 'c9s/treemenu.vim'
Plugin 'c9s/vikube.vim'

call vundle#end()
filetype plugin indent on
" Keyboard Shortcuts {{{1
let mapleader="," " WARN: must precede <leader> mappings
noremap <c-,> ,

nnoremap          <leader>A     :SyntasticCheck<cr>
nnoremap          <leader><C-a> :SyntasticCheck<Space>
nnoremap          <leader>b     :Buffers<cr>
nnoremap          <leader><C-b> :buffers!<cr>:buffer<Space>
nnoremap <silent> <leader>c     :e $MYVIMRC<cr>:keeppatterns /^" Keyboard Shortcuts<cr>zo:nohlsearch<cr>
nnoremap <silent> <leader>ce    :let b:syntastic_mode = exists('b:syntastic_mode') && b:syntastic_mode == 'passive' ? 'active' : 'passive'<cr>
nnoremap <silent> <leader>C     :so $MYVIMRC<cr>
nnoremap <silent> <leader>CD    :call Theme("dark")<cr>
nnoremap <silent> <leader>CL    :call Theme("light")<cr>
nnoremap <silent> <leader>CAL   :CalendarVR<cr>
nnoremap <silent> <leader>d     :Git blame<cr>
nnoremap <silent> <leader>D     :Gvdiffsplit<cr>
nnoremap <silent> <leader><C-d> :Ghdiffsplit<cr>
nnoremap <silent> <leader>e     :Explore<cr>
nnoremap <silent> <leader>E     :Vexplore<cr>
nnoremap <silent> <leader><c-e> :Sexplore<cr>
nnoremap <silent> <leader>f     :set invcursorline invcursorcolumn<cr>
nnoremap <silent> <leader>F     :Tags <C-r><C-w><cr>
vnoremap <silent> <leader>F     "vy:Tags <C-r>v<cr>
nnoremap <silent> <leader><C-f> :Lines <C-r><C-w><cr>
nnoremap <silent> <leader>g     :vimgrep /\<<C-r><C-w>\>/gj %<cr>
vnoremap <silent> <leader>g     "vy:vimgrep /<C-r>v/gj %<cr>
nnoremap <silent> <leader>G     :GGrep \<<C-r><C-w>\><cr>
vnoremap <silent> <leader>G     "vy:GGrep <C-r>v<cr>
nnoremap <silent> <leader><C-g> :Ag <C-r><C-w><cr>
vnoremap <silent> <leader><C-g> "vy:Ag <C-r>v<cr>
nnoremap <silent> <leader>h     :FSHere<cr>
nnoremap <silent> <leader>H     :FSSplitLeft<cr>
nnoremap <silent> <leader><c-h> :FSSplitAbove<cr>
nmap     <silent> <leader>ia    <plug>(coc-codeaction-line)
xmap     <silent> <leader>ia    <plug>(coc-codeaction-selected)
nmap     <silent> <leader>ic    :call CocAction('showIncomingCalls')<CR>
nmap     <silent> <leader>iC    :call CocAction('showOutgoingCalls')<CR>
nmap     <silent> <leader>id    <plug>(coc-definition)
nnoremap <silent> <leader>iD    :call CocAction('jumpDefinition', 'pedit')<CR>
nmap     <silent> <leader>i<C-d> :call CocAction('jumpDeclaration', 'pedit')<CR>
nnoremap <silent> <leader>ie    :exec g:coc_enabled ? 'CocDisable' : 'CocEnable'<CR>
nmap     <silent> <leader>if    <plug>(coc-format)
xmap     <silent> <leader>if    <plug>(coc-format-selected)
nmap     <silent> <leader>ih    :CocCommand document.toggleInlayHint<CR>
nmap     <silent> <leader>il    <plug>(coc-references)
nmap     <silent> <leader>iL    <plug>(coc-references-used)
nmap     <silent> <leader>io    :call CocAction('showOutline')<CR>
nmap     <silent> <leader>iq    <plug>(coc-fix-current)
nmap     <silent> <leader>ir    <plug>(coc-rename)
nmap     <silent> <leader>is    :call CocActionAsync('showSemanticHighlightInfo')<CR>
nmap     <silent> <leader>i<C-r> <plug>(coc-refactor)
nnoremap <silent> <leader>I     gg=G
nnoremap <silent> <leader>k     :psearch <C-r><C-w><cr>
nnoremap <silent> <leader>K     :psearch <C-r><C-a><cr>
nnoremap <silent> <leader>l     :TagbarToggle<cr>
nnoremap <silent> <leader>L     :set list!<cr>
nnoremap <silent> <leader><C-l> :let &spl = &spl == 'en_us' ? 'nb' : 'en_us'<CR>
nnoremap <silent> <leader>m     :Make -j=g:number_of_processors<cr><cr>
nnoremap          <leader>M     :Make -j=g:number_of_processors<cr><space>
nnoremap <silent> <leader><c-m> :CMake<cr>
nnoremap <silent> <leader>n     :nohlsearch<cr>
nnoremap <silent> <leader>N     :set invnumber invrelativenumber signcolumn==&signcolumn=="auto"?"no":"auto"<cr><cr>
nnoremap          <leader>o     :GFiles<cr>
nnoremap          <leader>O     :Files<cr>
nnoremap          <leader><C-o> :call AllFiles('.')<cr>
nnoremap          <leader>p     :Helptags<cr>
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
nnoremap <silent> <leader>U     :GundoToggle<CR>
nnoremap          <leader>v     :Commits<cr>
nnoremap          <leader>V     :BCommits<cr>
nnoremap <silent> <leader>w     :lopen 4<cr>
nnoremap <silent> <leader>W     :lclose<cr>:llist<cr>
nnoremap <silent> <leader>ye    :GTestCaseToggle<cr>
nnoremap <silent> <leader>yy    :CTestGTest *<cr>
nnoremap          <leader>yY    :CTestGTest *
nnoremap          <leader>yf    :CTestGTest <C-r>=GTestContext()[0]<cr>.*<cr>
nnoremap          <leader>yF    :CTestGTest <C-r>=GTestContext()[0]<cr>.*
nnoremap          <leader>yt    :CTestGTest <C-r>=join(GTestContext(),'.')<cr><cr>
nnoremap          <leader>yT    :CTestGTest <C-r>=join(GTestContext(),'.')<cr>
nnoremap <silent> <leader>yc    :TestcovMark<cr>
nnoremap <silent> <leader>yC    :TestcovRefresh<cr>
nnoremap          <leader>x     :Dispatch<space>
nnoremap          <leader>X     :Dispatch!<space>
nnoremap          <leader><C-x> :Start!<space>
nnoremap          <leader>7     :call ToggleStaticColorcolumn(73)<cr>
nnoremap          <leader>8     :call ToggleStaticColorcolumn(81)<cr>
nnoremap          <leader>%     :%s//gc<Left><Left><Left>
nnoremap          <leader>"     :call AutoPairsToggle()<CR>
nnoremap <silent> <leader>+     :call GFileStatus(expand('%'))<cr>
nnoremap <silent> <leader>?     :Gclog! ./<C-r>%<cr>
nnoremap <silent> <leader><CR>  :Git! show <C-r><C-w><cr>

nnoremap          <leader><Tab> :Snippets<cr>

vnoremap <silent> <leader>r     :VSResize<cr>
vnoremap <silent> <leader>s     :VSSplitAbove<cr>
vnoremap <silent> <leader>S     :VSSplitBelow<cr>

vmap <expr> ++ VMATH_YankAndAnalyse()
nmap        ++ vip++

" unimpaired-like {{{2
nmap <silent> yoa :let b:syntastic_mode = SyntasticIsPassive() ? 'active' : 'passive'<CR>
nmap <silent> yof :setlocal foldmethod=<C-r>=&foldmethod != 'syntax' ? 'syntax' : 'indent'<CR><CR>

" Convenience {{{2
nnoremap Q <nop>
nnoremap <space> za

nnoremap <silent> zp :GitGutterFold<cr>

" consistent behavior with D, C
nnoremap Y y$

" Norwegian keyboard layout requires AltGr for lots of useful buttons, so remap the characters that are on the location that these are in the US keyboard layout
noremap § ~
noremap ¤ $
nmap T <c-]>
nmap <CR> <c-]>
nmap <C-w><C-t> <C-w>}
" these are just very close
map ø [
map øø [[
map øæ []
map æø ][
map æ ]
map ææ ]]
map Ø {
map Æ }
map ØØ {{
map ÆÆ }}

" toggle between this and previous buffer
nnoremap <C-e> :buffer #<CR>
" Movement {{{2
noremap <C-Up> gk
noremap <C-Down> gj

nnoremap <silent> % %:call CocActionAsync('doHover')<CR>

nmap <silent> [i <Plug>(coc-diagnostic-prev)
nmap <silent> ]i <Plug>(coc-diagnostic-next)
nmap <silent> [I <Plug>(coc-diagnostic-prev-error)
nmap <silent> ]I <Plug>(coc-diagnostic-next-error)

nmap <silent> [g <Plug>GitGutterPrevHunk
nmap <silent> ]g <Plug>GitGutterNextHunk

onoremap ih <Plug>GitGutterTextObjectInnerPending
onoremap ah <Plug>GitGutterTextObjectOuterPending
xnoremap ih <Plug>GitGutterTextObjectInnerVisual
xnoremap ah <Plug>GitGutterTextObjectOuterVisual

xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Insert {{{2
inoremap <c-c> <Esc>

" custom completion, neatly located between ^n (next, completion) and ^p (previous)
inoremap <c-k> <c-x><c-o>

" <c-space> is a new keycode in neovim. in traditional vim/xterm/... it produce <c-@> (null byte)
nnoremap <silent>       <c-space> :call CocActionAsync('doHover')<CR>
nnoremap <silent>       <c-@> :call CocActionAsync('doHover')<CR>
inoremap <silent><expr> <c-space> coc#refresh()
inoremap <silent><expr> <c-@> coc#refresh()
inoremap <silent><expr> <c-\> CocActionAsync('showSignatureHelp')

" mimic UltiSnips behavior for clang_complete snippets
nmap <C-j> <Tab>
smap <C-j> <ESC><Tab>
imap <C-j> <ESC><Tab>

inoremap <silent> <S-Tab> <C-\><C-o>:Snippets<cr>

" accept selected completion item
imap <C-l> <C-y>

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

set expandtab
set softtabstop=0
set tabstop=4
set shiftwidth=4
set cindent

set spell
set spelllang=en_us
set spellfile= " '': <runtimepath>/behaviour/<lang>.<encoding>.add
set spellcapcheck=
set thesaurus=~/.vim/thesaurus/english.txt

set formatoptions-=t " do not wrap by default
set nrformats=hex,alpha
set nojoinspaces
" UI Look {{{1
function! Theme(background)
  if a:background == "light"
    colorscheme solarized
  else
    colorscheme badwolf
  endif
  let &background=a:background
endfunction
call Theme("dark")

highlight Normal ctermfg=darkgreen
highlight Special ctermfg=lightgreen

highlight DiffText ctermfg=darkgreen cterm=bold ctermbg=darkblue

highlight SpellBad term=reverse cterm=bold,underline ctermbg=NONE
highlight SpellLocal term=reverse cterm=underline ctermfg=brown ctermbg=NONE
highlight SpellRare term=reverse cterm=underline ctermfg=yellow ctermbg=NONE

set listchars=eol:$,tab:>-,nbsp:%,precedes:<,extends:>
highlight NonText    cterm=bold ctermfg=magenta
highlight SpecialKey cterm=NONE ctermfg=black ctermbg=brown

highlight CocHoverRange ctermbg=234

highlight Function ctermfg=210
highlight CocSemMethod ctermfg=216
highlight Structure ctermfg=205
highlight CocSemNamespace ctermfg=133
highlight CocSemProperty ctermfg=202
highlight CocSemParameter ctermfg=208
highlight link CocSemTypeParameter Type

set laststatus=2
set statusline=%< " truncate from left
set statusline+=[%#ErrorMsg#%{coc#status()}%*]
set statusline+=%#ErrorMsg#%{SyntasticStatuslineFlag()}%*
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
if !has('nvim')
  set visualbell t_vb=
  set mouse=a
  if has("mouse_sgr")
    set ttymouse=sgr
  else
    set ttymouse=xterm2
  end
endif

set showmatch " bracket,...
set hlsearch
set ignorecase
set smartcase

set previewheight=5

set completeopt=menu
set completefunc=syntaxcomplete#Complete
set shortmess+=c " no "Match N of M" when i_<C-n/p>

set concealcursor=nv
set conceallevel=2

set diffopt=vertical

set updatetime=300 " speed up CursorHold feedback

" Buffers {{{1
set hidden " instead of closing buffers

set noswapfile
set backupdir=~/tmp,/tmp
set history=1000
set undolevels=1000

"}}}
" Plugins (alphabetized) {{{
let g:AutoPairsShortcutBackInsert = '<C-b>' " ctrl + backspace
let g:AutoPairsShortcutFastWrap = ''
let g:AutoPairsShortcutJump = ''
let g:AutoPairsShortcutToggle = ''

let g:UltiSnipsExpandTrigger="<Tab>"
let g:UltiSnipsJumpBackwardTrigger = '<C-l>' " default <C-k> conflicts with my omni-complete hotkey
let g:UltiSnipsJumpForwardTrigger = '<C-j>'

let g:arduino_dir = '/usr/share/arduino' " location on archlinux

let g:calendar_mark = 'left-fit'
let g:calendar_monday = 1
let g:calendar_weeknm = 5

let g:coc_default_semantic_highlight_groups = 1

let g:csv_comment = '#'
let g:csv_end = 10
let g:csv_nl = 1

let g:fzf_layout = { 'down': '33%' }
command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>,
  \                 <bang>0 ? fzf#vim#with_preview('up:60%')
  \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
  \                 <bang>0)
command! -bang -nargs=* GGrep
  \ call fzf#vim#grep('git grep --line-number '.shellescape(<q-args>), 0,
  \                   <bang>0 ? fzf#vim#with_preview('up:60%')
  \                           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \                   <bang>0)

let $VIM_GITGUTTER_TEST=1 " avoids CursorHold warning
let g:gitgutter_diff_args = '-w'
let g:gitgutter_escape_grep = 1
let g:gitgutter_map_keys = 0
let g:gitgutter_sign_priority = 5

let g:go_template_autocreate = 0

let g:gundo_prefer_python3 = 1

let g:html_indent_inctags = "html,body,head,tbody"
let g:html_indent_script1="inc"
let g:html_indent_style1="inc"

let g:quickr_preview_size = 5
let g:quickr_preview_keymaps = 0

let g:racer_experimental_completer = 1
let g:racer_insert_paren = 1

let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_classes_in_global = 1
let g:rubycomplete_rails = 1

let g:rust_cargo_check_tests = 1
let g:rustfmt_autosave = 1

let g:clang_format#code_style="Google"
let g:clang_format#style_options={"ColumnLimit": 0, "AllowShortCaseLabelsOnASingleLine": "true"}

let g:solarized_termcolors=256

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_mode_map = {"mode": "passive"}
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
let s:W .= ' -Wtrampolines -Wfloat-equal -Wlogical-op -Wshadow'
let s:W .= ' -Wrestrict -Winline -fstack-protector'
"let s:W .= ' -Weffc++ -Wpadded'
let g:syntastic_c_compiler_options = s:W . ' -std=c17 -Wbad-function-cast -Wstrict-prototypes -Wold-style-definition -Wc++-compat'
let g:syntastic_cpp_compiler_options = s:W . ' -std=c++20 -Wregister -Wstrict-null-sentinel -Wold-style-cast -Wzero-as-null-pointer-constant'
let g:syntastic_cpp_check_header = 1
let g:syntastic_c_clang_check_post_args = ""
let g:syntastic_cpp_clang_check_post_args = ""
let g:syntastic_c_clang_tidy_post_args = ""
let g:syntastic_cpp_clang_tidy_post_args = ""
let g:syntastic_cpp_clang_check_args = '-p build/ '.substitute(s:W, " ", " --extra-arg=", "g")
let g:syntastic_c_clang_check_args = g:syntastic_cpp_clang_check_args
let g:syntastic_cpp_clang_tidy_args = '-p build/'
let g:syntastic_c_clang_tidy_args = g:syntastic_cpp_clang_tidy_args
if filereadable('CMakeLists.txt')
  let g:syntastic_cpp_checkers = ["clang_check"]
  let g:syntastic_c_checkers = ["clang_check"]
endif

let g:syntastic_python_checkers = ['python']

let g:syntastic_ruby_checkers = ['mri', 'rubocop']
let g:syntastic_ruby_rubocop_args = '-l'

if filereadable('Cargo.toml')
  let g:syntastic_rust_checkers = ['cargo']
else
  let g:syntastic_rust_checkers = ['rustc']
endif

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
  au VimEnter * if !empty($BUILD_IMAGE) | let &makeprg='dmake '.$BUILD_IMAGE | elseif filereadable('CMakeLists.txt') | let &makeprg='cmake --build '.shellescape(get(g:, 'cmake_build_dir', 'build')).' --' | endif
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

  au! BufWinEnter * if &previewwindow | setl foldlevel=99 | endif

  au CursorHold * silent call CocActionAsync('highlight')
  au User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
  au! FileType qf nnoremap <buffer> <CR> <CR>
augroup END
" Functions (alphabetized) {{{1
function! AllFiles(directory)
  let l:fzf_default_command = $FZF_DEFAULT_COMMAND
  let $FZF_DEFAULT_COMMAND = 'fd -IH'
  exec ':Files '.a:directory
  let $FZF_DEFAULT_COMMAND = l:fzf_default_command
endfunction

command! CocInstallJohs call _CocInstallJohs()
function! _CocInstallJohs()
  call coc#util#install_extension(['coc-clangd', 'coc-cmake', 'coc-go', 'coc-python', 'coc-rust-analyzer', 'coc-sh', 'coc-solargraph', 'coc-vimlsp', 'coc-yaml'])
endfunction

function! ColonsToSlash(namespace)
  return substitute(a:namespace, '::', '\/', 'g')
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

function! GTestContext()
  let id='[[:alnum:]_[:space:]\n]'
  let l:pattern = 'TEST'.id.'*(\('.id.'\+\),\('.id.'\+\))'
  let l:pos = search(l:pattern, 'bcnw')
  if (l:pos == 0)
    return [substitute(RPathSrc("%:r"), "/", "_", "g"), '']
  endif
  let l:match = matchlist(join(getline(l:pos,l:pos+2)), l:pattern)
  return [trim(l:match[1]), trim(l:match[2])]
endfunction

function! GFileStatus(file)
  :Git
  call search(" ".a:file."$")
endfunction

function! IndentationString(indentation_level)
    if &expandtab
        return repeat(repeat(" ", &shiftwidth), a:indentation_level)
    else
        return repeat("\t", a:indentation_level)
    endif
endfunction

command! -nargs=* CTest call _CTest(<f-args>)
function! _CTest(...)
  let l:makeprg=&makeprg
  if empty($BUILD_IMAGE)
    let &makeprg='ctest --test-dir '.shellescape(get(g:, 'cmake_build_dir', 'build'))
  else
    let &makeprg='dtest '.$BUILD_IMAGE
  endif
  if !empty($CTEST_FILTER)
    let &makeprg.=' -R '.shellescape($CTEST_FILTER)
  endif
  exec 'Make' join(a:000)
  let &makeprg=l:makeprg
endfunction
command! -nargs=1 CTestGTest call _CTestGTest(<f-args>)
function! _CTestGTest(filter)
  let l:errorformat=&errorformat

  let &errorformat  =  '%.%#: %f:%l: %m' " C/C++ assertions
  let &errorformat .= ',%A%f:%l: %t%[ar]%[ir]%[lo]%[ur]%.%#'
  let &errorformat .= ',%Z[%.%#] %m'
  let &errorformat .= ',%C%m'

  " NOTE: ctest specific
  let &errorformat .= ',%E%c/%l Test #%\d%#: %f .%#***%m' " hacky way to catch segfault errors++
  " NOTE: gtester specific
  let &errorformat .= ',%EFAIL: %f' " segfuault, exceptions, ...

  let $GTEST_COLOR='no' " causes problems in output
  let $GTEST_FILTER=a:filter
  let $ASAN_OPTIONS='coverage=1'
  let $CTEST_OUTPUT_ON_FAILURE='1'
  call _CTest()
  let &errorformat=l:errorformat
endfunction

function! RPath(path)
  return fnamemodify(expand(a:path),":~:.")
endfunction

function! RPathSrc(path)
  let l:no_prefix = substitute(RPath(a:path), '.*test/', '', 'g')
  return substitute(l:no_prefix, 'test\(\.[^.]*\)\?$', '\1', 'g')
endfunction

function! RetabIndents()
  execute '%s@^\(\ \{'.&ts.'\}\)\+@\=repeat("\t", len(submatch(0))/'.&ts.')@e'
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

function! ToTitle(basename)
  let l:with_spaces = substitute(a:basename, '[-_.]\+', ' ', 'g')
  return substitute(l:with_spaces, '\<.', '\u\0', 'g')
endfunction

function! ToggleEmptyOr(needle, haystack)
  return a:haystack != a:needle ? a:needle : ''
endfunction

function! ToggleStaticColorcolumn(width)
  let &colorcolumn = &colorcolumn == a:width ? -1 : a:width
endfunction

function! s:template_init()
  execute 'set nofoldenable'
  :0
  while search('#SNIPPET#', 'W')
    silent! execute "normal! \"_cf#\<C-r>=UltiSnips#ExpandSnippet()\<CR>"
    silent! execute "normal! \e\e"
  endwhile
  if search("#SNIPPET_ACTIVE#")
    silent! execute 'normal! "_df#'
    silent! execute 'call feedkeys("a\'.g:UltiSnipsExpandTrigger.'")'
  elseif search('#CURSOR#')
    execute 'call feedkeys("\"_cf#")'
  endif
endfunction
" }}}
" vim:foldmethod=marker:foldlevel=0

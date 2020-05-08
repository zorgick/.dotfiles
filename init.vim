" to navigate between sections use <S-{> or <S-}>
" each section is separated from the others by '{{ }}' symbols
" subsections are emphasized by '! ! ====' symbols
" a section may have a part of the utility program which is scattered among sections
" there are 2 types of the utilities with a designated set of symbols
" - self-written utilities - '& & {{{  }}}'
" - plugin utilities - '@ @ {{{  }}}'
" {{ General }}
set nocompatible                                                                " use vim settings rather than vi settings
filetype plugin indent on                                                       " turn on detection, plugin and indent at once
set confirm                                                                     " ask before unsafe actions
set shell=/bin/bash                                                             " use /bin/bash as a shell
set ttyfast                                                                     " indicate we have a fast terminal connection. Improves smooth redrawing
set exrc                                                                        " search for .vimrc in current directory
set secure                                                                      " prevent unsafe operations from project .vimrc
                                                                                " load the version of matchit.vim that ships with Vim
packadd! matchit
                                                                                " key bindings - How to map Alt key? - Vi and Vim Stack Exchange - https://vi.stackexchange.com/questions/2350/how-to-map-alt-key
if &term =~ 'xterm' && !has("gui_running")
                                                                                " tell vim what escape sequence to expect for various keychords
                                                                                " this is needed for terminal Vim to regognize Meta and Shift modifiers
  execute "set <A-w>=\ew"
  execute "set <S-F2>=\e[1;2Q"
  execute "set <A-k>=\ek"
  execute "set <A-j>=\ej"
  execute "set <A-,>=\e,"
endif


" {{ Timeout settings }}
                                                                                " Eliminating ESC delays in vim - Metaserv - https://meta-serv.com/article/vim_delay
                                                                                " Delayed esc from insert mode caused by cursor-shape terminal sequence - Vi and Vim Stack Exchange - https://vi.stackexchange.com/questions/15633/delayed-esc-from-insert-mode-caused-by-cursor-shape-terminal-sequence
                                                                                " Wait forever until I recall mapping
                                                                                " Don't wait to much for keycodes send by terminal, so there's no delay on <ESC>
set notimeout
set ttimeout
set timeoutlen=2000
set ttimeoutlen=30


" {{ Plugs }}
                                                                                " check whether vim-plug is installed and install it if necessary
let plugpath = expand('<sfile>:p:h'). '/autoload/plug.vim'
if !filereadable(plugpath)
  if executable('curl')
    let plugurl = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    call system('curl -fLo ' . shellescape(plugpath) . ' --create-dirs ' . plugurl)
    if v:shell_error
      echom "Error downloading vim-plug. Please install it manually.\n"
      exit
    endif
  else
    echom "vim-plug not installed. Please install it manually or install curl.\n"
    exit
  endif
endif
call plug#begin('~/.config/nvim/bundle')
                                                                                " Terminal
Plug 'kassio/neoterm'
                                                                                " GIT
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'
Plug 'samoshkin/vim-mergetool'
                                                                                " Formatting
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
                                                                                " Search
Plug 'svermeulen/vim-subversive'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'dyng/ctrlsf.vim'
                                                                                " Interface
Plug 'sonph/onehalf', {'rtp': 'vim/'}
Plug 'morhetz/gruvbox'
Plug 'ap/vim-css-color'
                                                                                " Lint
Plug 'rhysd/vim-clang-format'
                                                                                " Languages
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'yuezk/vim-js'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'rhysd/vim-gfm-syntax'
" Plug 'jxnblk/vim-mdx-js'
" Plug 'justmao945/vim-clang'
                                                                                " Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
                                                                                " Intellisense
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
                                                                                " pluntuml
Plug 'aklt/plantuml-syntax'
Plug 'tyru/open-browser.vim'
Plug 'weirongxu/plantuml-previewer.vim'
                                                                                " debug
Plug 'critiqjo/lldb.nvim'
call plug#end()


" {{ Variables }}
                                                                                " &custom variables& {{{
let _resize_factor = 1.2                                                        " resize step
                                                                                " ignore directories
let g:search_ignore_dirs = [
  \ '.git',
  \ 'node_modules',
  \ 'coverage',
  \ 'package-lock.json'
  \] 
                                                                                " }}}
                                                                                " &Quickfix and Location list& {{{
                                                                                " automatically quit if qf/loc is the last window opened
let g:qf_auto_quit = 1
                                                                                " don't autoresize if number of items is less than 10
let g:qf_auto_resize = 0
                                                                                " automatically open qf/loc list after :grep, :make
let g:qf_auto_open_quickfix = 1
let g:qf_auto_open_loclist = 1
                                                                                " use qf/loc list local mappings to open match in split/tab/preview window
                                                                                " s - open entry in a new horizontal window
                                                                                " v - open entry in a new vertical window
                                                                                " t - open entry in a new tab
                                                                                " o - open entry and come back
                                                                                " O - open entry and close the location/quickfix window
                                                                                " p - open entry in a preview window
let g:qf_mapping_ack_style = 1
                                                                                " }}}
                                                                                " @gfm-syntax@ {{{
let g:markdown_fenced_languages = [
      \ 'sh',
      \ 'html',
      \ 'css',
      \ 'json',
      \ 'yaml',
      \ 'js=javascript'
      \]
                                                                                " }}}
                                                                                " @airline@ {{{
let g:airline_theme = 'onehalflight'
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#tab_min_count = 2
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#show_tab_nr = 0
                                                                                " }}}
                                                                                " @mergetool@ {{{
let g:mergetool_layout = 'mr'
let g:mergetool_prefer_revision = 'local'
                                                                                " }}}
                                                                                " @clang-formatter@ {{{
let g:clang_format#style_options = {
      \ "AccessModifierOffset" : -4,
      \ "AllowShortIfStatementsOnASingleLine" : "false",
      \ "AlwaysBreakTemplateDeclarations" : "true",
      \ "Standard" : "C++11",
      \ "BreakBeforeBraces" : "Stroustrup"
      \}
                                                                                " }}}
                                                                                " @ctrlsf@ {{{
let g:ctrlsf_auto_focus = { "at": "start" }
let g:ctrlsf_ignore_dir = g:search_ignore_dirs
let g:ctrlsf_regex_pattern = 1
let g:ctrlsf_case_sensitive = 'smart'
let g:ctrlsf_follow_symlinks = 1
let g:ctrlsf_selected_line_hl = 'po'
let g:ctrlsf_indent = 2
                                                                                " autoclose search pane in both normal and compact view
                                                                                " o, <CR>, open file and close search pane
                                                                                " O, open file and keep search pane
                                                                                " n/N, navigate thru results and immediately open a preview
let g:ctrlsf_auto_close = {
      \ "normal" : 1,
      \ "compact": 1
      \ }
let g:ctrlsf_mapping = {
      \ "open": ["<CR>", "o"],
      \ "openb": "O",
      \ "next": { "key": "n", "suffix": ":norm O<CR><C-w>p" },
      \ "prev": { "key": "N", "suffix": ":norm O<CR><C-w>p" },
      \ }
                                                                                " if ripgrep is available, use it
if executable('rg')
  let g:ctrlsf_ackprg = 'rg'
  let g:ctrlsf_extra_backend_args = {
        \ 'rg': '--hidden'
        \ }
endif
                                                                                " }}}
                                                                                " @lsp@ {{{
let g:lsp_signs_enabled = 1                                                     " enable signs
let g:lsp_diagnostics_echo_cursor = 1                                           " enable echo under cursor when in normal mode
let g:lsp_signs_error = {'text': '!'}                                           " change error sign
let g:lsp_signs_warning = {'text': '?'}                                         " change warning sign 
let g:lsp_signs_information = {'text': 'i'}                                     " change info sign
let g:lsp_highlight_references_enabled = 1                                      " highlight references to the symbol under the cursor
                                                                                " }}}
let g:vsnip_snippet_dir = ~/.config/nvim/snippets//                             " directory to store snippets 


" {{ Programms }}
                                                                                " echo warning message with highlighting enabled
function s:echo_warning(message)
  echohl WarningMsg
  echo a:message
  echohl None
endfunction
                                                                                " resolves variable value respecting window, buffer, global hierarchy
function s:get_var(...)
  let varName = a:1
  if exists('w:' . varName)
    return w:{varName}
  elseif exists('b:' . varName)
    return b:{varName}
  elseif exists('g:' . varName)
    return g:{varName}
  else
    return exists('a:2') ? a:2 : ''
  endif
endfunction
                                                                                " &move lines up/down& {{{
function! s:MoveBlockDown() range
  execute a:firstline "," a:lastline "move '>+1"
  normal! gv=gv
endfunction
"
function! s:MoveBlockUp() range
  execute a:firstline "," a:lastline "move '<-2"
  normal! gv=gv
endfunction
                                                                                " }}}
                                                                                " &blank line& {{{
                                                                                " insert blank line below and above without changing cursor
function! s:BlankUp(count) abort
  put!=repeat(nr2char(10), a:count)
  ']+1
  silent! call repeat#set("\<Plug>blankUp", a:count)
endfunction
"
function! s:BlankDown(count) abort
  put =repeat(nr2char(10), a:count)
  '[-1
  silent! call repeat#set("\<Plug>blankDown", a:count)
endfunction
                                                                                " }}}
                                                                                " &split line& {{{
function s:split_line()
                                                                                " do a split
  exe "normal! i\<CR>\<ESC>"
                                                                                " remember position and last search expression
  normal! mw
  let _s = @/
                                                                                " remove any trailing whitespace characters from the line above
  silent! -1 s/\v +$//
                                                                                " restore last search expression
  nohlsearch
  let @/ = _s
                                                                                " restore cursor position
  normal! `w
  startinsert
endfunction
                                                                                " }}}
                                                                                " &search highlight& {{{
                                                                                " detect when search command line is entered and left
                                                                                " detect when search is triggered by hooking into <CR>
                                                                                " inspired by https://github.com/google/vim-searchindex
augroup aug_search
  autocmd!
                                                                                " pitfall: Works only in vim8. CmdlineEnter and CmdlineLeave appeared in vim8
  autocmd CmdlineEnter /,\? call <SID>on_search_cmdline_focus(1)
  autocmd CmdlineLeave /,\? call <SID>on_search_cmdline_focus(0)
                                                                                " detect when search command window is entered
  autocmd CmdwinEnter *
        \ if getcmdwintype() =~ '[/?]' |
        \   silent! nmap <buffer> <CR> <CR><Plug>OnSearchCompleted|
        \ endif
augroup END
"
function! s:on_search_cmdline_focus(enter)
  if a:enter
                                                                                " turn on hlsearch to highlight all matches during incremental search
    set hlsearch
                                                                                " use <C-j> and <C-k> to navigate through matches during incremental search instead of <C-d>,<C-t>
    cmap <C-j> <C-g>
    cmap <C-k> <C-t>
                                                                                " detect when search is triggered by hooking into <CR>
    cmap <expr> <CR> "\<CR>" . (getcmdtype() =~ '[/?]' ? "<Plug>OnSearchCompleted" : "")
  else
                                                                                " on cmdline leave, rollback all changes and mappings
    set nohlsearch
    cunmap <C-j>
    cunmap <C-k>
    cunmap <CR>
  endif
endfunction
"
function s:OnSearchCompleted()
                                                                                " print total search matches count
  call s:PrintSearchTotalCount()
                                                                                " open folds in the matches lines
                                                                                " foldopen+=search causes search commands to open folds in the matched line
                                                                                " - but it doesn't work in mappings. Hence, we just open the folds here.
  if &foldopen =~# "search"
    normal! zv
  endif
                                                                                " recenter screen for any kind of search (same as we do for n/N shortcuts)
  normal! zz
endfunction
"
function s:PrintSearchTotalCount()
                                                                                " detect search direction
  let search_dir = v:searchforward ? '/' : '?'
                                                                                " remember cursor position
  let pos=getpos('.')
                                                                                " remember start and end marks of last change/yank
  let saved_marks = [ getpos("'["), getpos("']") ]
  try
                                                                                " execute "%s///gn" command to capture match count for the last search pattern
    let output = ''
    redir => output
    silent! keepjumps %s///gne
    redir END
                                                                                " extract only match count from string like "X matches on Y lines"
    let match_count = str2nr(matchstr(output, '\d\+'))
                                                                                " compose message like "X matches for /pattern"
    let msg = l:match_count . " matches for " . l:search_dir . @/
                                                                                " flush any delayed screen updates before printing "l:msg".
                                                                                " see ":h :echo-redraw".
    redraw | echo l:msg
  finally
                                                                                " restore [ and ] marks
    call setpos("'[", saved_marks[0])
    call setpos("']", saved_marks[1])
                                                                                " restore cursor position
    call setpos('.', pos)
  endtry
endfunction
                                                                                " }}}
                                                                                " &project wide search& {{{
                                                                                " without bang, search is relative to cwd, otherwise relative to current file
command -nargs=* -bang -complete=file Grep call <SID>execute_search("Grep", <q-args>, <bang>0)
command -nargs=* -bang -complete=file GrepSF call <SID>execute_search_ctrlsf(<q-args>, <bang>0)
                                                                                " execute search for particular command (Grep, GrepSF, GrepFzf)
function s:execute_search(command, args, is_relative)
  if empty(a:args)
    call s:echo_warning("Search text not specified")
    return
  endif
  let extra_args = []
  let using_ripgrep = &grepprg =~ '^rg'
                                                                                " set global mark to easily get back after we're done with a search
  normal mF
                                                                                " exclude well known ignore dirs
                                                                                " this is useful for GNU grep, that does not respect .gitignore
  let ignore_dirs = s:get_var('search_ignore_dirs')
  for l:dir in ignore_dirs
    if using_ripgrep
      call add(extra_args, '--glob ' . shellescape(printf("!%s/", l:dir)))
    else
      call add(extra_args, '--exclude-dir ' . shellescape(printf("%s", l:dir)))
    endif
  endfor
                                                                                " change cwd temporarily if search is relative to the current file
  if a:is_relative
    exe "cd " . expand("%:p:h")
  endif
                                                                                " execute :grep + grepprg search, show results in quickfix list
  if a:command ==# 'Grep'
                                                                                " perform search
    silent! exe "grep! " . join(extra_args) . " " . a:args
    redraw!
                                                                                " if matches are found, open quickfix list and focus first match
                                                                                " do not open with copen, because we have qf list automatically open on search
    if len(getqflist())
      cc
    else
      cclose
      call s:echo_warning("No match found")
    endif
  endif
                                                                                " execute search using fzf.vim + grep/ripgrep
  if a:command ==# 'GrepFzf'
                                                                                " run in fullscreen mode, with preview at the top
    call fzf#vim#grep(printf("%s %s --color=always %s", &grepprg, join(extra_args), a:args),
          \ 1,
          \ fzf#vim#with_preview('up:60%'),
          \ 1)
  endif
                                                                                " restore cwd back
  if a:is_relative
    exe "cd -"
  endif
endfunction
"
function s:execute_search_ctrlsf(args, is_relative)
  if empty(a:args)
    call s:echo_warning("Search text not specified")
    return
  endif
                                                                                " show CtrlSF search pane in new tab
  tab split
  let t:is_ctrlsf_tab = 1
                                                                                " change cwd, but do it window-local
                                                                                " do not restore cwd, because ctrlsf#Search is async
                                                                                " just close tab, when you're done with a search
  if a:is_relative
    exe "lcd " . expand("%:p:h")
  endif
                                                                                " create new scratch buffer
  enew
  setlocal bufhidden=delete nobuflisted
                                                                                " execute search
  call ctrlsf#Search(a:args)
endfunction
                                                                                " initiate search, prepare command using selected backend and context for the search
                                                                                " contexts are: word, selection, last search pattern
function s:prepare_search_command(context, backend)
  let text = a:context ==# 'word' ? expand("<cword>")
        \ : a:context ==# 'selection' ? s:get_selected_text()
        \ : a:context ==# 'search' ? @/
        \ : ''
                                                                                " properly escape search text
                                                                                " remove new lines (when several lines are visually selected)
  let text = substitute(text, "\n", "", "g")
                                                                                " escape backslashes
  let text = escape(text, '\')
                                                                                " put in double quotes
  let text = escape(text, '"')
  let text = empty(text) ? text : '"' . text . '"'
                                                                                " grep/ripgrep/ctrlsf args
                                                                                " always search literally, without regexp
                                                                                " use word boundaries when context is 'word'
  let args = [a:backend ==# 'GrepSF' ? '-L' : '-F']
  if a:context ==# 'word'
    call add(args, a:backend ==# 'GrepSF' ? '-W' : '-w')
  endif
                                                                                " compose ":GrepXX" command to put on a command line
  let search_command = ":\<C-u>" . a:backend
  let search_command .= empty(args) ? ' ' : ' ' . join(args, ' ') . ' '
  let search_command .= '-- ' . text
                                                                                " put actual command in a command line, but do not execute
                                                                                " user would initiate a search manually with <CR>
  call feedkeys(search_command, 'n')
endfunction
                                                                                " }}}
                                                                                " &search selection& {{{
function! s:search_from_context(direction, context)
  let text = a:context ==# 'word' ? expand("<cword>") : s:get_selected_text()
  let text = substitute(escape(text, a:direction . '\'), '\n', '\\n', 'g')
  let @/ = '\V' . text
  call feedkeys(a:direction . "\<C-R>=@/\<CR>\<CR>")
endfunction
                                                                                " get visually selected text
function! s:get_selected_text()
  try
    let regb = @z
    normal! gv"zy
    return @z
  finally
    let @z = regb
  endtry
endfunction
                                                                                " }}}
                                                                                " &find files& {{{
function s:findprg_compose_ignoredir_args(backend, ignore_dirs)
  if empty(a:ignore_dirs)
    return ""
  endif
  let args = []
  if a:backend ==# 'fd'
    for l:dir in a:ignore_dirs
      call add(args, '-E ' . shellescape(printf('%s/', l:dir)))
    endfor
    return join(args)
  else
    for l:dir in a:ignore_dirs
      call add(args, '-path ' . shellescape(printf('*/%s/*', l:dir)))
    endfor
    return "\\( " . join(args) . " \\) -prune -o"
  endif
endfunction
                                                                                " }}}
                                                                                " &Quickfix and Location list& {{{
augroup aug_quickfix_list
  au!
  autocmd QuickFixCmdPre [^l]* call s:qf_loc_on_enter('qf')
  autocmd QuickFixCmdPre    l* call s:qf_loc_on_enter('loc')
  autocmd FileType qf command! -nargs=0 ReloadList call <SID>qf_loc_reload_list(empty(getloclist(0)) ? 'qf' : 'loc')
augroup END
                                                                                " remember cursor position before running quickfix cmd
                                                                                " disable folding
function s:qf_loc_on_enter(list_type)
                                                                                " do nothing, when we're already in quickfix list
  if &filetype ==# 'qf'
    return
  endif
  exe "normal m" . (a:list_type ==# 'qf' ? 'Q' : 'L')
                                                                                " disable folding temporarily
  let curr_buffer = bufnr("%")
  bufdo set nofoldenable
  execute 'buffer ' . curr_buffer
endfunction
                                                                                " navigate thru lists, open closed folds, and recenter screen
function s:qf_loc_list_navigate(command)
  try
    exe a:command
  catch /E553/
    echohl WarningMsg
    echo "No more items in a list"
    echohl None
    return
  endtry
  if &foldopen =~ 'quickfix' && foldclosed(line('.')) != -1
    normal! zv
  endif
  normal zz
endfunction
                                                                                " close quickfix or location list if opened
                                                                                " and get back to cursor position before quickfix command was executed
function s:qf_loc_quit(list_type)
                                                                                " First, remove focus from quickfix list
  if &filetype ==# 'qf'
    wincmd p
  endif
                                                                                " restore folding back
  bufdo set foldenable
  if a:list_type ==# 'qf'
    if qf#IsQfWindowOpen()
      call qf#toggle#ToggleQfWindow(0)
    endif
    normal `Q
  else
    if qf#IsLocWindowOpen(0)
      call qf#toggle#ToggleLocWindow(0)
    endif
    normal `L
  endif
endfunction
                                                                                " reloads quickfix list to pull changes after 'Search&replace' scenario
function s:qf_loc_reload_list(list_type)
  if a:list_type ==# 'qf'
    call setqflist(map(getqflist(), 'extend(v:val, {"text":get(getbufline(v:val.bufnr, v:val.lnum),0)})'), 'r')
    cfirst
  else
    call setloclist(0, map(getloclist(), 'extend(v:val, {"text":get(getbufline(v:val.bufnr, v:val.lnum),0)})'), 'r')
    lfirst
  endif
endfunction
                                                                                " navigate to older/newer qf/loc list
function s:qf_loc_history_navigate(command)
  try
    exe a:command
    cfirst
  catch /E\(380\|381\)/
    echohl WarningMsg
    echo "Reached end of the history"
    echohl None
  endtry
endfunction
                                                                                " }}}
                                                                                " @FzF@ {{{
                                                                                " use preview when FzfFiles runs in fullscreen
command! -nargs=? -bang -complete=dir FzfFiles
      \ call fzf#vim#files(<q-args>, <bang>0 ? fzf#vim#with_preview('up:60%') : {}, <bang>0)
                                                                                " }}}
                                                                                " @Commentary@ {{{
autocmd FileType javascript.jsx setlocal commentstring={/*\ %s\ */}
autocmd FileType c,cpp,cs,java setlocal commentstring=//\ %s
                                                                                " }}}
                                                                                " @clang-formatter@ {{{
                                                                                " use google formatting
autocmd FileType c,cpp,cs ClangFormatAutoEnable
                                                                                " }}}
                                                                                " @plantuml@ {{{
au FileType plantuml let g:plantuml_previewer#plantuml_jar_path = get(
      \  matchlist(system('cat `which plantuml` | grep plantuml.jar'), '\v.*\s[''"]?(\S+plantuml\.jar).*'),
      \  1,
      \  0
      \)
                                                                                " }}}


" {{ Maps-Remaps }}
                                                                                " remap command mode invocation
map ; :
                                                                                " make the tab key match bracket pairs
nnoremap <tab> %
vnoremap <tab> %
                                                                                " shortcuts for substitute as ex command
nnoremap <S-s> :%s/
vnoremap <C-s> :s/
                                                                                " disable the arrow keys
nnoremap <up> <nop>
nnoremap <down> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
                                                                                " Additional <ESC> mappings:
                                                                                " jj, in INSERT mode
                                                                                " <C-c>, after shell environment
inoremap jj <ESC>
noremap <C-C> <ESC>
xnoremap <C-C> <ESC>
                                                                                " c++ compiling and running programs from Vim
map <F10> :!g++ % && ./a.out <CR>
                                                                                " !lines! ====
                                                                                " join lines and keep the cursor in place
nnoremap J mzJ`z
                                                                                " &split line& {{{
nnoremap <silent> M :call <SID>split_line()<CR>
                                                                                " }}}
                                                                                " &move lines up/down& {{{
nnoremap <silent> <A-j> :m .+1<CR>==
nnoremap <silent> <A-k> :m .-2<CR>==
inoremap <silent> <A-j> <Esc>:m .+1<CR>==gi
inoremap <silent> <A-k> <Esc>:m .-2<CR>==gi
vnoremap <silent> <A-j> :call <SID>MoveBlockDown()<CR>
vnoremap <silent> <A-k> :call <SID>MoveBlockUp()<CR>
                                                                                " }}}
                                                                                " &blank line& {{{
                                                                                " add blank line above and below
nnoremap <silent> <Plug>blankUp   :<C-U>call <SID>BlankUp(v:count1)<CR>
nnoremap <silent> <Plug>blankDown :<C-U>call <SID>BlankDown(v:count1)<CR>
                                                                                " do not override <CR> in quickfix and command line window
nnoremap <expr> <CR> &buftype ==# 'quickfix' \|\| getcmdwintype() != '' ? "\<CR>" : "o\<ESC>"
                                                                                " }}}
                                                                                "
                                                                                " !tabs! ====
                                                                                " use built-in gt/gT to traverse between tabs
nnoremap <silent> <left> :tabprev<CR>
nnoremap <silent> <right> :tabnext<CR>
                                                                                "
                                                                                " !panes! ====
                                                                                " easy pane navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
                                                                                " resize panes greather than just 1 column at a time
nnoremap <C-w><left> :exe "vert resize " . float2nr(round(winwidth(0) * _resize_factor))<CR>
nnoremap <C-w><right> :exe "vert resize " . float2nr(round(winwidth(0) * 1/_resize_factor))<CR>
nnoremap <C-w><up> :exe "resize " . float2nr(round(winheight(0) * _resize_factor))<CR>
nnoremap <C-w><down> :exe "resize " . float2nr(round(winheight(0) * 1/_resize_factor))<CR>
                                                                                "
                                                                                " !search! ====
                                                                                " center search results
nnoremap n nzvzz
nnoremap N Nzvzz
nnoremap * *zvzz
nnoremap # #zvzz
                                                                                " &search highlight& {{{
                                                                                " define OnSearchCompleted hook
noremap  <Plug>OnSearchCompleted <Nop>
nnoremap <silent> <Plug>OnSearchCompleted :call <SID>OnSearchCompleted()<CR>
                                                                                " }}}
                                                                                " &search selection& {{{
                                                                                " make '*' and '#' search for a selection in visual mode
vnoremap * :<C-u>call <SID>search_from_context("/", "selection")<CR>
vnoremap # :<C-u>call <SID>search_from_context("?", "selection")<CR>
                                                                                " }}}
                                                                                " &project wide search& {{{
                                                                                " :grep + grepprg + quickfix list
nnoremap <F7><F7> :call <SID>prepare_search_command("", "Grep")<CR>
nnoremap <F7>w :call <SID>prepare_search_command("word", "Grep")<CR>
nnoremap <F7>s :call <SID>prepare_search_command("selection", "Grep")<CR>
nnoremap <F7>/ :call <SID>prepare_search_command("search", "Grep")<CR>
vnoremap <silent> <F7> :call <SID>prepare_search_command("selection", "Grep")<CR>
                                                                                " ctrlsf.vim (uses ack, ag or rg under the hood)
nnoremap <F8><F8> :call <SID>prepare_search_command("", "GrepSF")<CR>
nnoremap <F8>w :call <SID>prepare_search_command("word", "GrepSF")<CR>
nnoremap <F8>s :call <SID>prepare_search_command("selection", "GrepSF")<CR>
nnoremap <F8>/ :call <SID>prepare_search_command("search", "GrepSF")<CR>
vnoremap <silent> <F8> :call <SID>prepare_search_command("selection", "GrepSF")<CR>
                                                                                " }}}
                                                                                "
                                                                                " !navigation! ====
                                                                                " when navigating to the EOF, center the screen
nnoremap G Gzz
                                                                                " use 'H' and 'L' keys to move to start/end of the line
noremap H g^
noremap L g$
                                                                                " recenter when jump back
nnoremap <C-o> <C-o>zz
                                                                                " z+, moves next line below the window
                                                                                " z-, moves next line above the window
nnoremap z- z^
                                                                                " center screen after navigation shortcuts
nnoremap } }zvzz
nnoremap { {zvzz
nnoremap ]] ]]zvzz
nnoremap [[ [[zvzz
nnoremap [] []zvzz
nnoremap ][ ][zvzz
                                                                                " drop into insert mode on Backspace
nnoremap <BS> i<BS>
                                                                                "
                                                                                " &Quickfix and Location list& {{{
                                                                                " <f5> for quickfix list
nmap <F5> <Plug>(qf_qf_toggle)
nmap <S-F5> <Plug>(qf_qf_switch)
nnoremap <silent> <leader><F5> :call <SID>qf_loc_quit('qf')<CR>
nnoremap <silent> [<F5> :call <SID>qf_loc_history_navigate('colder')<CR>
nnoremap <silent> ]<F5> :call <SID>qf_loc_history_navigate('cnewer')<CR>
                                                                                " <F6> for location list
nmap <F6> <Plug>(qf_loc_toggle)
nmap <S-F6> <Plug>(qf_loc_switch)
nmap <silent> <leader><F6> :call <SID>qf_loc_quit('loc')<CR>
nnoremap <silent> [<F6> :call <SID>qf_loc_history_navigate('lolder')<CR>
nnoremap <silent> ]<F6> :call <SID>qf_loc_history_navigate('lnewer')<CR>
                                                                                " Quickfix list
nnoremap <silent> ]q :<C-u>call <SID>qf_loc_list_navigate("cnext")<CR>
nnoremap <silent> [q :<C-u>call <SID>qf_loc_list_navigate("cprev")<CR>
nnoremap <silent> ]Q :<C-u>call <SID>qf_loc_list_navigate("clast")<CR>
nnoremap <silent> [Q :<C-u>call <SID>qf_loc_list_navigate("cfirst")<CR>
nnoremap <silent> ]<C-q> :<C-u>call <SID>qf_loc_list_navigate("cnfile")<CR>
nnoremap <silent> [<C-q> :<C-u>call <SID>qf_loc_list_navigate("cpfile")<CR>
                                                                                " Location list
nnoremap <silent> ]e :<C-u>call <SID>qf_loc_list_navigate("lnext")<CR>
nnoremap <silent> [e :<C-u>call <SID>qf_loc_list_navigate("lprev")<CR>
nnoremap <silent> ]E :<C-u>call <SID>qf_loc_list_navigate("llast")<CR>
nnoremap <silent> [E :<C-u>call <SID>qf_loc_list_navigate("lfirst")<CR>
nnoremap <silent> ]<C-e> :<C-u>call <SID>qf_loc_list_navigate("lnfile")<CR>
nnoremap <silent> [<C-e> :<C-u>call <SID>qf_loc_list_navigate("lpfile")<CR>
                                                                                " }}}
                                                                                " @FzF@ {{{
                                                                                " file path completion in Insert mode using fzf
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-l> <plug>(fzf-complete-buffer-line)
                                                                                " }}}


" {{ Map leader commands }}
                                                                                " map leader to space
nnoremap <Space> <Nop>
let mapleader=" "
let maplocalleader=","
                                                                                " trim all whitespaces at the end of the line
nnoremap <leader>T :%s/\s\+$//<cr>:let @/=''<CR>
                                                                                " reselect the text that was just pasted
nnoremap <leader>v V`]
                                                                                " quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>
                                                                                " !lines! ====
                                                                                " &blank line& {{{
                                                                                " add blank line above and below
nmap <leader><CR> <Plug>blankUp
                                                                                " }}}
                                                                                " duplicate lines or selection
vnoremap <silent> <localleader>d "zy`>"zp
nnoremap <silent> <localleader>d :<C-u>execute 'normal! "zyy' . v:count1 . '"zp'<CR>
                                                                                "
                                                                                " !tabs! ====
                                                                                " tab navigation
nnoremap <silent> <leader>1 :tabnext 1<CR>
nnoremap <silent> <leader>2 :tabnext 2<CR>
nnoremap <silent> <leader>3 :tabnext 3<CR>
nnoremap <silent> <leader>4 :tabnext 4<CR>
nnoremap <silent> <leader>5 :tabnext 5<CR>
nnoremap <silent> <leader>9 :tablast<CR>
                                                                                " tab management
nnoremap <silent> <leader>+ :tabnew<CR>:edit .<CR>
nnoremap <silent> <leader>) :tabonly<CR>
nnoremap <silent> <leader>- :tabclose<CR>
                                                                                " close all buffers but this one
nnoremap <silent> <leader>q :%bd\|e#<CR>
                                                                                "
                                                                                " !panes! ====
                                                                                " open a new vertical split and switch over to it
nnoremap <leader>w <C-w>v<C-w>l
                                                                                " open a new horizontal split and switch over to it
nnoremap <leader>h <C-w>s<C-w>j
                                                                                "
                                                                                " !search! ====
                                                                                " Toggle search highlighting
nnoremap <silent> <leader>n :set hlsearch!<cr>
                                                                                "
                                                                                " !search! ====
                                                                                " move up and down in autocomplete with <c-j> and <c-k>
inoremap <expr> <C-j> ("\<C-n>")
inoremap <expr> <C-k> ("\<C-p>")
                                                                                "
                                                                                " @FzF@ {{{
                                                                                " toggle FZF in current directory
nnoremap <silent> <leader>o :FZF<CR>
                                                                                " toggle FZF in current directory (full screen mode)
nnoremap <silent> <leader>O :FZF!<CR>
                                                                                " toggle FZF in system root directory
nnoremap <silent> <leader>` :FZF ~<CR>
                                                                                " }}}
                                                                                " @mergetool@ {{{
nmap <leader>mt <plug>(MergetoolToggle)
                                                                                " }}}
                                                                                " @Commentary@ {{{
                                                                                " comment line and move 1 line down
nmap <silent> <leader>c <Plug>CommentaryLine :normal j<CR>
xmap <leader>c <Plug>Commentary
                                                                                " }}}
                                                                                " @clang-formatter@ {{{
autocmd FileType c,cpp,objc nnoremap <buffer><Leader>f :<C-u>ClangFormat<CR>
autocmd FileType c,cpp,objc vnoremap <buffer><Leader>f :ClangFormat<CR>
                                                                                " }}}
                                                                                " @neoterm@ {{{
                                                                                " clear neoterm
nnoremap <leader>tl :<c-u>exec v:count.'Tclear'<cr>
                                                                                " }}}


" {{ Indent }}
set tabstop=2                                                                   " a tab is four spaces
set softtabstop=2                                                               " make all identation same
set shiftwidth=2                                                                " number of spaces to use for autoindenting
set shiftround                                                                  " when shifting lines, round the indentation to the nearest multiple of “shiftwidth
set expandtab                                                                   " convert tabs to spaces
set smarttab                                                                    " insert “tabstop” number of spaces when the “tab” key is pressed
set autoindent                                                                  " always set autoindenting on
set copyindent                                                                  " copy the previous indentation on autoindenting


" {{ Vim behavior }}
set hidden                                                                      " do not warn abount unsaved changes when navigating to another buffer
set noshowmode                                                                  " do not use default status line
set backspace=indent,eol,start                                                  " allow backspacing over everything in insert mode (all OS)
set nobackup                                                                    " disable backup files
set swapfile                                                                    " keep persistent undo history that survives Vim process lifetime
set autoread                                                                    " automatically read files which are changed outside vim
set undofile                                                                    " save undotree to a file
set undodir=~/.vim/tmp/undo//                                                   " directore to store undo files
set backupdir=~/.vim/tmp/backup//                                               " directory to store backup files
set directory=~/.vim/tmp/swap//                                                 " directory to store swap files
                                                                                " make those folders automatically if they don't already exist.
if !isdirectory(expand(&undodir))
  call mkdir(expand(&undodir), "p")
endif
if !isdirectory(expand(&backupdir))
  call mkdir(expand(&backupdir), "p")
endif
if !isdirectory(expand(&directory))
  call mkdir(expand(&directory), "p")
endif
set history=1000                                                                " increase the undo limit
set updatetime=300                                                              " shorten updatetime
set synmaxcol=200                                                               " don't try to highlight lines longer than N characters
setlocal spell spelllang=en_us                                                  " check spell
set completeopt=menu,preview,noinsert                                           " do not insert first sugggestion
                                                                                " tweak autocompletion behavior for <C-n>/<C-p> in insert mode
                                                                                " default is ".,w,b,u,t,i" without "i", where:
                                                                                " . - scan current buffer. Same to invoking <C-x><C-n> individually
                                                                                " w - buffers in other windows
                                                                                " b - loaded buffers in buffer list
                                                                                " u - unloaded buffers in buffer list
                                                                                " t - tags. Same to invoking <C-x><C-]> individually
                                                                                " i - included files. We don't need this.
                                                                                " kspell, when spell check is active, use words from spellfiles
set complete-=i
set complete+=kspell
                                                                                " choose grep backend, use ripgrep if available
if executable("rg")
  set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case\ --hidden\ --follow
  set grepformat=%f:%l:%c:%m
else
  set grepprg=grep\ -n\ --with-filename\ -I\ -R
  set grepformat=%f:%l:%m
endif
                                                                                " choose find backend, use fd if available
if executable('fd')
  let g:find_files_findprg = printf("fd --hidden %s $* $d", s:findprg_compose_ignoredir_args("fd", g:search_ignore_dirs))
else
  let g:find_files_findprg = printf("find $d %s ! -type d $* -print", s:findprg_compose_ignoredir_args("find", g:search_ignore_dirs))
endif


" {{ Interface }}
syntax on                                                                       " enable highlighting
                                                                                " true colors
set t_Co=256
set background=light                                                            " use light background
colorscheme onehalflight                                                        " use theme
set number                                                                      " always show line numbers
set cursorline                                                                  " highlight the line with a cursor"
                                                                                " disable cursor line highlighting in Insert mode
augroup aug_cursor_line
  au!
  au InsertEnter * setlocal nocursorline
  au InsertLeave * setlocal cursorline
augroup END
set showcmd                                                                     " display uncompleted keystrokes in the status line
set wildmenu                                                                    " show possible matches above the command line on completion
set wildmode=list:longest,full                                                  " (on the first tab) complete to the longest common command; (on second tab) show all the completions that were listed before
set ruler                                                                       " show the line and column number of the cursor position
set laststatus=2                                                                " show status line always
set cmdheight=2                                                                 " give more space for displaying messages
set signcolumn=yes                                                              " always show sign column to prevent text shiftingG80
set display=lastline                                                            " add @@@ marks on the last column of last line if there is more text below


" {{ Formatting }}
set nowrap                                                                      " don't wrap lines
set encoding=utf-8 nobomb
set fileencoding=utf-8
scriptencoding utf-8
set colorcolumn=81                                                              " restrict line length
                                                                                " format options
                                                                                " remove most related to hard wrapping
                                                                                " use autocommand to override defaults from $VIMRUNTIME/ftplugin
augroup aug_format_options
  au!
                                                                                " t - automatic text wrapping, but not comments (for hard wrapping)
                                                                                " c - auto wrap comments (for hard wrapping)
                                                                                " a - reformat on any change
                                                                                " q - allow formatting of comments with "gq"
                                                                                " r - insert comment leader after hitting <CR> in Insert mode
                                                                                " n - When formatting text, recognize numbered lists and use the indent after the number for the next line
                                                                                " 2 - Use indent of the second line of a paragraph for the reset of the paragraph
                                                                                " 1 - Don't break line after a one-letter word, it's broken before it.
                                                                                " j - Remove a comment leader when joining lines
                                                                                " o - automatically insert comment leader after hitting 'o' or 'O' in normal mode
  au Filetype * setlocal formatoptions=rqn1j
augroup END


" {{ Search }}
set nohlsearch                                                                  " disable search highlighting
                                                                                " highlight both search and incremental search identically
hi! link Search IncSearch
set ignorecase                                                                  " ignore case when searching
set wrapscan                                                                    " start over when reaching last match
set incsearch                                                                   " incremental search that shows partial matches
set smartcase                                                                   " automatically switch search to case-sensitive when search query contains an uppercase letter
set gdefault                                                                    " apply substitutions globally on lines

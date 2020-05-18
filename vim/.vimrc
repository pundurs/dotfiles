set nocompatible    " be iMproved, required

" Tab settings, 4 spaces
set expandtab
set shiftwidth=4
set softtabstop=4

" Undo, cache and backup directories.
" Directories have to exist.
set undodir=~/.vim/undo-dir
set undofile
set backupdir=~/.vim/backups
set dir=~/.vim/swap

set noshowmode    " mode already shown in Lightline.
set ignorecase    " ignore case in searches.
set nohlsearch    " don't highlight search results.
set rnu nu        " hybrid line number mode
set cul           " highlight current line
set nojoinspaces  " Prevents inserting two spaces after punctuation on a join (J)
set splitbelow    " Horizontal split below current.
set splitright    " Vertical split to right of current.

set fileformats=unix,dos  " Windows bad.

syntax enable
filetype off                  " required

" PLUGINS =======================================================
" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')

" When adding a plugin,
" run ':source %' and ':PlugInstall'
" To update:
" :PlugUpdate
" And to remove unused:
" :PlugClean

" Tim Pope goodies
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'

" IntelliSense for vim
" Install extensions for better performance with ":CocInstall"
"
" Extensions used:
"     * coc-tsserver - js/ts
"     * coc-deno - run CocCommand "deno.cache" to download dependencies.
"     * coc-eslint
"     * coc-vetur - vue
"     * coc-python - remember to disable Jedi via Coc config.
"     * coc-json
"     * coc-css - also supports less and scss
"     * coc-rls - rust language server.
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Syntax highlight
Plug 'posva/vim-vue'
Plug 'pangloss/vim-javascript'
Plug 'MaxMEllon/vim-jsx-pretty'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'jparise/vim-graphql'
Plug 'cespare/vim-toml'

" Navigation
Plug 'kien/ctrlp.vim' "Ctrl+P File finder. Consider replacing with fzf.
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin' " Git status indicators for nerdtree
Plug 'jremmen/vim-ripgrep' " Search

" Visual
Plug 'itchyny/lightline.vim'
Plug 'kjssad/quantum.vim'

" Utility
Plug 'terryma/vim-multiple-cursors' " Sublime text-like multiple cursors
Plug 'scrooloose/nerdcommenter' " Toggle comments
Plug 'editorconfig/editorconfig-vim'

" VimWiki
Plug 'vimwiki/vimwiki'

" All of your Plugins must be added before the following line
call plug#end()              " required
filetype plugin indent on    " required

" Add LESS filetype which doesn't work for me for some reason.
au BufRead,BufNewFile *.less		setfiletype less

" KEYMAPS =======================================================
" Toogle NERD tree
" <silent> is a map modifier, which won't show the actual input.
nmap <silent><F3> :NERDTreeToggle<Cr>

" shift+tab for inverse tabbing
nmap <S-Tab> <<
imap <S-Tab> <Esc><<i

" Go to alternate (previous) file with CTRL+Backspace
" useful with peeking a file with "gf" and then going back.
nmap <C-BS> <C-^>

" <Leader> - backslash by default
" remove trailing spaces in the current buffer
nmap <Leader>t :%s/\s\+$//<Cr>

" Rust stuff
nmap <Leader>b :!cargo build<Cr>
nmap <Leader>bb :!cargo test<Cr>
nmap <Leader>bt :!cargo test <C-R><C-W><Cr> " Runs test under cursor
nmap <Leader>br :!cargo run<Cr>
nmap <Leader>bc :!cargo clippy<Cr>
nmap <Leader>bf :!cargo fmt<Cr>

" Search word under cursor with ripgrep
nmap <Leader>f :Rg<Cr>

" Copy to clipboard
vnoremap <leader>y  "+y
nnoremap <leader>Y  "+yg_
nnoremap <leader>y  "+y
nnoremap <leader>yy  "+yy

" Paste from clipboard
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P

" Misc
imap jj <ESC>
imap <C-/> <ESC><plug>NERDCommenterToggle
vmap <C-/> <plug>NERDCommenterToggle
nmap <C-/> <plug>NERDCommenterToggle
tnoremap <Esc><Esc> <C-\><C-n> " Exit terminal mode when developer panics

" Search for selected text
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>

" CONFIG =======================================================
" Enable 256 color support and load colorscheme
set t_Co=256
let g:rehash256 = 1

" Enable TrueColor
set termguicolors

" Remove toolbars and scrollbars.
set guifont=Hasklig:h18  " unused in nvim-qt, use ginit.vim (see below)
set guioptions-=m        " menu bar
set guioptions-=T        " toolbar
set guioptions-=r        " scrollbar

""" NVIM-QT NOTES """
" To remove the QT toolbar on windows for nvim-qt, go to the registry:
" Computer\HKEY_CURRENT_USER\Software\nvim-qt\nvim-qt
" and set "ext_tabline" to "false"
"
" source: https://github.com/equalsraf/neovim-qt/issues/589
"
" Sample ginit.vim
" if exists('g:GuiLoaded')
"    GuiFont! hasklig:h12
"    GuiLinespace 4
" endif

" Set Lightline colorscheme.
" Call before setting editor scheme.
let g:lightline = {
      \ 'colorscheme': 'darcula',
      \ }

" Set theme and background depending of time of day
let hour = strftime("%H")
if 6 <= hour && hour < 14
    colorscheme gruvbox
    set background=dark
else
    colorscheme gruvbox
    set background=dark
endif

" Surround options (decimals equal to ASCII codes and '\r' is the text to be
" surrounded)
let g:surround_40 = "(\r)"
let g:surround_91= "[\r]"

" Vimwiki settings - path and set to markdown mode.
let g:vimwiki_list = [{'path': '~/vimwiki/', 'syntax': 'markdown', 'ext': '.md'}]

" CtrlP
" Based Tim Pope.
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](.yarn|.nuxt|.vscode|node_modules|target)',
  \ 'file': '\v\.(exe|so|dll)$',
  \ }

" Remove trailing spaces before save
autocmd BufWritePre * %s/\s\+$//e

" BEGIN COC.VIM CONFIG =======================================================
" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <F2> <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
" Commented out, because I am too used to paging down.
" nmap <silent> <C-d> <Plug>(coc-range-select)
" xmap <silent> <C-d> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
" ===== END COC.VIM CONFIG =====

" Rename tabs to show tab number and show loaded files in tooltips.
" (Based on http://stackoverflow.com/questions/5927952/whats-implementation-of-vims-default-tabline-function)
set showtabline=2 " always show tabs in gvim, but not vim
" set up tab labels with tab number, buffer name, number of windows
function! GuiTabLabel()
    let label = ''
    let bufnrlist = tabpagebuflist(v:lnum)
    " Add '+' if one of the buffers in the tab page is modified
    for bufnr in bufnrlist
        if getbufvar(bufnr, "&modified")
            let label = '+'
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
        " get only the file name
        let name = fnamemodify(name,":t")
    endif
    let label .= name
    " Append the number of windows in the tab page
    let wincount = tabpagewinnr(v:lnum, '$')
    return label . '  [' . wincount . ']'
endfunction
set guitablabel=%{GuiTabLabel()}
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

"This handles plugins to install
source ~/.vim/plug.vim

"julien's minimum stuff
""syntax off
set syntax=on
filetype plugin indent on
"set omnifunc=syntaxcomplete#Complete
let mapleader = "\<Space>"
set nocp nu hid ssl sm wmnu noerrorbells visualbell t_vb="" ch=2 ls=0 so=2 wim=longest,list,full mouse=a mousemodel=extend
set autoread
set noautochdir
set clipboard=unnamed
"runtime macros/matchit.vim
" let g:netrw_cursorline=0
let g:netrw_liststyle=3

"svelte
"au! BufRead,BufNewFile *.svelte set filetype=html
" CTRL+w saves file
nnoremap <C-w> :update<cr>
inoremap <C-w> <Esc>:update<cr>
" Touchbar hack
noremap § <ESC>
inoremap § <ESC>
" Next center
nnoremap n nzz
nnoremap N Nzz
" Folding
set foldmethod=indent
set nofoldenable
" https://www.sitepoint.com/getting-started-vim/
set encoding=utf-8
set showcmd                     " display incomplete commands
" Whitespace
set list
set listchars=""                      " reset
set listchars=tab:→\ 
set listchars+=trail:·
set nowrap                      " don't wrap lines
set tabstop=2 shiftwidth=2 expandtab     " a tab is two spaces (or set this to 4)
set backspace=indent,eol,start  " backspace through everything in insert mode
set autoindent
set smartindent
let g:html_indent_inctags = "html,body,head,tbody,svg,g,defs,path,rect"
set noshiftround
"split behaviour
set splitbelow
set splitright
"" Searching
set hlsearch                    " highlight matches
set incsearch                   " incremental searching
set ignorecase                  " searches are case insensitive...
set smartcase                   " ... unless they contain at least one capital letter
" clear searched text on enter
nnoremap <silent> <CR> :noh<CR><CR>
set t_Co=256
set background=dark
colorscheme hybrid 

"linting 
let g:airline#extensions#ale#enabled = 1
let g:ale_linter_aliases = {'svelte': ['css', 'javascript']}
let g:ale_linters = {
      \  'html':[], 
      \  'javascript': ['eslint'],
      \  'svelte': ['stylelint', 'eslint'],
      \  'javascript.jsx': ['eslint'],
      \  'xml': ['plugin-xml'],
      \}
let g:ale_fixers = {}
let g:ale_fixers['javascript'] = ['prettier'] 
let g:ale_fixers['javascript.jsx'] = ['prettier'] 
let g:ale_fixers['javascriptreact'] = ['prettier'] 
let g:ale_fixers['html'] = ['prettier'] 
let g:ale_fixers['svg'] = ['prettier'] 
let g:ale_fixers['css'] = ['prettier'] 
let g:ale_fixers['xml'] = ['prettier'] 
let g:ale_fixers['svelte'] = ['prettier'] 
let g:ale_fix_on_save = 1
let g:ale_javascript_prettier_use_local_config = 1
" Console log from insert mode; Puts focus inside parentheses
inoremap cll console.log()<Esc>==f(a
"vimrc helpers
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
"split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
"pretty print json
nnoremap <leader>j :%!python -m json.tool<cr>
"search files
nnoremap <leader>p :Files<cr>
nnoremap <leader>f :Find 
"move lines ALT-j and ALT-k"
nnoremap ∆ :m .+1<CR>==
nnoremap ˚ :m .-2<CR>==
inoremap ∆ <Esc>:m .+1<CR>==gi
inoremap ˚ <Esc>:m .-2<CR>==gi
vnoremap ∆ :m '>+1<CR>gv=gv 
vnoremap ˚ :m '<-2<CR>gv=gv 
"autoclose html tags 
inoremap ><Tab> ><Esc>F<lyt>o</<C-r>"><Esc>O<Space>
""inoremap ><Tab> ><Esc>?<[a-z]<CR>lyiwo</<C-r>"><Esc>:noh<CR><Esc>O
"autoclose html tags INLINE
inoremap >> ><Esc>F<lyt>f>a</<C-r>"><Esc>F<i
""inoremap >> ><Esc>?<[a-z]<CR>lyiwh/[^%]><CR>la</<C-r>"><Esc>:noh<CR><Esc>F<i
" --column: Show column number
" --line-number: Show line number
" --no-heading: Do not show file headings in results
" --fixed-strings: Search term as a literal string
" --ignore-case: Case insensitive search
" --no-ignore: Do not respect .gitignore, etc...
" --hidden: Search hidden files and folders
" --follow: Follow symlinks
" --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
" --color: Search color options
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)

" Remove trailing whitespace from .js files"
function! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun
autocmd BufWritePre *.js* :call <SID>StripTrailingWhitespaces()
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" Automatically create dir if missing when saving file
augroup vimrc-auto-mkdir
  autocmd!
  autocmd BufWritePre * call s:auto_mkdir(expand('<afile>:p:h'), v:cmdbang)
  function! s:auto_mkdir(dir, force)
    if !isdirectory(a:dir)
          \   && (a:force
          \       || input("'" . a:dir . "' does not exist. Create? [y/N]") =~? '^y\%[es]$')
      call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
    endif
  endfunction
augroup END

""Execute js file
nnoremap <leader><leader> :w !node <cr>

" COC settings
" source ~/.vim/coc.vim

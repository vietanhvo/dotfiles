call plug#begin('~/.vim/plugged')
  Plug 'sainnhe/gruvbox-material'
  Plug 'preservim/nerdtree' |
            \ Plug 'Xuyuanp/nerdtree-git-plugin' |
            \ Plug 'ryanoasis/vim-devicons'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'vim-airline/vim-airline'
  " Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'williamboman/mason-lspconfig.nvim'
  Plug 'williamboman/mason.nvim'
  Plug 'neovim/nvim-lspconfig'
  Plug 'hrsh7th/nvim-cmp'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'saadparwaiz1/cmp_luasnip'
  Plug 'L3MON4D3/LuaSnip'
  Plug 'glepnir/dashboard-nvim'
  Plug 'kyazdani42/nvim-web-devicons'
  Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'nvim-telescope/telescope-file-browser.nvim'
  Plug 'tpope/vim-commentary' 
  Plug 'easymotion/vim-easymotion'
  Plug 'airblade/vim-gitgutter'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-surround'
  Plug 'terryma/vim-multiple-cursors'
  Plug 'ervandew/supertab'
  Plug 'norcalli/nvim-colorizer.lua'
  Plug 'lukas-reineke/indent-blankline.nvim'
  Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
  Plug 'honza/vim-snippets'
  Plug 'akinsho/toggleterm.nvim'
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'p00f/nvim-ts-rainbow'
  Plug 'windwp/nvim-ts-autotag'
  Plug 'windwp/nvim-autopairs'
  Plug 'JoosepAlviste/nvim-ts-context-commentstring'
  Plug 'rust-lang/rust.vim'
  Plug 'turbio/bracey.vim', {'do': 'npm install --prefix server'}
  Plug 'RRethy/vim-illuminate'
  Plug 'github/copilot.vim'
  Plug 'rcarriga/nvim-notify'
  Plug 'karb94/neoscroll.nvim'
  Plug 'diepm/vim-rest-console'
  Plug 'm-demare/hlargs.nvim'
call plug#end()

" let g:coc_node_path='/home/vietvo/.nvm/versions/node/v16.13.2/bin/node'
let g:python3_host_prog='/usr/bin/python3'

" ColorScheme
syntax enable
autocmd ColorScheme * highlight! link SignColumn LineNr
if has('termguicolors')
    set termguicolors
endif
" For dark version.
set background=dark
let g:gruvbox_material_background = 'hard'
let g:gruvbox_material_enable_italic = 1
let g:gruvbox_material_enable_bold = 1
let g:gruvbox_material_sign_column_background = 'none'
let g:gruvbox_material_palette = 'original'
colorscheme gruvbox-material

" General Setup
let mapleader = " "
set backspace=2
set nobackup
set nowritebackup
set noswapfile
set history=50
set ruler
set showcmd
set incsearch
set laststatus=2  " Always display the status line
set autowrite     " Automatically :write before running commands
set autoread
set textwidth=80

set autoindent
set smartindent

" Softtabs, 2 spaces
set tabstop=4
set shiftwidth=4
set shiftround
set expandtab

" Numbers ruler
set relativenumber
set number
set numberwidth=5
hi CursorLineNr guifg=Yellow guibg=none
set cursorline

" Use one space, not two, after punctuation.
set nojoinspaces

" Open split window position
set splitbelow
set splitright

" Copy to clipboard
set clipboard=unnamedplus

filetype plugin indent on

" Split window
nnoremap <Leader>v :vsplit<CR>
nnoremap <Leader>s :split<CR>

" NERDTree
nnoremap <C-b> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>
let NERDTreeShowHidden=1
let NERDTreeMinimalUI=1
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
" git for NERDTree
let g:NERDTreeGitStatusUseNerdFonts = 1
" Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
   \ quit | endif

" format
" command! -nargs=0 Format :call CocAction('format')
" nmap <Leader>f :Format <CR>

" telescope
noremap <leader>p <cmd>Telescope find_files<cr>
noremap <leader>h <cmd>Telescope oldfiles<cr>
noremap <leader>m <cmd>Telescope marks<cr>
noremap <leader>w <cmd>Telescope live_grep<cr>
noremap <leader>c <cmd>Telescope colorscheme<cr>
noremap <leader>b <cmd>Telescope file_browser<cr>

" Easymotion
map / <Plug>(easymotion-sn)

" Multi select
let g:multi_cursor_next_key='<C-n>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-x>'

" Move between windows
map <A-h> <C-W>h
map <A-l> <C-W>l
map <A-j> <C-W>j
map <A-k> <C-W>k

" Config for terminal
tnoremap <Esc> <C-\><C-n>

" Config for supertab
let g:SuperTabDefaultCompletionType = "<c-n>"

" Clear highlight for git column
highlight clear signcolumn
set signcolumn=number
let g:gitgutter_set_sign_backgrounds = 1
highlight GitGutterAdd    guifg=#009900 ctermfg=2
highlight GitGutterChange guifg=#bbbb00 ctermfg=3
highlight GitGutterDelete guifg=#ff2222 ctermfg=1

" GitGutter
nmap gh] <Plug>(GitGutterNextHunk)
nmap gh[ <Plug>(GitGutterPrevHunk)
nmap ghs <Plug>(GitGutterStageHunk)
nmap ghu <Plug>(GitGutterUndoHunk)
nmap ghp <Plug>(GitGutterPreviewHunk)

" " Config for coc
" augroup mygroup
"   autocmd!
"   " Setup formatexpr specified filetype(s).
"   autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
"   " Update signature help on jump placeholder.
"   autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
" augroup end

" nnoremap <silent> K :call ShowDocumentation()<CR>

" function! ShowDocumentation()
"   if CocAction('hasProvider', 'hover')
"     call CocActionAsync('doHover')
"   else
"     call feedkeys('K', 'in')
"   endif
" endfunction

" vmap <leader>a <Plug>(coc-codeaction-selected)
" nmap <leader>a <Plug>(coc-codeaction-selected)

" " GoTo code navigation.
" nmap <silent> gd <Plug>(coc-definition)
" nmap <silent> gy <Plug>(coc-type-definition)
" nmap <silent> gi <Plug>(coc-implementation)
" nmap <silent> gr <Plug>(coc-references)

" " Remap <C-j> and <C-k> for scroll float windows/popups.
" if has('nvim-0.4.0') || has('patch-8.2.0750')
"   nnoremap <silent><nowait><expr> <C-j> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
"   nnoremap <silent><nowait><expr> <C-k> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
"   inoremap <silent><nowait><expr> <C-j> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
"   inoremap <silent><nowait><expr> <C-k> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
"   vnoremap <silent><nowait><expr> <C-j> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
"   vnoremap <silent><nowait><expr> <C-k> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
" endif

" airline
let g:airline_theme="gruvbox_material"
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.whitespace = 'Ξ'
" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

" Resize windows by arrow keys
map <silent> <Right> <C-w><
map <silent> <Down> <C-W>-
map <silent> <Up> <C-W>+
map <silent> <Left> <C-w>>

" Dashboard
noremap <leader>nf :ene <BAR> startinsert <CR>
nmap <Leader>ss :<C-u>SessionSave<CR>
nmap <Leader>sl :<C-u>SessionLoad<CR>

lua <<EOF
require('setup')
require('lsp')
require('autocompletion')
EOF

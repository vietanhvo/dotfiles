call plug#begin('~/.vim/plugged')
  Plug 'sainnhe/gruvbox-material'
  Plug 'nvim-lualine/lualine.nvim'
  Plug 'williamboman/mason.nvim'
  Plug 'williamboman/mason-lspconfig.nvim'
  Plug 'neovim/nvim-lspconfig'
  Plug 'hrsh7th/nvim-cmp'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-nvim-lua'
  Plug 'saadparwaiz1/cmp_luasnip'
  Plug 'L3MON4D3/LuaSnip'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-path'
  Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
  Plug 'tzachar/cmp-tabnine', { 'do': './install.sh' }
  Plug 'Saecki/crates.nvim'
  Plug 'glepnir/dashboard-nvim'
  Plug 'kyazdani42/nvim-web-devicons'
  Plug 'kyazdani42/nvim-tree.lua'
  Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-lua/popup.nvim'
  Plug 'nvim-telescope/telescope-media-files.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'nvim-telescope/telescope-file-browser.nvim'
  Plug 'nvim-telescope/telescope-ui-select.nvim'
  Plug 'folke/todo-comments.nvim'
  Plug 'numToStr/Comment.nvim'
  Plug 'phaazon/hop.nvim'
  Plug 'lewis6991/gitsigns.nvim'
  Plug 'kylechui/nvim-surround'
  Plug 'mg979/vim-visual-multi', {'branch': 'test'}
  Plug 'norcalli/nvim-colorizer.lua'
  Plug 'lukas-reineke/indent-blankline.nvim'
  Plug 'akinsho/toggleterm.nvim'
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'p00f/nvim-ts-rainbow'
  Plug 'windwp/nvim-ts-autotag'
  Plug 'windwp/nvim-autopairs'
  Plug 'JoosepAlviste/nvim-ts-context-commentstring'
  Plug 'simrat39/rust-tools.nvim'
  Plug 'mfussenegger/nvim-dap'
  Plug 'rcarriga/nvim-dap-ui'
  Plug 'RRethy/vim-illuminate'
  Plug 'rcarriga/nvim-notify'
  Plug 'karb94/neoscroll.nvim'
  Plug 'm-demare/hlargs.nvim'
  Plug 'kosayoda/nvim-lightbulb'
  Plug 'antoinemadec/FixCursorHold.nvim' 
  Plug 'rmagatti/goto-preview'
  Plug 'j-hui/fidget.nvim'
  Plug 'onsails/lspkind.nvim'
  Plug 'zbirenbaum/copilot.lua'
  Plug 'zbirenbaum/copilot-cmp'
  Plug 'rvmelkonian/move.vim'
call plug#end()

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
let g:gruvbox_material_diagnostic_virtual_text = 'colored'
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

" telescope
noremap <leader>p <cmd>Telescope find_files<cr>
noremap <leader>h <cmd>Telescope oldfiles<cr>
noremap <leader>m <cmd>Telescope marks<cr>
noremap <leader>w <cmd>Telescope live_grep<cr>
noremap <leader>c <cmd>Telescope colorscheme<cr>
noremap <leader>b <cmd>Telescope file_browser<cr>

" Multi cursor
let g:VM_mouse_mappings = 1

" Move between windows
map <A-h> <C-W>h
map <A-l> <C-W>l
map <A-j> <C-W>j
map <A-k> <C-W>k

" Config for terminal
tnoremap <Esc> <C-\><C-n>

" Resize windows by arrow keys
map <silent> <Right> <C-w><
map <silent> <Down> <C-W>-
map <silent> <Up> <C-W>+
map <silent> <Left> <C-w>>

" Dashboard
noremap <leader>nf :ene <BAR> startinsert <CR>
nmap <Leader>ss :<C-u>SessionSave<CR>
nmap <Leader>sl :<C-u>SessionLoad<CR>

let g:cursorhold_updatetime = 500

" Highlight for nvim tree
hi NvimTreeSpecialFile guifg=#ff7800

" Go to preview
nnoremap gd <cmd>lua require('goto-preview').goto_preview_definition()<CR>
nnoremap gt <cmd>lua require('goto-preview').goto_preview_type_definition()<CR>
nnoremap gi <cmd>lua require('goto-preview').goto_preview_implementation()<CR>
nnoremap gr <cmd>lua require('goto-preview').goto_preview_references()<CR>

" nvim-dap
nnoremap <silent> <F5> <Cmd>lua require'dap'.continue()<CR>
nnoremap <silent> <F10> <Cmd>lua require'dap'.step_over()<CR>
nnoremap <silent> <F11> <Cmd>lua require'dap'.step_into()<CR>
nnoremap <silent> <F12> <Cmd>lua require'dap'.step_out()<CR>
nnoremap <silent> m <Cmd>lua require'dap'.toggle_breakpoint()<CR>

lua <<EOF
require('setup')
require('lsp')
EOF

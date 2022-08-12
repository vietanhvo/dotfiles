-- notify
vim.notify = require("notify")

-- lightbulb for code action
require('nvim-lightbulb').setup({ autocmd = { enabled = true } })
vim.fn.sign_define('LightBulbSign', { text = "💡", texthl = "", linehl = "", numhl = "" })

-- navigate with hop
require 'hop'.setup()

-- go to definition in preview window
require('goto-preview').setup {}

-- dap
require("dapui").setup()
local dap, dapui = require("dap"), require("dapui")
dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
end
-- vim.fn.sign_define('DapBreakpoint', {text='🔴', texthl='', linehl='', numhl=''})

-- surround
require('nvim-surround').setup {}

-- comment
require('Comment').setup {
    pre_hook = function(ctx)
        local U = require 'Comment.utils'

        local location = nil
        if ctx.ctype == U.ctype.block then
            location = require('ts_context_commentstring.utils').get_cursor_location()
        elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
            location = require('ts_context_commentstring.utils').get_visual_start_location()
        end

        return require('ts_context_commentstring.internal').calculate_commentstring {
            key = ctx.ctype == U.ctype.line and '__default' or '__multiline',
            location = location,
        }
    end,
}
require('todo-comments').setup {}

-- file explorer
require("nvim-tree").setup({
    diagnostics = {
        enable = true,
    },
    renderer = {
        highlight_git = true,
    }
})
local nt_api = require("nvim-tree.api")
vim.keymap.set('n', '<C-b>', nt_api.tree.toggle, { noremap = true, silent = true })
vim.keymap.set('n', '<C-o>', nt_api.tree.change_root_to_node, { noremap = true, silent = true })
vim.keymap.set("n", "<leader>mn", nt_api.marks.navigate.next)
vim.keymap.set("n", "<leader>mp", nt_api.marks.navigate.prev)
vim.keymap.set("n", "<leader>ms", nt_api.marks.navigate.select)
-- Auto close
vim.api.nvim_create_autocmd("BufEnter", {
    nested = true,
    callback = function()
        if #vim.api.nvim_list_wins() == 1 and vim.api.nvim_buf_get_name(0):match("NvimTree_") ~= nil then
            vim.cmd "quit"
        end
    end
})

-- status line
require('lualine').setup {
    options = { theme = 'gruvbox-material' },
    sections = {
        lualine_b = { 'branch', 'diff' },
        lualine_x = { {
            'diagnostics',
            sources = { 'nvim_lsp' },
            sections = { 'error', 'warn', 'info', 'hint' },
            diagnostics_color = {
                error = 'VirtualTextError', -- Changes diagnostics' error color.
                warn  = 'VirtualTextWarning', -- Changes diagnostics' warn color.
                info  = 'VirtualTextInformation', -- Changes diagnostics' info color.
                hint  = 'VirtualTextHint', -- Changes diagnostics' hint color.
            },
            symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' },
            colored = true,
            update_in_insert = false,
            always_visible = false,
        }, 'encoding', 'fileformat', 'filetype' },
    },
    tabline = {
        lualine_a = { 'buffers' },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = { 'tabs' }
    },
    extensions = { 'nvim-tree', 'toggleterm' }
}

-- git
require('gitsigns').setup {
    current_line_blame = false,
    on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', ']g', function()
            if vim.wo.diff then return ']c' end
            vim.schedule(function() gs.next_hunk() end)
            return '<Ignore>'
        end, { expr = true })

        map('n', '[g', function()
            if vim.wo.diff then return '[c' end
            vim.schedule(function() gs.prev_hunk() end)
            return '<Ignore>'
        end, { expr = true })

        -- Actions
        map({ 'n', 'v' }, 'ghs', ':Gitsigns stage_hunk<CR>')
        map({ 'n', 'v' }, 'ghr', ':Gitsigns reset_hunk<CR>')
        map('n', 'ghS', gs.stage_buffer)
        map('n', 'ghu', gs.undo_stage_hunk)
        map('n', 'ghR', gs.reset_buffer)
        map('n', 'ghp', gs.preview_hunk)
        map('n', 'ghb', function() gs.blame_line { full = true } end)
        map('n', 'gtb', gs.toggle_current_line_blame)
        map('n', 'ghd', gs.diffthis)
        map('n', 'ghD', function() gs.diffthis('~') end)
        map('n', 'gtd', gs.toggle_deleted)

        -- Text object
        map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
    end
}

-- Sign for Diagnostics
local signs = {
    Error = "",
    Warn = "",
    Hint = "",
    Infor = ""
}

for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- treesitter
require('nvim-treesitter.configs').setup {
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    indent = {
        enable = true
    },
    rainbow = {
        enable = true,
        extended_mode = true, -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
    },
    autotag = {
        enable = true,
    },
    context_commentstring = {
        enable = true,
        enable_autocmd = false,
    }
}
-- telescope
require('telescope').load_extension('fzf')
require('telescope').load_extension('file_browser')

require("telescope").setup {
    extensions = {
        ["ui-select"] = {
            require("telescope.themes").get_dropdown {}
        },
        media_files = {
            find_cmd = "rg"
        }
    }
}
require("telescope").load_extension("ui-select")
require('telescope').load_extension('media_files')

require('nvim-autopairs').setup {
    check_ts = true,
}


require("indent_blankline").setup {
    show_current_context = true,
    show_current_context_start = true,
    filetype_exclude = { "dashboard" },
}
require 'colorizer'.setup()
require('neoscroll').setup({
    mappings = { '<C-u>', '<C-d>', '', '',
        '<C-y>', '<C-e>', 'zt', 'zz', 'zb' },
})
require("toggleterm").setup {
    open_mapping = [[<c-\>]],
    shade_terminals = false,
}
require('hlargs').setup()

-- crates
require('crates').setup()
local crates = require('crates')
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<leader>cv', crates.show_versions_popup, opts)
vim.keymap.set('n', '<leader>cf', crates.show_features_popup, opts)
vim.keymap.set('n', '<leader>cd', crates.show_dependencies_popup, opts)

-- Dashboard
local home = os.getenv('HOME')
local db = require('dashboard')
db.custom_header = {
    '                                   ',
    '                                   ',
    '          ▀████▀▄▄              ▄█ ',
    '            █▀    ▀▀▄▄▄▄▄    ▄▄▀▀█ ',
    '    ▄        █          ▀▀▀▀▄  ▄▀  ',
    '   ▄▀ ▀▄      ▀▄              ▀▄▀  ',
    '  ▄▀    █     █▀   ▄█▀▄      ▄█    ',
    '  ▀▄     ▀▄  █     ▀██▀     ██▄█   ',
    '   ▀▄    ▄▀ █   ▄██▄   ▄  ▄  ▀▀ █  ',
    '    █  ▄▀  █    ▀██▀    ▀▀ ▀▀  ▄▀  ',
    '   █   █  █      ▄▄           ▄▀   ',
    '                                   ',
    '                                   ',
    "[Hello, welcome back. Let's build something cool!]",
    '                                   ',
    '                                   ',
}
db.custom_center = {
    { icon = '  ',
        desc = 'File Browser                            ',
        action = 'Telescope file_browser',
        shortcut = 'SPC b' },
    { icon = '  ',
        desc = 'Find  File                              ',
        action = 'Telescope find_files find_command=rg,--hidden,--files',
        shortcut = 'SPC p' },
    { icon = '  ',
        desc = 'Recently opened files                   ',
        action = 'Telescope oldfiles',
        shortcut = 'SPC h' },
    { icon = '  ',
        desc = 'Find  word                              ',
        action = 'Telescope live_grep',
        shortcut = 'SPC w' },
    { icon = '  ',
        desc = 'Recently latest session               ',
        shortcut = 'SPC s l',
        action = 'SessionLoad' },
    { icon = '  ',
        desc = 'Open Personal Settings                 ',
        action = 'e ~/.config/nvim/init.vim',
        shortcut = '      ' },
}

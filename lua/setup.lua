-- notify
vim.notify = require("notify")

require('nvim-lightbulb').setup({ autocmd = { enabled = true } })
vim.fn.sign_define('LightBulbSign', { text = "💡", texthl = "", linehl = "", numhl = "" })

require'hop'.setup()

require('goto-preview').setup {}

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
        enable = true
    }
}
-- telescope
require('telescope').load_extension('fzf')
require('telescope').load_extension('file_browser')

require("telescope").setup {
    extensions = {
        ["ui-select"] = {
            require("telescope.themes").get_dropdown {}
        }
    }
}
require("telescope").load_extension("ui-select")

require('nvim-autopairs').setup {}

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
        desc = 'Recently latest session                ',
        shortcut = 'SPC s l',
        action = 'SessionLoad' },
    { icon = '  ',
        desc = 'Open Personal Settings                 ',
        action = 'e ~/.config/nvim/init.vim',
        shortcut = '      ' },
}

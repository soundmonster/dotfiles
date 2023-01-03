require('aerial').setup {
    on_attach = function(bufnr)
        -- Toggle the aerial window with <leader>a
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>a', '<cmd>AerialToggle!<CR>', {})
        -- Jump forwards/backwards with '{' and '}'
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '{', '<cmd>AerialPrev<CR>', {})
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '}', '<cmd>AerialNext<CR>', {})
        -- Jump up the tree with '[[' or ']]'
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '[[', '<cmd>AerialPrevUp<CR>', {})
        vim.api.nvim_buf_set_keymap(bufnr, 'n', ']]', '<cmd>AerialNextUp<CR>', {})
    end
}

local trouble = require('trouble.providers.telescope')
local telescope = require('telescope')
-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
-- This is your opts table
telescope.setup {
    defaults = {
        mappings = {
            i = { ["<c-t>"] = trouble.open_with_trouble },
            n = { ["<c-t>"] = trouble.open_with_trouble },
        },
    },
    extensions = {
        ["ui-select"] = {
            require 'telescope.themes'.get_dropdown {}
        },
        undo = {
            use_delta = false,
            use_custom_command = { "bash", "-c", "echo '$DIFF' | delta --no-gitconfig" }
        },
    },
}
-- To get ui-select loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
telescope.load_extension('ui-select')
telescope.load_extension('fzf')
telescope.load_extension('aerial')
telescope.load_extension('undo')

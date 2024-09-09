local trouble = require("trouble.sources.telescope")
local telescope = require("telescope")
local actions = require("telescope.actions")
-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
-- This is your opts table
telescope.setup({
    defaults = {
        mappings = {
            i = {
                ["<c-t>"] = trouble.open,
                ["<c-q>"] = actions.send_to_qflist + actions.open_qflist,
                ["<c-a>"] = actions.add_to_qflist,
                ["<c-f>"] = actions.send_selected_to_qflist + actions.open_qflist,
            },
            n = {
                ["<c-t>"] = trouble.open,
                ["<c-q>"] = actions.send_to_qflist + actions.open_qflist,
                ["<c-a>"] = actions.add_to_qflist,
                ["<c-f>"] = actions.send_selected_to_qflist + actions.open_qflist,
            },
        },
    },
    extensions = {
        ["ui-select"] = {
            require("telescope.themes").get_dropdown({}),
        },
        undo = {
            use_delta = false,
            use_custom_command = { "bash", "-c", "echo '$DIFF' | delta --no-gitconfig" },
        },
    },
})

telescope.load_extension("ui-select")
telescope.load_extension("fzf")
telescope.load_extension("live_grep_args")

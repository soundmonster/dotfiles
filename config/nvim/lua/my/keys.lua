local wk = require("which-key")

-- windows.nvim
wk.register({
    ["<C-w>"] = {
        name = "window",
        z = { "<cmd>WindowsMaximize<cr>", "maximize window" },
    },
})

-- copy to system clipboard
wk.register({ ["<leader>yy"] = { 'ggVG"*y', "file to system clipboard" } }, { mode = "n" })
wk.register({ ["<leader>yy"] = { '"*y', "selection to system clipboard" } }, { mode = "v" })
-- reselect pasted text
wk.register({ gp = { "`[v`]", "reselect pasted text" } })

local hops = {
    ["<leader><leader>"] = {
        name = "Hops",
        w = {
            "<cmd>lua require'hop'.hint_words({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR })<cr>",
            -- "<cmd>lua require'leap'.leap({})<cr>",
            "words after cursor",
        },
        b = {
            "<cmd>lua require'hop'.hint_words({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR })<cr>",
            -- "<cmd>lua require'leap'.leap({backward=true})<cr>",
            "words before cursor",
        },
        j = {
            "<cmd>lua require'hop'.hint_lines_skip_whitespace({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR })<cr>",
            -- "<cmd>lua require'my.hops'.leap_to_line(require'my.hops'.HintDirection.AFTER_CURSOR)<cr>",
            "lines down",
        },
        k = {
            "<cmd>lua require'hop'.hint_lines_skip_whitespace({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR })<cr>",
            -- "<cmd>lua require'my.hops'.leap_to_line(require'my.hops'.HintDirection.BEFORE_CURSOR)<cr>",
            "lines up",
        },
    },
}
wk.register(hops, { mode = "n" })
wk.register(hops, { mode = "v" })

-- Sideways
wk.register({
    ["<C-h>"] = { "<cmd>SidewaysLeft<cr>", "sideways left" },
    ["<C-l>"] = { "<cmd>SidewaysRight<cr>", "sideways right" },
    ["<C-k>"] = { "<cmd>ElixirToPipe<cr>", "Elixir to pipe" },
    ["<C-j>"] = { "<cmd>ElixirFromPipe<cr>", "Elixir from pipe" },
})

-- Files
wk.register({
    ["<leader>*"] = {
        "<cmd>lua require('telescope.builtin').grep_string({search = vim.fn.expand('<cword>')})<cr>",
        "search word under cursor in project",
    },
    ["<leader>f"] = {
        name = "file",
        f = { "<cmd>Telescope find_files<cr>", "find file" },
        -- g = { "<cmd>Telescope live_grep<cr>", "search text in files" },
        g = { "<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<cr>", "search text in files" },
        b = { "<cmd>Telescope buffers<cr>", "buffers" },
        r = { "<cmd>Telescope oldfiles<cr>", "recent files" },
        t = { "<cmd>NvimTreeToggle<cr>", "file tree" },
        l = { "<cmd>NvimTreeFindFile<cr>", "locate current file in tree" },
    },
    ["<leader>d"] = {
        name = "diagnostics",
        d = { "<cmd>TroubleToggle<cr>", "toggle" },
        f = { "<cmd>TroubleToggle document_diagnostics<cr>", "file diagnostics" },
        w = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "project diagnostics" },
        l = { "<cmd>TroubleToggle loclist<cr>", "loclist" },
        q = { "<cmd>TroubleToggle quickfix<cr>", "quickfix" },
    },
    ["<leader>t"] = {
        name = "neotest",
        t = { "<cmd>lua require('neotest').summary.toggle()<cr>", "toggle tree" },
        o = { "<cmd>lua require('neotest').output.toggle()<cr>", "toggle output" },
        p = { "<cmd>lua require('neotest').output_panel.toggle()<cr>", "toggle output panel" },
        f = { "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>", "run file" },
        l = { "<cmd>lua require('neotest').run.run()<cr>", "run test" },
        s = { "<cmd>lua require('neotest').run.run({suite=true})<cr>", "run suite" },
    },
    ["<leader>n"] = {
        name = "notifications",
        l = { "<cmd>NoiceLog<cr>", "list" },
        c = { "<cmd>lua require('notify').dismiss()<cr>", "clear" },
    },
})

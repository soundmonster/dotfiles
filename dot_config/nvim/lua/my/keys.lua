return {
  { "<leader><leader>", group = "hops", mode = { "n", "v" } },
  {
    "<leader><leader>w",
    "<cmd>lua require'hop'.hint_words({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR })<cr>",
    desc = "words after cursor",
    mode = { "n", "v" },
  },
  {
    "<leader><leader>b",
    "<cmd>lua require'hop'.hint_words({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR })<cr>",
    desc = "words before cursor",
    mode = { "n", "v" },
  },
  {
    "<leader><leader>j",
    "<cmd>lua require'hop'.hint_lines_skip_whitespace({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR })<cr>",
    desc = "lines down",
    mode = { "n", "v" },
  },
  {
    "<leader><leader>k",
    "<cmd>lua require'hop'.hint_lines_skip_whitespace({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR })<cr>",
    desc = "lines up",
    mode = { "n", "v" },
  },
  -- Treewalker motions
  { "<C-h>", "<cmd>Treewalker Left<cr>", desc = "treewalker left" },
  { "<C-j>", "<cmd>Treewalker Down<cr>", desc = "treewalker down" },
  { "<C-k>", "<cmd>Treewalker Up<cr>", desc = "treewalker up" },
  { "<C-l>", "<cmd>Treewalker Right<cr>", desc = "treewalker right" },
  -- Treewalker swapping (like sideways.nvim)
  { "<C-S-h>", "<cmd>Treewalker SwapLeft<cr>", desc = "treewalker left" },
  { "<C-S-j>", "<cmd>Treewalker SwapDown<cr>", desc = "treewalker down" },
  { "<C-S-k>", "<cmd>Treewalker SwapUp<cr>", desc = "treewalker up" },
  { "<C-S-l>", "<cmd>Treewalker SwapRight<cr>", desc = "treewalker right" },
  -- Elixir Tools
  -- { "<C-k>", "<cmd>ElixirToPipe<cr>", "Elixir to pipe" },
  -- { "<C-j>", "<cmd>ElixirFromPipe<cr>", "Elixir from pipe" },
  -- windows.nvim
  { "<C-w>z", "<cmd>WindowsMaximize<cr>", desc = "maximize window" },
  -- copy to system clipboard
  {
    "<leader>yy",
    "<cmd>%y+<cr>",
    desc = "file to system clipboard",
    mode = "n",
  },
  {
    "<leader>yy",
    '"+y',
    desc = "selection to system clipboard",
    mode = "v",
  },
  {
    "<leader>yf",
    "<cmd>let @+ = expand('%:~:.')<cr>",
    desc = "copy current path to global paste buffer",
  },
  {
    "<leader>yl",
    "<cmd>let @+ = expand('%:~:.') . ':' . line('.')<cr>",
    desc = "copy current path and line number to global paste buffer",
  },
  -- reselect pasted text
  { "gp", "`[v`]", desc = "reselect pasted text" },

  {
    "<leader>*",
    -- "<cmd>lua require('telescope.builtin').grep_string({search = vim.fn.expand('<cword>')})<cr>",
    "<cmd>lua Snacks.picker.grep_word()<cr>",
    desc = "search word under cursor in project",
  },
  { "<leader>f", group = "files" },
  { "<leader>fF", "<cmd>lua Snacks.picker.files({hidden = true})<cr>", desc = "find file" },
  { "<leader>ff", "<cmd>lua Snacks.picker.smart()<cr>", desc = "find file with recency bonus" },
  { "<leader>fg", "<cmd>lua Snacks.picker.grep({hidden = true})<cr>", desc = "search text in files" },
  {
    "<leader>fG",
    function()
      local tree_api = require("nvim-tree.api")
      local selected_files = {}
      local marks = tree_api.marks.list()
      if table.getn(marks) > 0 then
        for i, mark in ipairs(marks) do
          selected_files[i] = mark.absolute_path
        end
      else
        selected_files = { tree_api.tree.get_node_under_cursor().absolute_path }
      end
      Snacks.picker.grep({ dirs = selected_files, hidden = true })
    end,
    desc = "search text in the file/dir under cursor in nvim-tree",
  },
  { "<leader>fb", "<cmd>lua Snacks.picker.buffers()<cr>", desc = "buffers" },
  {
    "<leader>fr",
    "<cmd>lua Snacks.picker.recent()<cr>",
    desc = "recent files",
  },
  { "<leader>fm", "<cmd>lua Snacks.picker.marks()<cr>", desc = "marks" },
  { "<leader>ft", "<cmd>NvimTreeToggle<cr>", desc = "file tree" },
  {
    "<leader>fl",
    "<cmd>NvimTreeFindFile<cr>",
    desc = "locate current file in tree",
  },

  { "<leader>fo", group = "alternative files" },
  {
    "<leader>foo",
    "<cmd>Other<cr>",
    desc = "jump to alt file",
  },
  {
    "<leader>fov",
    "<cmd>OtherVSplit<cr>",
    desc = "alt file in vsplit",
  },
  {
    "<leader>foc",
    "<cmd>OtherClear<cr>",
    desc = "clear alt file",
  },
  -- git hunks
  { "<leader>g", group = "Git" },
  { "<leader>gj", "<cmd>Gitsigns next_hunk", desc = "next hunk" },
  { "<leader>gk", "<cmd>Gitsigns prev_hunk", desc = "prev hunk" },
  { "<leader>s", group = "symbols" },
  {
    "<leader>st",
    "<cmd>AerialToggle!<cr>",
    desc = "toggle symbols",
  },
  {
    "<leader>ss",
    "<cmd>lua Snacks.picker.lsp_symbols()<cr>",
    desc = "symbol search",
  },
  {
    "<leader>sw",
    "<cmd>lua Snacks.picker.lsp_workspace_symbols()<cr>",
    desc = "workspace symbol search",
  },

  { "<leader>d", group = "diagnostics" },
  {
    "<leader>dd",
    "<cmd>Trouble diagnostics toggle<cr>",
    desc = "toggle diagnostics",
  },
  {
    "<leader>dl",
    "<cmd>Trouble loclist toggle<cr>",
    desc = "toggle loclist",
  },
  {
    "<leader>dq",
    "<cmd>Trouble quickfix toggle<cr>",
    desc = "toggle quickfix",
  },
  {
    "<leader>dt",
    "<cmd>Trouble telescope toggle<cr>",
    desc = "toggle telescope",
  },

  { "<leader>T", group = "in a wezterm pane, ..." },
  {
    "<leader>Tf",
    "<cmd>!wezterm-bottom-pane mix test %<cr>",
    desc = "run file from current buffer",
  },
  {
    "<leader>Tl",
    "<cmd>exec '!wezterm-bottom-pane mix test %:' . line('.')<cr>",
    desc = "run test under cursor",
  },
  { "<leader>Ts", "<cmd>!wezterm-bottom-pane mix test<cr>", desc = "run suite" },

  { "<leader>t", group = "neotest" },
  {
    "<leader>tt",
    "<cmd>lua require('neotest').summary.toggle()<cr>",
    desc = "toggle tree",
  },
  {
    "<leader>to",
    "<cmd>lua require('neotest').output.toggle()<cr>",
    desc = "toggle output",
  },
  {
    "<leader>tp",
    "<cmd>lua require('neotest').output_panel.toggle()<cr>",
    desc = "toggle output panel",
  },
  {
    "<leader>tf",
    "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>",
    desc = "run file for current buffer",
  },
  {
    "<leader>tl",
    "<cmd>lua require('neotest').run.run()<cr>",
    desc = "run test under cursor",
  },
  { "<leader>ts", "<cmd>lua require('neotest').run.run({suite=true})<cr>", desc = "run suite" },
  { "<leader>tr", "<cmd>lua require('neotest').run.run_last()<cr>", desc = "run last" },

  { "<leader>n", group = "notifications" },
  { "<leader>nl", "<cmd>NoiceLog<cr>", desc = "list" },
  { "<leader>nc", "<cmd>lua require('notify').dismiss()<cr>", desc = "clear" },

  -- { "<leader>a",   group = "ai" },

  { "<leader>cc", group = "copilot-chat" },
  {
    "<leader>ccs",
    "<cmd>lua require('codecompanion.adapters.copilot').show_copilot_stats()<cr>",
    desc = "Copilot Usage Statistics",
  },
  {
    "<leader>ccc",
    "<cmd>CodeCompanionChat<cr>",
    desc = "[CodeCompanion] Chat",
  },
  {
    "<leader>cca",
    "<cmd>CodeCompanionActions<cr>",
    desc = "[CodeCompanion] Actions",
  },
  {
    "<leader>ccq",
    function()
      local input = vim.fn.input("Quick Chat: ")
      if input ~= "" then
        require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
      end
    end,
    desc = "[Copilot] Quick chat",
  },
  {
    "<leader>cch",
    function()
      local actions = require("CopilotChat.actions")
      require("CopilotChat.integrations.telescope").pick(actions.help_actions())
    end,
    desc = "[Copilot] Help actions",
  },
  -- Show prompts actions with telescope
  {
    "<leader>ccp",
    function()
      local actions = require("CopilotChat.actions")
      require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
    end,
    desc = "[Copilot] Prompt actions",
    mode = { "n", "v" },
  },
}

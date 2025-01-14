return {
  { "<leader><leader>", group = "hops",                                    mode = { "n", "v" } },
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
  -- Sideways
  { "<C-h>",            "<cmd>SidewaysLeft<cr>",                           desc = "sideways left" },
  { "<C-l>",            "<cmd>SidewaysRight<cr>",                          desc = "sideways right" },
  -- Elixir Tools
  -- { "<C-k>", "<cmd>ElixirToPipe<cr>", "Elixir to pipe" },
  -- { "<C-j>", "<cmd>ElixirFromPipe<cr>", "Elixir from pipe" },
  -- windows.nvim
  { "<C-w>z",           "<cmd>WindowsMaximize<cr>",                        desc = "maximize window" },
  -- copy to system clipboard
  { "<leader>yy",       '<cmd>%y+<cr>',                                    desc = "file to system clipboard",                                mode = "n" },
  { "<leader>yy",       '"+y',                                             desc = "selection to system clipboard",                           mode = "v" },
  { "<leader>yf",       "<cmd>let @+ = expand('%')<cr>",                   desc = "copy current path to global paste buffer" },
  { "<leader>yl",       "<cmd>let @+ = expand('%') . ':' . line('.')<cr>", desc = "copy current path and line number to global paste buffer" },
  -- reselect pasted text
  { "gp",               "`[v`]",                                           desc = "reselect pasted text" },

  {
    "<leader>*",
    "<cmd>lua require('telescope.builtin').grep_string({search = vim.fn.expand('<cword>')})<cr>",
    desc = "search word under cursor in project",
  },
  { "<leader>f",  group = "files" },
  { "<leader>ff", "<cmd>Telescope find_files<cr>",                                                desc = "find file" },
  { "<leader>fg", "<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<cr>", desc = "search text in files", },
  { "<leader>fb", "<cmd>Telescope buffers<cr>",                                                   desc = "buffers" },
  { "<leader>fr", "<cmd>Telescope oldfiles<cr>",                                                  desc = "recent files" },
  { "<leader>ft", "<cmd>NvimTreeToggle<cr>",                                                      desc = "file tree" },
  { "<leader>fl", "<cmd>NvimTreeFindFile<cr>",                                                    desc = "locate current file in tree", },

  { "<leader>a",  "<cmd>AerialToggle!<cr>",                                                       desc = "toggle symbols" },

  { "<leader>d",  group = "diagnostics" },
  { "<leader>dd", "<cmd>Trouble diagnostics toggle<cr>",                                          desc = "toggle diagnostics" },
  { "<leader>dl", "<cmd>Trouble loclist toggle<cr>",                                              desc = "toggle loclist" },
  { "<leader>dq", "<cmd>Trouble quickfix toggle<cr>",                                             desc = "toggle quickfix" },
  { "<leader>dt", "<cmd>Trouble telescope toggle<cr>",                                            desc = "toggle telescope" },

  { "<leader>t",  group = "neotest" },
  { "<leader>tt", "<cmd>lua require('neotest').summary.toggle()<cr>",                             desc = "toggle tree" },
  { "<leader>to", "<cmd>lua require('neotest').output.toggle()<cr>",                              desc = "toggle output" },
  { "<leader>tp", "<cmd>lua require('neotest').output_panel.toggle()<cr>",                        desc = "toggle output panel" },
  { "<leader>tf", "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>",                  desc = "run file" },
  { "<leader>tl", "<cmd>lua require('neotest').run.run()<cr>",                                    desc = "run test" },
  { "<leader>ts", "<cmd>lua require('neotest').run.run({suite=true})<cr>",                        desc = "run suite" },
  { "<leader>tr", "<cmd>lua require('neotest').run.run_last()<cr>",                               desc = "run last" },

  { "<leader>n",  group = "notifications" },
  { "<leader>nl", "<cmd>NoiceLog<cr>",                                                            desc = "list" },
  { "<leader>nc", "<cmd>lua require('notify').dismiss()<cr>",                                     desc = "clear" },

  { "<leader>cc", group = "copilot-chat" },
  {
    "<leader>ccq",
    function()
      local input = vim.fn.input("Quick Chat: ")
      if input ~= "" then
        require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
      end
    end,
    desc = "Quick chat",
  },
  {
    "<leader>cch",
    function()
      local actions = require("CopilotChat.actions")
      require("CopilotChat.integrations.telescope").pick(actions.help_actions())
    end,
    desc = "Help actions",
  },
  -- Show prompts actions with telescope
  {
    "<leader>ccp",
    function()
      local actions = require("CopilotChat.actions")
      require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
    end,
    desc = "Prompt actions",
    mode = { "n", "v" },
  },
}

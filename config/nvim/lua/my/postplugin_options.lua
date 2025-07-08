-- vim.opt.background = 'dark'
vim.cmd.colorscheme("tokyonight-moon")
-- CodeLens colors
vim.api.nvim_set_hl(0, "LspCodeLens", { link = "DiagnosticVirtualTextHint" })
vim.api.nvim_set_hl(0, "LspCodeLensSeparator", { link = "DiagnosticSignHint" })

local winbar_settings_group = vim.api.nvim_create_augroup("winbar_settings", { clear = true })

vim.api.nvim_create_autocmd({ "WinEnter", "WinResized" }, {
  group = winbar_settings_group,
  desc = "Hide barbecue winbar when blame is open",
  callback = function()
    local win_ids = vim.api.nvim_list_wins()
    for _, win_id in ipairs(win_ids) do
      local buf_id = vim.api.nvim_win_get_buf(win_id)
      local buf_ft = vim.api.nvim_buf_get_option(buf_id, "filetype")
      if buf_ft == "fugitiveblame" then
        require("lualine").hide({
          place = { "winbar" },
          unhide = false,
        })
        require("barbecue.ui").toggle(false)
        break -- Exit the loop since a 'blame' filetype was found
      else
        require("lualine").hide({
          place = { "winbar" },
          unhide = true,
        })
        require("barbecue.ui").toggle(true)
      end
    end
  end,
})

local avante_system_prompt_group = vim.api.nvim_create_augroup("avante_system_prompt", { clear = true })
vim.api.nvim_create_autocmd({ "VimEnter", "DirChanged" }, {
  group = avante_system_prompt_group,
  desc = "Set Avante system prompt based on current directory",
  callback = function()
    local current_dir = vim.fn.getcwd()
    local files = {
      current_dir .. "/AGENTS.md",
      -- current_dir .. "/README.md",
      current_dir .. "/../AGENTS.md",
    }

    local system_prompt = "You are in the directory: " .. current_dir .. "\n"

    for _, file in ipairs(files) do
      if vim.fn.filereadable(file) == 1 then
        local file_content = vim.fn.readfile(file)
        if #file_content > 0 then
          system_prompt = system_prompt .. "\n" .. table.concat(file_content, "\n")
        end
      end
    end

    require("avante.config").override({ system_prompt = system_prompt })
  end,
})

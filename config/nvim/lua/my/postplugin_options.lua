-- vim.opt.background = 'dark'
vim.cmd.colorscheme "tokyonight-moon"
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

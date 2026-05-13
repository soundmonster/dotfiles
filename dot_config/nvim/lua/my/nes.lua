vim.api.nvim_set_var("copilot_ls_nes", true)

local function toggle_nes()
  if vim.g.copilot_ls_nes then
    vim.api.nvim_set_var("copilot_ls_nes", false)
    require("sidekick.nes").disable()
  else
    vim.api.nvim_set_var("copilot_ls_nes", true)
    require("sidekick.nes").enable()
  end
end

local function print_nes_status()
  if vim.g.copilot_ls_nes then
    return "ON"
  else
    return "OFF"
  end
end

vim.api.nvim_create_user_command("CopilotLsNesToggle", toggle_nes, { desc = "Toggle next edit suggestions" })
return {
  toggle_nes = toggle_nes,
  print_nes_status = print_nes_status,
}

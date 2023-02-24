vim.api.nvim_set_var("lsp_autoformat", true)

local function toggle_autoformat()
	if vim.g.lsp_autoformat then
		vim.api.nvim_set_var("lsp_autoformat", false)
	else
		vim.api.nvim_set_var("lsp_autoformat", true)
	end
end

local function on_attach(client, _)
	if client.server_capabilities.documentFormattingProvider then
		vim.cmd([[augroup Format]])
		vim.cmd([[autocmd! * <buffer>]])
		vim.cmd(
			[[autocmd BufWritePre <buffer> lua if vim.g.lsp_autoformat then vim.lsp.buf.format({ async = false }) end]]
		)
		vim.cmd([[augroup END]])
	end
end

vim.api.nvim_create_user_command("LspAutoformatToggle", toggle_autoformat, { desc = "Toggle autoformat on save" })
return {
	toggle_autoformat = toggle_autoformat,
	on_attach = on_attach,
}

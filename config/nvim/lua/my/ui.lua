require("aerial").setup({
	on_attach = function(bufnr)
		-- Toggle the aerial window with <leader>a
		vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>a", "<cmd>AerialToggle!<CR>", {})
		-- Jump forwards/backwards with '{' and '}'
		vim.api.nvim_buf_set_keymap(bufnr, "n", "{", "<cmd>AerialPrev<CR>", {})
		vim.api.nvim_buf_set_keymap(bufnr, "n", "}", "<cmd>AerialNext<CR>", {})
		-- Jump up the tree with '[[' or ']]'
		vim.api.nvim_buf_set_keymap(bufnr, "n", "[[", "<cmd>AerialPrevUp<CR>", {})
		vim.api.nvim_buf_set_keymap(bufnr, "n", "]]", "<cmd>AerialNextUp<CR>", {})
	end,
})

local trouble = require("trouble.providers.telescope")
local telescope = require("telescope")
-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
-- This is your opts table
telescope.setup({
	defaults = {
		mappings = {
			i = { ["<c-t>"] = trouble.open_with_trouble },
			n = { ["<c-t>"] = trouble.open_with_trouble },
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

local telescopeBorderless = function(flavor)
	local cp = require("catppuccin.palettes").get_palette(flavor)

	return {
		TelescopeBorder = { fg = cp.surface0, bg = cp.surface0 },
		TelescopeSelectionCaret = { fg = cp.flamingo, bg = cp.surface1 },
		TelescopeMatching = { fg = cp.peach },
		TelescopeNormal = { bg = cp.surface0 },
		TelescopeSelection = { fg = cp.text, bg = cp.surface1 },
		TelescopeMultiSelection = { fg = cp.text, bg = cp.surface2 },

		TelescopeTitle = { fg = cp.crust, bg = cp.green },
		TelescopePreviewTitle = { fg = cp.crust, bg = cp.red },
		TelescopePromptTitle = { fg = cp.crust, bg = cp.mauve },

		TelescopePromptNormal = { fg = cp.flamingo, bg = cp.crust },
		TelescopePromptBorder = { fg = cp.crust, bg = cp.crust },

		NoiceCmdlinePopup = { fg = cp.flamingo, bg = cp.crust },
		NoiceCmdlinePopupBorder = { fg = cp.crust, bg = cp.crust },
		NoiceCmdlinePopupBorderSearch = { fg = cp.crust, bg = cp.crust },
		NoiceCmdlinePrompt = { fg = cp.flamingo, bg = cp.crust },
	}
end

require("catppuccin").setup({
	highlight_overrides = {
		latte = telescopeBorderless("latte"),
		frappe = telescopeBorderless("frappe"),
		macchiato = telescopeBorderless("macchiato"),
		mocha = telescopeBorderless("mocha"),
	},
})

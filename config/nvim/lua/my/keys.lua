vim.g.mapleader = ' '

local wk = require('which-key')

-- windows.nvim
wk.register({
	['<C-w>'] = {
		name = 'window',
		z = { '<cmd>WindowsMaximize<cr>', 'maximize window' },
	}
})

-- copy to system clipboard
wk.register({ ['<leader>yy'] = { 'ggVG"*y', 'file to system clipboard' } }, { mode = 'n' })
wk.register({ ['<leader>yy'] = { '"*y', 'selection to system clipboard' } }, { mode = 'v' })
-- reselect pasted text
wk.register({ gp = { '`[v`]', 'reselect pasted text' } })

-- hop.nvim
local hops = {
	['<leader><leader>'] = {
		name = 'Hops',
		w = { "<cmd>lua require'hop'.hint_words({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR })<cr>",
			'words after cursor' },
		b = { "<cmd>lua require'hop'.hint_words({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR })<cr>",
			'words before cursor' },
		j = { "<cmd>lua require'hop'.hint_lines_skip_whitespace({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR })<cr>",
			'lines down' },
		k = { "<cmd>lua require'hop'.hint_lines_skip_whitespace({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR })<cr>",
			'lines up' },
	},
}
wk.register(hops, { mode = 'n' })
wk.register(hops, { mode = 'v' })

-- Sideways
wk.register({
	['<C-h>'] = { '<cmd>SidewaysLeft<cr>', 'sideways left' },
	['<C-l>'] = { '<cmd>SidewaysRight<cr>', 'sideways right' }
})

-- Files
wk.register({
	['<leader>*'] = { "<cmd>lua require('telescope.builtin').grep_string({search = vim.fn.expand('<cword>')})<cr>",
		'search word under cursor in project' },
	['<leader>f'] = {
		name = 'file',
		f = { '<cmd>Telescope find_files<cr>', 'find file' },
		s = { '<cmd>Telescope live_grep<cr>', 'search text in files' },
		b = { '<cmd>Telescope buffers<cr>', 'buffers' },
		r = { '<cmd>Telescope oldfiles<cr>', 'recent files' },
		t = { '<cmd>NvimTreeToggle<cr>', 'file tree' },
		l = { '<cmd>NvimTreeFindFile<cr>', 'locate current file in tree' }
	},
	['<leader>d'] = {
		name = 'diagnostics',
		d = { '<cmd>TroubleToggle<cr>', 'toggle' },
		c = { '<cmd>TroubleClose<cr>', 'close' },
		f = { '<cmd>Trouble document_diagnostics<cr>', 'file diagnostics' },
		p = { '<cmd>Trouble workspace_diagnostics<cr>', 'project diagnostics' },
	},
	['<leader>t'] = {
		name = 'tests',
		t = { '<cmd>TestNearest<cr>', 'test under cursor' },
		f = { '<cmd>TestFile<cr>', 'test current file' },
		p = { '<cmd>TestSuite<cr>', 'test full project suite' },
	}
})

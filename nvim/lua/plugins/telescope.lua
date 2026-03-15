return {
	{
		'nvim-telescope/telescope.nvim',
		event = "VimEnter",
		dependencies = {
			'nvim-lua/plenary.nvim',
			'nvim-telescope/telescope-ui-select.nvim',
			{ 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font }
		},
		opts = {
			extensions = {
				['ui-select'] = {
					require('telescope.themes').get_dropdown()
				}
			}
		},
		init = function()
			local builtin = require('telescope.builtin')
			vim.keymap.set('n', '<leader>sf', builtin.find_files, {desc = "[S]earch [f]iles"})
			vim.keymap.set('n', '<leader>sg', builtin.live_grep, {desc = '[S]earch by [g]rep'})
			vim.keymap.set('n', '<leader>sh', builtin.builtin, {desc = '[S]earch [h]elp'})
		end
	}
}

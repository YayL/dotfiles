return {
	{ 'NMAC427/guess-indent.nvim', opts = {} }, -- Heuristic tab width

	{ 'catppuccin/nvim', priority = 1000, name = 'catppuccin' },

	{
		'mbbill/undotree',
		init = function()
			vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
		end
	},

	{
		'folke/todo-comments.nvim',
		event = "VimEnter",
		dependencies = { 'nvim-lua/plenary.nvim' },
		opts = { signs = false }
	},
}

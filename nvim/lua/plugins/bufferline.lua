return {
	{'akinsho/bufferline.nvim',
	dependencies = { {'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font } },
	opts = {
		options = {
			diagnostics = "nvim_lsp",
			diagnostics_indicator = function(count, level, diagnostics_dict, context)
				local icon = level:match("error") and " " or " "
				return " " .. icon .. count
			end,
			offsets = {
				{
					filetype = "NvimTree",
					text = "File Explorer",
					text_align = "left",
					separator = true
				}
			},
		}
	},
	init = function()
		vim.keymap.set("n", "<Tab>", ":BufferLineCycleNext<Cr>")
		vim.keymap.set("n", "<S-Tab>", ":BufferLineCyclePrev<Cr>")
		vim.keymap.set("n", "<leader><Tab>", ":BufferLineMoveNext<Cr>")
		vim.keymap.set("n", "<leader><S-Tab>", ":BufferLineMovePrev<Cr>")
		vim.keymap.set("n", "<leader>x", ":bp <BAR> bd #<CR>")
	end
	}
}

return {
	{
		'nvim-treesitter/nvim-treesitter',
		lazy = false,
		build = ':TSUpdate',
		config = function()
			local parsers = { 'bash', 'c', 'diff', 'lua', 'haskell', 'prolog', 'matlab', 'vim', 'python' }
			require("nvim-treesitter").install(parsers)
			vim.api.nvim_create_autocmd('FileType', {
				callback = function(args)
					local buf, filetype = args.buf, args.match

					local language = vim.treesitter.language.get_lang(filetype)
					if not language then return end

					-- check if parser exists and load it
					if not vim.treesitter.language.add(language) then return end

					vim.treesitter.start(buf, language)
					vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end
			})
		end
	}
}

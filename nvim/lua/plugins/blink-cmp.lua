return {
	{
		'saghen/blink.cmp',
		event = 'VimEnter',
		version = '1.*',
		dependencies = {
			'folke/lazydev.nvim'
		},
		--- @module 'blink.cmp'
		--- @type blink.cmp.Config
		opts = {
			keymap = {
				preset = 'default',

				['<Tab>'] = {
						function(cmp)
							if cmp.snippet_active() then return cmp.accept()
							else return cmp.select_and_accept() end
						end,
						'snippet_forward',
						'fallback'
					},
				['<C-k>'] = { 'select_prev', 'fallback' },
				['<C-j>'] = { 'select_next', 'fallback' },
			},
			appearance = { nerd_font_variant = 'mono' },
			completion = {
				documentation = { auto_show = false, auto_show_delay_ms = 1000 },
				accept = { auto_brackets = { enabled = true }},
				list = { max_items = 25 },

			},
			sources = {
				default = { 'lsp', 'path', 'snippets', 'lazydev' },
				providers = {
					lazydev = { name = 'lazydev', module = 'lazydev.integrations.blink', score_offset = 100 }
				}
			},
			fuzzy = { implementation = 'lua' },
			signature = { enabled = true }
		}
	}
}

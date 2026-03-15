local servers = {
    clangd = {
        root_markers = { 'start.sh' },
        cmd = { 'clangd', '--header-insertion=never' }
    },
    pylsp = {
        settings = { pylsp = { plugins = { pycodestyle = {
            ignore = {
                "E111", "E114", "E121", "E122",
                "E251",
                "E302", "E305",
                "E501", "E502"
            }
        } } } }
    }
}

local ensure_installed = vim.tbl_keys(servers or {})

return {
    { -- Lua LSP for nvim config
        'folke/lazydev.nvim',
        ft = 'lua',
        opts = { library = { path = '${3rd}/luv/library', words = { 'vim%.uv' } } }
    },
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            { 'mason-org/mason.nvim', opts = {}},
            'mason-org/mason-lspconfig.nvim',
            'WhoIsSethDaniel/mason-tool-installer.nvim',

            { 'j-hui/fidget.nvim', opts = {} }, -- LSP Status
            'saghen/blink.cmp' -- Auto completion
        },
        config = function()
            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
                callback = function(event)
                    local map = function(keys, func, desc, mode)
                        mode = mode or 'n'
                        vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
                    end

                    local telescope = require('telescope.builtin')

                    map('grn', vim.lsp.buf.rename, 'Rename')
                    map('gra', vim.lsp.buf.code_action, 'Run action', {'n', 'x'})
                    map('<leader>d', vim.diagnostic.open_float, "Open diagnostic")

                    map('gr', telescope.lsp_references, "Goto references")
                    map('gi', telescope.lsp_implementations, "Goto implementations")
                    map('gd', telescope.lsp_definitions, "Goto definitions")
                    map('gt', telescope.lsp_type_definitions, "Goto type definition")
                    map('gh', vim.lsp.buf.declaration, "Goto declaration(header)")

                    map('<leader>ods', telescope.lsp_document_symbols, "Open document symbols")
                    map('<leader>ows', telescope.lsp_dynamic_workspace_symbols, "Open workspace symbols")
                end
            })

            vim.diagnostic.config {
                severity_sort = true,
                float = { border = 'rounded', source = 'if_many' },
                underline = { severity = { min = vim.diagnostic.severity.WARN } },
                virtual_text = {
                    source = 'if_many',
                    spacing = 2,
                    format = function(diagnostic)
                        return diagnostic.message
                    end
                }
            }

            require('mason-tool-installer').setup{ ensure_installed = ensure_installed }

            for name, server in pairs(servers) do
                vim.lsp.config(name, server)
                vim.lsp.enable(name)
            end
        end
    }
}

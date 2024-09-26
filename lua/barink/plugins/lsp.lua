return
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            {
                "folke/neoconf.nvim",
                opts = {}
            },
            "williamboman/mason-lspconfig",
            "williamboman/mason.nvim",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/nvim-cmp",
            {
                'L3MON4D3/LuaSnip',
                 dependencies = 'hrsh7th/nvim-cmp',
                 version = "v2.*",
            },
            {'mfussenegger/nvim-jdtls', dependencies = {'nvim-dap'}},
        },
        config = function()
            require("mason").setup()
            require("mason-lspconfig").setup({
                ensure_installed = { "lua_ls", "bashls", "rust_analyzer" }
            })
            local cmp = require('cmp')
            cmp.setup({
                snippet = {
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-e>'] = cmp.mapping.abort(),
                    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                }),
                sources = cmp.config.sources({
                    { name = 'nvim_lsp', keyword_length = 1 },
                    { name = 'luasnip', option = { show_autosnippets = true}},
                    { name = 'path' },
                }, {
                    { name = 'buffer', keyword_length = 2 },
                }),
                window = {
                    documentation = cmp.config.window.bordered()
                },

            })

            -- Set configuration for specific filetype.
            cmp.setup.filetype('gitcommit', {
                sources = cmp.config.sources({
                    { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
                }, {
                    { name = 'buffer' },
                })
            })

            -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline({ '/', '?' }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = 'buffer' }
                }
            })

            -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline(':', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = 'path' }
                }, {
                    { name = 'cmdline' }
                }),
                matching = { disallow_symbol_nonprefix_matching = false }
            })

            local ls = require("luasnip")
            ls.config.set_config({
                history = true,
                updateevents = "TextChanged, TextChangedI",
                enable_autosnippets = true,
            })

            vim.keymap.set({"i", "s"}, "<C-K>", function() ls.expand() end, {silent = true})
            vim.keymap.set({"i", "s"}, "<C-L>", function() ls.jump(1) end, {silent = true })
            vim.keymap.set({"i", "s"}, "<C-J>", function() ls.jump(-1) end, {silent = true})
            vim.keymap.set({"i", "s"}, "<C-E>", function()
                if ls.choice_active() then
                    ls.change_choice(1)
                end
            end, {silent = true})

            require("luasnip.loaders.from_lua").load({paths= "C:\\Users\\nigel\\AppData\\Local\\nvim\\lua\\snippets"})


            -- Set up lspconfig.
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            local lsp = require("lspconfig")

            local language_server = { 
                asm_lsp= true,
                zls = true,
                rust_analyzer = true,
                jdtls = true,
                pylsp = true,
                clangd = {
                capabilities = capabilities,
                root_dir = require('lspconfig').util.root_pattern("compile_commands.json", "compile_flags.txt", ".git"), 
                cmd = {"clangd"},
                filetypes = { "c", "cpp", "objc", "objcpp"},
                settings = { 
                    clangd = { 
                        compilationDatabasePath = "compile-commands.json",
                        },
                    }
                },
                tsserver = true,
                gopls = true
            }

            for name, config in pairs(language_server) do
                if config == true then
                    config = {}
                end
                config = vim.tbl_deep_extend("force", {}, {
                    capabilities = capabilities,
            }, config)
            lsp[name].setup({})
            end

	end,
}

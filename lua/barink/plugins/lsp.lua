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
            local ls = require("luasnip")
            ls.config.set_config({
                history = true,
                updateevents = "TextChanged, TextChangedI",
                enable_autosnippets = true,
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

            cmp.setup.filetype({ "sql"}, {
                sources = {
                    { name = "vim-dadbod-completion"},
                    { name = "buffer"} ,
                }
            })
            -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
            -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline(':', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = 'path' },
                    { name = 'buffer' }
                }, {
                    { name = 'cmdline' }
                }),
                matching = { disallow_symbol_nonprefix_matching = false }
            })


            vim.keymap.set({"i", "s"}, "<C-K>", function() ls.expand() end, {silent = true})
            vim.keymap.set({"i", "s"}, "<C-n>", function() ls.jump(1) end, {silent = true })
            vim.keymap.set({"i", "s"}, "<C-p>", function() ls.jump(-1) end, {silent = true})
            vim.keymap.set({"i", "s"}, "<C-E>", function()
                if ls.choice_active() then
                    ls.change_choice(1)
                end
            end, {silent = true})

            require("luasnip.loaders.from_lua").load({paths= "~/.config/nvim/lua/barink/snippets"})


            -- Set up lspconfig.
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            local lsp = require("lspconfig")

            local language_server = {
                asm_lsp= true,
                mojo = true,
                zls = true,
                emmet_language_server = true,
                rust_analyzer = true,
                gdtoolkit = { flags = { debounce_text_changes = 150 }},
                jdtls = true,
                pylsp = true,
                phpactor = {
                    init_options = {
                        ["language_server_phpstan.enabled"] = false,
                        ["language_server_psalm.enabled"] = false,
                    }
                },
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
                ts_ls = true,
                gopls = true,
                intelephense = true,
                lua_ls = {
                    settings = {
                        Lua = {
                            diagnostics = {
                                globals = { 'vim'}
                            }
                        }
                    }
                },
            }

            for name, config in pairs(language_server) do
                if config == true then
                    config = {}
                end
                config = vim.tbl_deep_extend("force", {}, { capabilities = capabilities }, config)
                lsp[name].setup({})
            end
            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function (args)
                    local client = assert(vim.lsp.get_client_by_id(args.data.client_id), "must have valid client")

                    local settings = language_server[client.name]
                    if type(settings) ~= "table" then
                        settings = {}
                    end

                    local builtin = require "telescope.builtin"

                    vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"
                    vim.keymap.set("n", "gd", builtin.lsp_definitions, {buffer = -1})
                    vim.keymap.set("n", "gr", builtin.lsp_references, {buffer = -1})
                    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {buffer = -1})
                    vim.keymap.set("n", "gT", vim.lsp.buf.type_definition, {buffer = -1})
                    vim.keymap.set("n", "K", vim.lsp.buf.hover, {buffer = -1})

                    vim.keymap.set("n", "<LEADER>cr", vim.lsp.buf.rename, {buffer =-1})
                    vim.keymap.set("n", "<LEADER>ca", vim.lsp.buf.code_action, {buffer = -1})
                    vim.keymap.set("n", "<LEADER>wd", builtin.lsp_document_symbols, {buffer = -1})


                end
        })
	end,
}

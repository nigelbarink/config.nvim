return
{
    "williamboman/mason.nvim",
    dependencies = {
        "williamboman/mason-lspconfig",
        { 'mfussenegger/nvim-jdtls', dependencies = { 'nvim-dap' } },
    },
    config = function()
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = { "lua_ls", "bashls", "rust_analyzer" }
        })

        -- Set up lspconfig.
        local capabilities = require("cmp_nvim_lsp").default_capabilities()

        for _, data in ipairs(capabilities) do
            print(data)
        end


        local language_server = {
            asm_lsp = true,
            mojo = true,
            zls = true,
            emmet_language_server = true,
            rust_analyzer = true,
            --gdtoolkit = { flags = { debounce_text_changes = 150 }},
            jdtls = true,
            pylsp = true,
            phpactor = {
                init_options = {
                    ["language_server_phpstan.enabled"] = false,
                    ["language_server_psalm.enabled"] = false,
                }
            },
            clangd = {
                root_dir = vim.fs.root(0, { 'compile_commands.json', 'compile_flags.txt', '.git' }),
                cmd = { "clangd" },
                filetypes = { "c", "cpp", "objc", "objcpp" },
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
                cmd = { "lua-language-server" },
                filetypes = { 'lua' },
                settings = {
                    Lua = {
                        runtime = {
                            version = 'LuaJIT',
                        },
                        diagnostics = {
                            globals = { 'vim' }
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
            vim.lsp.config(name, config)
            vim.lsp.enable(name)
        end
        vim.api.nvim_create_autocmd("LspAttach", {
            callback = function(args)
                local client = assert(vim.lsp.get_client_by_id(args.data.client_id), "must have valid client")

                local settings = language_server[client.name]
                if type(settings) ~= "table" then
                    settings = {}
                end

                local builtin = require "telescope.builtin"

                vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"
                vim.keymap.set("n", "gd", builtin.lsp_definitions, { buffer = -1 })
                vim.keymap.set("n", "gr", builtin.lsp_references, { buffer = -1 })
                vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = -1 })
                vim.keymap.set("n", "gT", vim.lsp.buf.type_definition, { buffer = -1 })
                vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = -1 })

                vim.keymap.set("n", "<LEADER>cr", vim.lsp.buf.rename, { buffer = -1 })
                vim.keymap.set("n", "<LEADER>ca", vim.lsp.buf.code_action, { buffer = -1 })
                vim.keymap.set("n", "<LEADER>wd", builtin.lsp_document_symbols, { buffer = -1 })
            end
        })
    end,
}


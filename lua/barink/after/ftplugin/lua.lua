

local lsp = require("lspconfig")
lsp.lua_ls.setup({
    capabilities = require('cmp_nvim_lsp').default_capabilities(),
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }
            }
        }
    }
})


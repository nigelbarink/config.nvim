-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()

require('lspconfig')['zls'].setup({
    capabilities = capabilities
})

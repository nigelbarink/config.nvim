-- Set basic vim options
vim.opt.guicursor = ""

vim.opt.nu = true
vim.opt.relativenumber = true

local tab_spacing = 4
vim.opt.tabstop = tab_spacing
vim.opt.softtabstop = tab_spacing
vim.opt.shiftwidth = tab_spacing
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8

vim.g.netrw_browse_split = 0
vim.g.netrw_winsize = 25

vim.opt.completeopt = {'menu', 'menuone', 'noselect' }

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function (args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client.server_capabilities.hoverProvider then
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, {buffer = args.buf})
        end
    end,
})

--[[
-- Run zig test on save 
-- TODO: fix vim.cmd call 
-- TODO: only do this when a zig test file is open 
vim.api.nvim_create_autocmd('BufWritePost' , {
    callback = function ()
        vim.cmd{cmd = '!zig' , args= {'test', vim.fn.expand('%')} }
    end
})]]--




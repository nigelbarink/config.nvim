-- Keymaps
vim.g.mapleader = " "

vim.keymap.set('n', '<leader><F8>', vim.cmd.UndotreeToggle)
vim.keymap.set('n', '<leader>p', [["_dP]])
vim.keymap.set('n', '<leader>fa', vim.lsp.buf.format)
vim.keymap.set('n', '<leader>m', ":Mason<CR>")
vim.keymap.set('n', '<leader>e',':Explore<CR>',  {noremap = false, silent=true})
vim.keymap.set('n', '<leader>le',':Lexplore<CR>',  {noremap = false, silent=true})
vim.keymap.set('n', '<leader>l', ':Neotree<CR>', {noremap = false, silent= true})
-- Move lines while in visual mode 
vim.keymap.set('v', '<A-S-j>', ':m \'>+1<CR>gv=gv', {noremap = true})
vim.keymap.set('v', '<A-S-k>', ':m \'<-2<CR>gv=gv', {noremap = true})

-- Move lines while in normal mode 
vim.keymap.set('n', '<A-S-j>', ':m .+1<CR>==', {noremap = true})
vim.keymap.set('n', '<A-S-k>', ':m .-2<CR>==', {noremap = true})

-- Move line in edit mode 
vim.keymap.set('i', '<A-j>', ':m .+1<CR>==gi', {noremap = true})
vim.keymap.set('i', '<A-k>', ':m .-2<CR>==gi', {noremap = true})

-- Diagnostics !
vim.keymap.set('n', '<C-T>', function() require('trouble').toggle() end )
vim.keymap.set('n', '<leader>d', function ()  vim.diagnostic.open_float() end )
vim.keymap.set('n', '<leader>dn', function () vim.diagnostic.goto_next() end )
vim.keymap.set('n', '<leader>dp', function () vim.diagnostic.goto_prev() end )
vim.keymap.set('n', '<C-d>', function () vim.lsp.buf.code_action() end)
-- Debugging
vim.keymap.set('n', '<leader>sb', function () require('dap').toggle_breakpoint() end )
vim.keymap.set('n', '<leader>db', function () require('dapui').toggle() end )
vim.keymap.set('n', '<F5>', function () print("Start debug session" ) require('dap').continue() end )
vim.keymap.set('n', '<F6>', function () require('dap').step_over() end )
vim.keymap.set('n', '<F7>', function () require('dap').step_into() end )

vim.keymap.set('n', '<leader>=',":Gen Generate<CR>")

-- Keymaps
vim.g.mapleader = " "

vim.keymap.set('n', '<leader><F8>', vim.cmd.UndotreeToggle)
vim.keymap.set('n', '<leader>p', [["_dP]])
vim.keymap.set('n', '<leader>fa', vim.lsp.buf.format)
vim.keymap.set('n', '<leader>m', ":Mason<CR>")
vim.keymap.set('n', '<leader>e',':Explore<CR>',  {noremap = false, silent=true})
vim.keymap.set('n', '<leader>le',':Lexplore<CR>',  {noremap = false, silent=true})
local osname = vim.loop.os_uname().sysname
if osname == "Windows_NT" then
    vim.keymap.set('n', '<leader>x', function() print("sorry this is windows!") end)
elseif osname == "Linux" then
    -- Linux only!!
    vim.keymap.set('n', '<leader>x', "<cmd>!chmod +x %<CR>", { silent = true })
end
-- Move lines while in visual mode 
vim.keymap.set('v', '<A-j>', ':m \'>+1<CR>gv=gv', {noremap = true})
vim.keymap.set('v', '<A-k>', ':m \'<-2<CR>gv=gv', {noremap = true})
-- Move lines while in normal mode 
vim.keymap.set('n', '<A-j>', ':m .+1<CR>==', {noremap = true})
vim.keymap.set('n', '<A-k>', ':m .-2<CR>==', {noremap = true})
-- Move line in edit mode 
vim.keymap.set('i', '<A-j>', ':m .+1<CR>==gi', {noremap = true})
vim.keymap.set('i', '<A-k>', ':m .-2<CR>==gi', {noremap = true})

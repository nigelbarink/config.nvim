-- Keymaps
vim.g.mapleader = " "

vim.keymap.set('n', '<leader><F8>', vim.cmd.UndotreeToggle)
vim.keymap.set('n', '<leader>p', [["_dP]])
vim.keymap.set('n', '<leader>fa', vim.lsp.buf.format)
vim.keymap.set('n', '<leader>m', ":Mason<CR>")
local osname = vim.loop.os_uname().sysname
if osname == "Windows_NT" then
    print("Windows Detected!!")
    vim.keymap.set('n', '<leader>x', function() print("sorry this is windows!") end)
elseif osname == "Linux" then
    -- Linux only!!
    vim.keymap.set('n', '<leader>x', "<cmd>!chmod +x %<CR>", { silent = true })
end

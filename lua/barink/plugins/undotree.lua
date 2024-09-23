return {
    "mbbill/undotree",
    config = function () 
        vim.keymap.set('n', '<leader><f1>', vim.cmd.UndotreeToggle)
    end
}

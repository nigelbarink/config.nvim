require("barink.vim")
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)
require("barink.keys")
require("lazy").setup("barink.plugins" , {
    root = vim.fn.stdpath("data") .. "/lazy", -- directory where plugins will be installed
    -- leave nil when passing the spec as the first argument to setup()
    change_detection = {
      -- automatically check for config file changes and reload the ui
      enabled = false,
      notify = true, -- get a notification when changes are found
    },

})

vim.keymap.set("n", "<space>pa", function()
  package.loaded["php.artisan"] = nil
  require("php.artisan").telescope_select_artisan()
end)

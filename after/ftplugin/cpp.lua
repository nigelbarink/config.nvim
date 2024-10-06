local tab_spacing = 2
vim.opt.tabstop = tab_spacing
vim.opt.softtabstop = tab_spacing
vim.opt.shiftwidth = tab_spacing
vim.opt_local.makeprg = 'msbuild .\\game.vcxproj /p:Configuration=Release /p:Platform=x64'

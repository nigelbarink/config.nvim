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
require("lazy").setup({
	{
	  "folke/tokyonight.nvim",
	  lazy = false,
	  priority = 1000,
	  opts = {},
      config = function ()
            require("tokyonight").setup({
            	style="night",
            	light_style="day",
            	transparent=true,
            	terminal_colors=true,
            	dim_inactive=false,
            	lualine_bold=false,
            })
            -- make transparent BG
--            vim.api.nvim_set_hl(0, "Normal", {bg = "none"})
--            vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none"})


            vim.cmd[[colorscheme tokyonight]]
        end
	},
	{
		"nvim-telescope/telescope.nvim", 
		dependencies = { 'nvim-lua/plenary.nvim'}
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function ()
			local configs = require("nvim-treesitter.configs")

			configs.setup({
				ensure_installed = {"c", "lua", "vim", "vimdoc", "bash"},
				sync_install = false,
				highlight = { enable = true },
				indent = { enable = true },
			})
			end
	},
	{"mbbill/undotree"},
	{ 'VonHeikemen/lsp-zero.nvim', branch='v3.x'},
	{'neovim/nvim-lspconfig'},
	{'hrsh7th/cmp-nvim-lsp'},
	{'hrsh7th/nvim-cmp'},
	{'L3MON4D3/LuaSnip'},
	{'tpope/vim-fugitive'},

}, {})

local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
	-- see :help lsp-zero-keybindings
	-- to learn the available actions
	lsp_zero.default_keymaps({buffer = bufnr})
end)

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

-- Keymaps 
vim.g.mapleader = " " 

local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fs', builtin.git_files, {})

vim.keymap.set('n', '<leader><F8>', vim.cmd.UndotreeToggle)

vim.keymap.set('n', '<leader>p', [["_dP]])
vim.keymap.set('n', '<leader>f', vim.lsp.buf.format)

osname = vim.loop.os_uname().sysname
if osname == "Windows_NT" then 
    print("Windows Detected!!")
    vim.keymap.set('n', '<leader>x', function() print("sorry this is windows!")end)
elseif osname == "Linux"  then 
    -- Linux only!!
    vim.keymap.set('n', '<leader>x', "<cmd>!chmod +x %<CR>", { silent =true })
end


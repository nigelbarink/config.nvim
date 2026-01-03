return {
    'L3MON4D3/LuaSnip',
    dependencies = {
        'hrsh7th/nvim-cmp',
        'rafamadriz/friendly-snippets',
    },
    version = "v2.*",
    config = function()
        local ls = require("luasnip")
        ls.config.set_config({
            history = true,
            updateevents = "TextChanged, TextChangedI",
            enable_autosnippets = true,
        })
        vim.keymap.set({ "i", "s" }, "<C-K>", function() ls.expand() end, { silent = true })
        vim.keymap.set({ "i", "s" }, "<C-n>", function() ls.jump(1) end, { silent = true })
        vim.keymap.set({ "i", "s" }, "<C-p>", function() ls.jump(-1) end, { silent = true })
        vim.keymap.set({ "i", "s" }, "<C-E>", function()
            if ls.choice_active() then
                ls.change_choice(1)
            end
        end, { silent = true })
        require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/lua/barink/snippets" })
        require("luasnip.loaders.from_vscode").lazy_load()
    end
}

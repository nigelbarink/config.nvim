return {
    "folke/edgy.nvim",
    event = "VeryLazy",
    opts= {
        bottom ={
            {
                ft = "toggleterm",
                size = { height = 0.4 },
                filter = function (_,  win)
                    return vim.api.nvim_win_get_config(win).relative == ""
                end,
            },
            {
                ft = "lazyterm",
                title = "Lazyterm",
                size = { height = 0.4 },
                filter = function(buf, _)
                    return not vim.b[buf].lazyterm_cmd
                end
            }
    },
    init = function ()
        vim.opt.laststatus = 3
        vim.opt.splitkeep = "screen"
    end,
    }
}



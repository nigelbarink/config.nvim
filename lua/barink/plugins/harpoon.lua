return {
    "ThePrimeagen/harpoon",
    branch= "harpoon2",
    dependencies = {
        {"nvim-lua/plenary.nvim"},
        {"nvim-telescope/telescope.nvim"}
    },
    config = function()
        local harpoon = require("harpoon")
        harpoon.setup()

        vim.keymap.set("n", "ha", function() harpoon:list():add() end)
        vim.keymap.set("n", "hh", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
        local conf = require("telescope.config").values
        local function toggle_telescope(harpoon_files)
            local file_paths = {}
            for _, item in ipairs(harpoon_files.items) do
                table.insert(file_paths, item.value)
            end

            require("telescope.pickers").new({}, {
                result = file_paths,
                previewer = conf.file_previewer({}),
                sorter = conf.generic_sorter({}),
            }):find()
        end

        vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end)
        vim.keymap.set("n", "<leader>hh", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
        vim.keymap.set("n", "<leader>fe", function () toggle_telescope(harpoon:list()) end, { desc = "Open harpoon window"} )
        vim.keymap.set("n", "C-1", function() harpoon:list():select(1) end)
        vim.keymap.set("n", "C-2", function() harpoon:list():select(2) end)
        vim.keymap.set("n", "C-3", function() harpoon:list():select(3) end)
        vim.keymap.set("n", "C-4", function() harpoon:list():select(4) end)


        vim.keymap.set("n", "<C-,>", function() harpoon:list():prev() end)
        vim.keymap.set("n", "<C-.>", function() harpoon:list():next() end)

    end
}

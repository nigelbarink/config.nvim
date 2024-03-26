function ColorMyPencils(color)
    color = color or "tokyonight"
    vim.cmd.colorscheme(color)

    -- make transparent BG
     vim.api.nvim_set_hl(0, "Normal", {bg = "none"})
     vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none"})
end

ColorMyPencils()

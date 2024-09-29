local ls = require("luasnip")

local s = ls.snippet
local t = ls.text_node

-- https://github.com/L3MON4D3/LuaSnip/blob/master/DOC.md
return {
    s("novel", {
        t("It was a dark and stormy night on")
        }),

    s("no", {
        t("hello world!")
    }),
}

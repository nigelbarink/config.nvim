
local ls = require("luasnip")

local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

-- https://github.com/L3MON4D3/LuaSnip/blob/master/DOC.md
return {
    s("req", fmt("local {} = require('{}')", { i(1, "default"), require("luasnip.extras").rep(1)}))
}

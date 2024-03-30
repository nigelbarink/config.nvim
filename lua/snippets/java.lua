local ls = require("luasnip")

local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

-- https://github.com/L3MON4D3/LuaSnip/blob/master/DOC.md
return {
    s(
        "main",
        fmt([[
        static void main (){{
            {a} 
        }}
        ]],
    {a = i(1)}
    )),
    s("sout", fmt("System.out.println(\"{}\");", { i(1, "My message")})),
    s("soutm", t("System.out.println(\"$CLASS_NAME$.$METHOD_NAME$\");")),
    s("soutp", t("System.out.println(\"$FORMAT$\");")),
    s("soutv", t("System.out.println(\"$EXPR_COPY$ = \" + $EXPR$);")),
}

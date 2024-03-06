local ls = require("luasnip")
local t = ls.text_node
local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

local function hdesc(trig)
  return { trig = trig, desc = "https://docs.asciidoctor.org/asciidoc/latest/sections/titles-and-levels/", }
end
local function adesc(trig)
  return { trig = trig, desc = "https://docs.asciidoctor.org/asciidoc/latest/blocks/admonitions/", }
end
local function fdesc(trig)
  return { trig = trig, desc = "https://docs.asciidoctor.org/asciidoc/latest/text/", }
end

ls.add_snippets("asciidoc", {
  -- typography:
  s(fdesc("#"), fmt("#{}#", { i(1, "Highlight text") })),
  s(fdesc("*"), fmt("*{}*", { i(1, "Bold text") })),
  s(fdesc("_"), fmt("_{}_", { i(1, "Italic text") })),
  s(fdesc("+"), fmt("+{}+", { i(1, "Monospace text") })),
  s(fdesc("`"), fmt("`{}`", { i(1, "Command text") })),
  s(fdesc("'"), fmt("'`{}`'", { i(1, "Single-quoted text") })),
  s(fdesc('"'), fmt('"`{}`"', { i(1, "Double-quoted text") })),
  s(fdesc("^"), fmt("^{}^", { i(1, "Superscripted") })),
  s(fdesc("~"), fmt("~{}~", { i(1, "Subscripted") })),
  s(fdesc("text property"), fmt("[{}]#{}#", { i(1, "red"), i(2, "Custom formatted text") })),
  s(fdesc("br"), fmt("+\n{}", { i(1, "Forced line break") })),
  s(fdesc("hr"), fmt("''''\n{}", { i(1, "Horizontal line") })),
  s(fdesc("comment"), fmt("// {}", { i(1, "Comment") })),
  -- sections:
  s(hdesc("h0"), fmt("= {}\n\n\n", { i(1, "Document Title") })),
  s(hdesc("h1"), fmt("== {}\n\n\n", { i(1, "Section") })),
  s(hdesc("h2"), fmt("=== {}\n\n\n", { i(1, "Subsection") })),
  s(hdesc("h3"), fmt("==== {}\n\n\n", { i(1, "Sub²section") })),
  s(hdesc("h4"), fmt("===== {}\n\n\n", { i(1, "Sub³section") })),
  s(hdesc("h5"), fmt("====== {}\n\n\n", { i(1, "Sub⁴section") })),
  s(hdesc("h6"), fmt(".{}\n", { i(1, "Paragraph/Block Title until next empty line / end of block") })),
  -- admonitions:
  s(adesc("NOTE"), fmt("NOTE: {}\n\n\n", { i(1, "Note paragraph until next empty line") })),
  s(adesc("TIP"), fmt("TIP: {}\n\n\n", { i(1, "Tip paragraph until next empty line") })),
  s(adesc("IMPORTANT"), fmt("IMPORTANT: {}\n\n\n", { i(1, "Important paragraph until next empty line") })),
  s(adesc("CAUTION"), fmt("CAUTION: {}\n\n\n", { i(1, "Caution paragraph until next empty line") })),
  s(adesc("WARNING"), fmt("WARNING: {}\n\n\n", { i(1, "Warning paragraph until next empty line") })),
  -- lists:
  s({ trig = "bullet list", desc = "https://docs.asciidoctor.org/asciidoc/latest/lists/unordered/" },
    fmt("* {}\n\t- {}\n*** {}\n\n\n", { i(1, "Top bullet"), i(2, "Nested bullet"), i(3, "Nest²ed bullet") })),
  s({ trig = "ordered list", desc = "https://docs.asciidoctor.org/asciidoc/latest/lists/ordered/" },
    fmt("1. {}\n\ta. {}\n\t\tA. {}\n.... {}\n\n\n",
      { i(1, "Top bullet"), i(2, "Nested bullet"), i(3, "Nest²ed bullet"), i(4, "Nest³ed bullet (1.->a.->i.->A.->I.)") })),
  s({ trig = "checklist", desc = "https://docs.asciidoctor.org/asciidoc/latest/lists/checklist/" },
    fmt("* [ ] {}\n* [x] {}\n\n\n", { i(1, "Checked"), i(2, "Unchecked") })),
  s({ trig = "description list", desc = "https://docs.asciidoctor.org/asciidoc/latest/lists/description/" },
    fmt("{}:: {}\n{}::: {}\n[horizontal]\n{}:::: {}\n\n\n", {
      i(1, "Term"), i(2, "Definition"),
      i(3, "Nested term"), i(4, "Nested definition"),
      i(5, "Definition on the same line"), i(6, "Modifier on for first bullet of a level, and applies to that level"),
    })),
  s({ trig = "Q&A", desc = "https://docs.asciidoctor.org/asciidoc/latest/lists/qanda/" },
    fmt("[qanda]\n{}:: {}\n\n\n", { i(1, "Numbered list with Q&A"), i(2, "Modifier only works properly on top level") })),
  -- blocks:
  s({ trig = "listing", desc = "https://docs.asciidoctor.org/asciidoc/latest/verbatim/listing-blocks/" },
    fmt("----\n{}\n----\n\n", { i(1, "Listing block") })),
  s({ trig = "code", desc = "https://docs.asciidoctor.org/asciidoc/latest/verbatim/source-blocks/" },
    fmt("[source, {}]\n____\n{}\n____\n\n", { i(1, "cpp"), i(2, "// Code block") })),
  s({ trig = "quote", desc = "https://docs.asciidoctor.org/asciidoc/latest/blocks/blockquotes/" },
    fmt("[quote, {}, {}]\n----\n{}\n----\n\n", { i(1, "Author"), i(2, "Source Reference"), i(3, "Quote block") })),
  s({ trig = "sidebar", desc = "https://docs.asciidoctor.org/asciidoc/latest/blocks/sidebars/" },
    fmt("****\n{}\n****\n\n", { i(1, "Sidebar block") })),
  s({ trig = "example", desc = "https://docs.asciidoctor.org/asciidoc/latest/blocks/example-blocks/" },
    fmt("====\n{}\n====\n\n", { i(1, "Example block") })),
  s(adesc("note"), fmt("[NOTE]\n====\n{}\n====\n\n", { i(1, "Note block") })),
  s({ trig = "literal", desc = "https://docs.asciidoctor.org/asciidoc/latest/verbatim/literal-blocks/" },
    fmt("....\n{}\n....\n\n", { i(1, "Literal block") })),
  s({ trig = "passthrough", desc = "https://docs.asciidoctor.org/asciidoc/latest/pass/pass-block/" },
    fmt("++++\n{}\n++++\n\n", { i(1, "Passthrough block (i.e. backend markup)") })),
  -- tables:
  s({ trig = "table", desc = "https://docs.asciidoctor.org/asciidoc/latest/tables/build-a-basic-table/" },
    fmt("|====\n|{}|{}\n\n|{}|{}\n|====\n\n", { i(1, "Header A"), i(2, "B"), i(3, "1A"), i(4, "1B") })),
  s({ trig = "CSV table", desc = "https://docs.asciidoctor.org/asciidoc/latest/tables/data-format/#csv-and-tsv" },
    fmt('[format="csv",options="header"]\n|====\ninclude::{}[]\n|====\n\n', { i(1, "file.csv") })),
})

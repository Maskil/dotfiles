function Meta(meta)
  meta["header-includes"] = pandoc.MetaBlocks({
    pandoc.RawBlock("latex", "\\usepackage{fancyhdr}"),
    pandoc.RawBlock("latex", "\\pagestyle{fancy}"),
    pandoc.RawBlock("latex", "\\lhead{}"),
    pandoc.RawBlock("latex", "\\rhead{}"),
    pandoc.RawBlock("latex", "\\renewcommand{\\headrulewidth}{0pt}"),
  })
  return meta
end
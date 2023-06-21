function neocomposer()
  return "Hola"
end

return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      table.insert(opts.sections.lualine_c, require('NeoComposer.ui').status_recording)
      table.insert(opts.sections.lualine_x, neocomposer)
    end,
    dependencies = {
      "ecthelionvi/NeoComposer.nvim",
    }
  },
}

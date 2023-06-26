function neocomposer()
  if vim.g.VIRA_ISSUE then
    return vim.g.VIRA_ISSUE
  end
  return ""
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
      'linrongbin16/lsp-progress.nvim',
    }
  },
}

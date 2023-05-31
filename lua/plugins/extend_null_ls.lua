return {
  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function(_, opts)
      opts.sources = {
        require("null-ls").builtins.formatting.shfmt,        -- shell script formatting
        require("null-ls").builtins.formatting.prettier,     -- markdown formatting
        require("null-ls").builtins.diagnostics.shellcheck,  -- shell script diagnostics
        require("null-ls").builtins.code_actions.shellcheck, -- shell script code actions
        require("null-ls").builtins.formatting.google_java_format
      }
    end,
  },
}

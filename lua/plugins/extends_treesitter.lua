return {
  {
    "HiPhish/nvim-ts-rainbow2",
    lazy = true,
  },
  {
    "nvim-treesitter/nvim-treesitter",

    dependencies = { "HiPhish/nvim-ts-rainbow2" },
    opts = function(_, opts)
      opts.rainbow = {
        enable = true,
        query = "rainbow-parens",
        strategy = require("ts-rainbow").strategy.global,
      }
    end,
    -- opts = {
    --   -- rainbow = {
    --   --   enable = true,
    --   --   query = "rainbow-parens",
    --   --   strategy = require("ts-rainbow").strategy.global,
    --   -- },
    --   highlight = { enable = true, disable = { "yaml" } },
    --   ensure_installed = { "go", "gomod", "java", "html", "css", "terraform", "hcl" },
    --   ignore_install = { "help" }
    -- }
  }
}

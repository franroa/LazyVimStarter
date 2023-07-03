return {
  {
    "L3MON4D3/LuaSnip",
    keys = function()
      return {}
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-emoji",
      "hrsh7th/cmp-cmdline",
    },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        prevCharacter = vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%w") or "nil"
        postCharacter = vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col + 1, col + 1):match("%p") or "nil"

        vim.notify("Prev char: " .. prevCharacter)
        vim.notify("Post char: " .. postCharacter)

        return col ~= 0 and prevCharacter == nil and postCharacter == nil
      end

      local luasnip = require("luasnip")
      local cmp = require("cmp")
      -- opts.formatting = {
      --   format = function(_, item)
      --     local icons = require("lazyvim.config").icons.kinds
      --     if icons[item.kind] then
      --       item.kind = icons[item.kind] .. item.kind
      --     end
      --     return item
      --   end,
      -- }
      opts.sources = cmp.config.sources(vim.list_extend(opts.sources,
        { { name = "emoji" }, { name = "cmdline" }, { name = "codeium" } }))
      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        ['<Tab>'] = function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif has_words_before() then -- TODO: add this but check also that
            cmp.complete()
          elseif luasnip.expand_or_jumpable() then
            vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-expand-or-jump', true, true, true), '')
          else
            fallback()
          end
        end,
        ['<S-Tab>'] = function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-jump-prev', true, true, true), '')
          else
            fallback()
          end
        end,
        --   ["<Tab>"] = cmp.mapping(function(fallback)
        --     if cmp.visible() then
        --       cmp.select_next_item()
        --       -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
        --       -- this way you will only jump inside the snippet region
        --     elseif luasnip.expand_or_jumpable() then
        --       luasnip.expand_or_jump()
        --     elseif has_words_before() then
        --       cmp.complete()
        --     else
        --       fallback()
        --     end
        --   end, { "i", "s" }),
        --   ["<S-Tab>"] = cmp.mapping(function(fallback)
        --     if cmp.visible() then
        --       cmp.select_prev_item()
        --     elseif luasnip.jumpable(-1) then
        --       luasnip.jump(-1)
        --     else
        --       fallback()
        --     end
        --   end, { "i", "s" }),
      })
    end,
  }
}

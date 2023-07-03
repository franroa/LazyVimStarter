return { {
  "neovim/nvim-lspconfig",
  keys = {
    {
      "<leader>uN",
      function()
        require("nvim-navbuddy").open()
      end,
      desc = "Navbuddy"
    },
  },
  dependencies = {
    {
      "SmiteshP/nvim-navbuddy",
      dependencies = {
        "SmiteshP/nvim-navic",
        "MunifTanjim/nui.nvim"
      },
      opts = { lsp = { auto_attach = true } }
    }
  },
  opts = {
    inlay_hints = { enabled = true },
    ensure_installed = {
      "helm-ls",
      "gopls",
      "dockerls",
      "bashls",
      "awk_ls",
      "jsonls",
      "emmet_ls",
      "marksman",
      "gradle_ls",
      "lua_ls",
      "golangci_lint_ls ",
    },
    automatic_installation = true,
    servers = {
      html = {
        filetypes = { "html", "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact",
          "typescript.tsx" },
      },
      -- Emmet
      emmet_ls = {
        init_options = {
          html = {
            options = {
              -- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
              ["bem.enabled"] = true,
            },
          },
        },
      },
      -- CSS
      cssls = {},
      gradle_ls = {
        cmd = {
          vim.env.HOME
          ..
          "/.local/share/nvim/vscode-gradle/gradle-language-server/build/install/gradle-language-server/bin/gradle-language-server",
        },
        root_dir = function(fname)
          return util.root_pattern(unpack { "settings.gradle", "settings.gradle.kts" })(fname)
              or util.root_pattern(unpack { "build.gradle" })(fname)
        end,
        filetypes = { "groovy", "kotlin" },
      },
      gopls = {
        settings = {
          gopls = {
            analyses = {
              unusedparams = true,
            },
            hints = {
              assignVariableTypes = true,
              compositeLiteralFields = true,
              compositeLiteralTypes = true,
              constantValues = true,
              functionTypeParameters = true,
              parameterNames = true,
              rangeVariableTypes = true,
            },
            staticcheck = true,
            semanticTokens = true,
          },
        },
      },
      golangci_lint_ls = {},
      jsonls = {},
      lua_ls = {
        -- mason = false, -- set to false if you don't want this server to be installed with mason
        settings = {
          Lua = {
            workspace = {
              checkThirdParty = false,
            },
            completion = {
              callSnippet = "Replace",
            },
          },
        },
      },
      helm_ls = {},
    },
    -- add any global capabilities here
    capabilities = {
      textDocument = {
        completion = { completionItem = { snippetSupport = true, } },
        foldingRange = {
          dynamicRegistration = false,
          lineFoldingOnly = true,
        }
      },
    },
    flags = {
      debounce_text_changes = 150,
    },
    --     -- setup = {
    --     -- gopls = function(_, _)
    --     --   local lsp_utils = require("lazyvim.util")
    --     --   lsp_utils.on_attach(function(client, bufnr)
    --     --     local map = function(mode, lhs, rhs, desc)
    --     --       if desc then
    --     --         desc = desc
    --     --       end
    --     --       vim.keymap.set(mode, lhs, rhs, { silent = true, desc = desc, buffer = bufnr, noremap = true })
    --     --     end
    --     --     -- stylua: ignore
    --     --     if client.name == "gopls" then
    --     --       map("n", "<leader>ly", "<cmd>GoModTidy<cr>", "Go Mod Tidy")
    --     --       map("n", "<leader>lc", "<cmd>GoCoverage<Cr>", "Go Test Coverage")
    --     --       map("n", "<leader>lt", "<cmd>GoTest<Cr>", "Go Test")
    --     --       map("n", "<leader>lR", "<cmd>GoRun<Cr>", "Go Run")
    --     --       map("n", "<leader>dT", "<cmd>lua require('dap-go').debug_test()<cr>", "Go Debug Test")
    --     --     end
    --     --   end)
    --     -- end,
    --     -- },
  },
} }





-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities.textDocument.completion.completionItem.snippetSupport = true
-- capabilities.textDocument.foldingRange = {
--   dynamicRegistration = false,
--   lineFoldingOnly = true,
-- }
-- M.capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities) -- for nvim-cmp
--
-- local opts = {
--   on_attach = M.on_attach,
--   capabilities = M.capabilities,
--   flags = {
--     debounce_text_changes = 150,
--   },
-- }

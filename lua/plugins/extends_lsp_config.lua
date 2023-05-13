return { {
  "neovim/nvim-lspconfig",
  opts = {
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

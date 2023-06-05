-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local function map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  -- do not create the keymap if a lazy keys handler exists
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

-- Visual --
-- Stay in indent mode
map("v", "<", "<gv", { desc = "indent with <" })
map("v", ">", ">gv", { desc = "indent with >" })
-- Prevent copy highlighted word
map("v", "p", '"_dP', { desc = "prevent copy highlighted word" })

-- indent empty line
map("n", 'i', function()
  if #vim.fn.getline(".") == 0 then
    return [["_cc]]
  else
    return "i"
  end
end, { expr = true })

map("n", "<leader>p", "<cmd>Telescope projects<cr>", { desc = "Telescope Projects" })

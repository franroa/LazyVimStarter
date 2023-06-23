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


-- Git commit template navigation
map("i", "<A-i>", function()
  vim.cmd("/^$")
  vim.cmd.stopinsert()
end)
map("n", "<A-i>", function()
  vim.cmd(":0")
  vim.cmd("/]:")
  vim.cmd("startinsert!")
end)

-- Commit
map({ 't', 'n' }, '<A-c>', function()
  vim.g.has_previous_terminal_to_be_set = false
  term = GetCurrentTerminal()
  if term ~= nil then
    term:toggle()
    vim.notify(term)
  end

  vim.g.is_lazygit_opened = true
  vim.cmd("Git commit")
end)

-- Terminal TODO: move to toggleterm lua plugin file
vim.g.has_previous_terminal_to_be_set = true

map('t', '<esc>', [[<C-\><C-n>]])
map('t', '<esc>', [[<C-\><C-n>]])
map('t', '<C-h>', function()
  vim.g.has_previous_terminal_to_be_set = true
  vim.cmd("wincmd h")
end)
map('t', '<C-j>', function()
  vim.g.has_previous_terminal_to_be_set = true
  vim.cmd("wincmd j")
end)
map('t', '<C-k>', function()
  vim.g.has_previous_terminal_to_be_set = true
  vim.cmd("wincmd k")
end)
map('t', '<C-l>', function()
  vim.g.has_previous_terminal_to_be_set = true
  vim.cmd("wincmd l")
end)
map('t', '<C-w>', [[<C-\><C-n><C-w>]])


map({ 't', 'n' }, '<A-s>', function()
  vim.cmd("Telescope termfinder")
end)

-- Quit terminal: TODO: make it gracefully
map({ 't', 'n' }, '<A-e>', function()
  vim.g.has_previous_terminal_to_be_set = false
  GetCurrentOrPreviousTerminal():shutdown()
end)

-- Hover current terminal
map({ 't', 'n' }, '<A-h>', function()
  vim.g.has_previous_terminal_to_be_set = false
  local current_term = GetCurrentOrPreviousTerminal()
  for _, term in pairs(GetAllTerminals()) do
    if term.name ~= current_term.name then
      term:close()
    end
  end
end)

-- -- Get Previous Terminal
map({ 't', 'n' }, '<A-p>', function()
  if vim.g.previous_terminal then
    vim.g.has_previous_terminal_to_be_set = true
    term = GetTerminalByName(vim.g.previous_terminal.name)
    if term:is_open() then
      term:focus()
      return
    end
    term:toggle()
  end
end)

-- Hide all terminals
map({ 't', 'n' }, '<A-a>', function()
  vim.g.has_previous_terminal_to_be_set = false
  for _, term in pairs(GetAllTerminals()) do
    term:close()
  end
end)

-- Hide one terminal
map({ 't', 'n' }, '<A-t>', function()
  vim.g.has_previous_terminal_to_be_set = true
  GetCurrentOrPreviousTerminal():close()
end)

-- Open new terminal
map({ 't', 'n' }, '<A-o>', function()
  vim.g.has_previous_terminal_to_be_set = true
  OpenOrCreateTerminal({ instruction = vim.o.shell, name = vim.fn.expand("%:h"), dir = vim.fn.expand("%:h") })
end)

-- Open new terminal
map({ 't', 'n' }, '<A-n>', function()
  vim.g.has_previous_terminal_to_be_set = true
  ExecuteFunctionFromInput({
    prompt = "Terminal Name",
    fun = function(name)
      OpenOrCreateTerminal({ instruction = vim.o.shell, name = name })
    end
  })
end)

-- Format current terminal
map({ 't', 'n' }, '<A-f>', function()
  vim.g.has_previous_terminal_to_be_set = false
  local term = GetCurrentOrPreviousTerminal()
  if term.direction == "horizontal" then
    term.direction = "float"
  else
    term.direction = "horizontal"
  end

  term:close()
  term:toggle()
end)

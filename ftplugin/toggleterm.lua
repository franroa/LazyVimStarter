local function map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end
map('t', '<esc>', [[<C-\><C-n>]])
map('t', '<esc>', [[<C-\><C-n>]])
map('t', 'jk', [[<C-\><C-n>]])
map('t', '<C-h>', [[<Cmd>wincmd h<CR>]])
map('t', '<C-j>', [[<Cmd>wincmd j<CR>]])
map('t', '<C-k>', [[<Cmd>wincmd k<CR>]])
map('t', '<C-l>', [[<Cmd>wincmd l<CR>]])
map('t', '<C-w>', [[<C-\><C-n><C-w>]])

-- Commit
map({ 't', 'n' }, '<A-c>', function()
  term = GetCurrentTerminal()
  if term ~= nil then
    term:toggle()
  end

  vim.g.is_lazygit_opened = true
  vim.cmd("Git commit")
end)

map({ 't', 'n' }, '<A-s>', function()
  vim.cmd("Telescope termfinder")
end)

-- Quit terminal: TODO: make it gracefully
map({ 't', 'n' }, '<A-q>', function()
  GetCurrentTerminal():shutdown()
end)

-- Hover current terminal
map({ 't', 'n' }, '<A-h>', function()
  local current_term = GetCurrentTerminal()
  for _, term in pairs(GetAllTerminals()) do
    if term.name ~= current_term.name then
      term:close()
    end
  end
end)

-- -- Get Previous Terminal
map({ 't', 'n' }, '<A-o>', function()
  if vim.g.previous_terminal then
    term = GetTerminalByName(vim.g.previous_terminal.name)
    if term:is_open() then
      term:focus()
      return
    end
    term:toggle()
  end
end)

-- Hide all terminals
map({ 't', 'n' }, '<A-t>', function()
  for _, term in pairs(GetAllTerminals()) do
    term:close()
  end
end)

-- Hide one terminals
map('t', '<C-t>', function()
  GetCurrentTerminal():close()
end)

-- Open new terminal
map({ 't', 'n' }, '<A-n>', function()
  ExecuteFunctionFromInput({
    prompt = "Terminal Name",
    fun = function(name)
      OpenOrCreateTerminal({ instruction = vim.o.shell, name = name })
    end
  })
end)

-- Format current terminal
map({ 't', 'n' }, '<A-f>', function()
  local term = GetCurrentTerminal()
  if term.direction == "horizontal" then
    term.direction = "float"
  else
    term.direction = "horizontal"
  end

  term:close()
  term:toggle()
end)

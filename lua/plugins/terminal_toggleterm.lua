function _G.set_terminal_keymaps()
  local opts = { buffer = 0 }
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
  vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
end

function OpenOrCreateTerminal(opts)
  local namespace = vim.fn.system("echo -n $(kubie info ns 2>1)")
  local new_name = opts.name
  local display_name = "normal"
  if namespace ~= "" and opts.name ~= "k9s" then
    new_name = "(" .. namespace .. ") " .. opts.name
    display_name = "kubernetes"
  end

  if opts.name == "k9s" then
    display_name = "k9s"
  end

  local terms_table = require('toggleterm.terminal').get_all(true)
  for _, term in pairs(terms_table) do
    if term.name == new_name then
      vim.notify("There is already a terminal with that name!", "warning")
      require('toggleterm').toggle_all('close')
      term:toggle()
      return
    end
  end

  local Terminal = require('toggleterm.terminal').Terminal
  local context = vim.fn.system('echo -n "$(kubectl config current-context 2>1)"')

  if context ~= "" then
    context = string.format(
      "kubie ctx -n %s %s && ",
      namespace,
      context
    )
  end

  local customTerminal = Terminal:new({
    on_open = function(term)
      term.name = new_name
      vim.api.nvim_buf_set_name(term.bufnr, new_name)
    end,
    cmd = context .. opts.instruction,
    direction = opts.direction == nil and 'horizontal' or opts.direction,
    hidden = false,
    close_on_exit = false,
    name = new_name,
    display_name = display_name,
  })
  customTerminal:toggle()
  return customTerminal
  -- require("telescope._extensions.termfinder.actions").fran_rename_term(lazygit.bufnr, lazygit.id, name)
end

return {
  -- amongst your other plugins
  {
    "akinsho/toggleterm.nvim",
    dependencies = {
      -- which key integration
      {
        "folke/which-key.nvim",
        opts = function(_, opts)
          if require("lazyvim.util").has("noice.nvim") then
            opts.defaults["<leader>t"] = { name = "+terminal" }
            opts.defaults["<leader>tf"] = { name = "+format" }
          end
        end,
      },
    },
    keys = {
      {
        "<leader>td",
        function() OpenOrCreateTerminal({ instruction = "lazydocker", name = 'lazydocker', direction = 'tab' }) end,
        desc = "lazydocker"
      },
      {
        "<leader>tc",
        function() OpenOrCreateTerminal({ instruction = "ctop", name = 'ctop', direction = 'tab' }) end,
        desc = "ctop"
      },
      {
        "<leader>tg",
        function() OpenOrCreateTerminal({ instruction = "gitlab-ci-local", name = 'gitlab-local', direction = 'float' }) end,
        desc = "gitlab local"
      },
      {
        "<leader>ts",
        "<cmd>Telescope termfinder<cr>",
        desc = "Search terms"
      },
      {
        "<leader>tta",
        function()
          -- local bufnr = vim.api.nvim_get_current_buf()
          -- local _, term = require('toggleterm.terminal').identify(vim.api.nvim_buf_get_name(bufnr))
          -- if term == nil and Last_terminal_open == nil then
          --   vim.notify('No terminals are open')
          --   return
          -- end
          --
          -- if term ~= nil then
          --   Last_terminal_open = term
          -- end
          --
          -- Last_terminal_open:toggle()
        end,
        desc = "toggle all"
      },
      {
        "<leader>tt",
        function()
          local bufnr = vim.api.nvim_get_current_buf()
          local _, term = require('toggleterm.terminal').identify(vim.api.nvim_buf_get_name(bufnr))
          if term == nil and Last_terminal_open == nil then
            vim.notify('No terminals are open')
            return
          end

          if term ~= nil then
            Last_terminal_open = term
          end

          Last_terminal_open:toggle()
        end,
        desc = "toggle current terminal"
      },
      {
        "<leader>tn",
        function()
          local Terminal = require('toggleterm.terminal').Terminal
          local lazygit  = Terminal:new({
            direction = "horizontal",
            hidden = true,
            close_on_exit = false
          })
          lazygit:toggle()
        end,
        desc = "open new terminal"
      },
      {
        "<leader>tfh",
        function()
          for _, win in ipairs(vim.api.nvim_list_wins()) do
            local bufnr = vim.api.nvim_win_get_buf(win)
            if vim.bo[bufnr].buftype == 'terminal' then
              local _, term = require('toggleterm.terminal').identify(vim.api.nvim_buf_get_name(bufnr))
              if term == nil then
                vim.notify('No terminals are open')
                return
              end
              term.direction = "horizontal"
              term.display_name = "fran"
              term.name = "fran"
              term:toggle()
              term:toggle()
            end
          end
        end,
        desc = "toggle all to horizontal"
      },
      {
        "<leader>tff",
        function()
          for _, win in ipairs(vim.api.nvim_list_wins()) do
            local bufnr = vim.api.nvim_win_get_buf(win)
            if vim.bo[bufnr].buftype == 'terminal' then
              local _, term = require('toggleterm.terminal').identify(vim.api.nvim_buf_get_name(bufnr))
              if term == nil then
                vim.notify('No terminals are open')
                return
              end
              term.direction = "float"
              term.display_name = "fran"
              term.name = "fran"
              term:toggle()
              term:toggle()
            end
          end
        end,
        desc = "toggle all to float"
      },
      {
        "<leader>tf1",
        function()
          --
          -- TODO make it working with many buffers!
          local bufnr = vim.api.nvim_get_current_buf()
          local _, term = require('toggleterm.terminal').identify(vim.api.nvim_buf_get_name(bufnr))

          if term == nil then
            vim.notify('No terminals are open')
            return
          end

          if term.direction == "float" then
            return "<cmd>ToggleTerm<cr><cmd>ToggleTerm direction=horizontal<cr>"
          else
            return "<cmd>ToggleTerm<cr><cmd>ToggleTerm direction=float<cr>"
          end
        end,
        expr = true,
        desc = "toggle format (horizontal/float)"
      },
    },
    version = "*",
    config = true,
  },
}

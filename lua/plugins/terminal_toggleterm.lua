local split = require("functions.utils").split
function GetAllTerminals()
  return require('toggleterm.terminal').get_all(true)
end

function GetTerminalByName(name)
  local terms_table = require('toggleterm.terminal').get_all(true)
  for _, term in pairs(terms_table) do
    if term.name == name then
      return term
    end
  end
  return nil
end

function GetCurrentTerminal()
  local buf_name = vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf())
  local term_name = "(" .. split(buf_name, "(")[2]

  return GetTerminalByName(term_name)
end

function OpenOrCreateTerminal(opts)
  local namespace = vim.fn.system("echo -n $(kubie info ns 2>/dev/null)")
  local new_name = opts.name
  local display_name = "normal"
  if namespace ~= "" and opts.name ~= "k9s" or opts.non_k8s ~= false then
    new_name = "(" .. namespace .. ") " .. opts.name
    display_name = "kubernetes"
  end

  if opts.name == "k9s" then
    display_name = "k9s"
  end

  local term = GetTerminalByName(new_name)
  if term ~= nil then
    vim.notify("There is already a terminal with that name!", "warning")
    for _, other_term in pairs(GetAllTerminals()) do
      if term.name ~= other_term.name then
        term:close()
      end
    end
    if term:is_open() == false then
      term:toggle()
    end
    term:focus()
    return term
  end

  local Terminal = require('toggleterm.terminal').Terminal

  for _, bufnr in pairs(vim.api.nvim_list_bufs()) do
    if string.find(vim.api.nvim_buf_get_name(bufnr), new_name) then
      vim.api.nvim_buf_delete(bufnr, {})
      break
    end
  end

  local cmd = "CLUSTER=" .. vim.g.kubernetes_cluster .. " NAMESPACE=" .. vim.g.kubernetes_namespace .. " " ..
      opts.instruction

  local customTerminal = Terminal:new({
    on_create = function(term)
      term.name = new_name
      vim.api.nvim_buf_set_name(term.bufnr, new_name)
    end,
    cmd = cmd,
    direction = opts.direction == nil and 'horizontal' or opts.direction,
    hidden = false,
    close_on_exit = false,
    name = new_name,
    display_name = display_name,
  })
  customTerminal:toggle()
  return customTerminal
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
            opts.defaults["<leader>ft"] = { name = "+terminal" }
            opts.defaults["<leader>ftf"] = { name = "+format" }
          end
        end,
      },
    },
    keys = {
      {
        "<leader>ftd",
        function() OpenOrCreateTerminal({ instruction = "lazydocker", name = 'lazydocker', direction = 'tab' }) end,
        desc = "lazydocker"
      },
      {
        "<leader>ftc",
        function() OpenOrCreateTerminal({ instruction = "ctop", name = 'ctop', direction = 'tab' }) end,
        desc = "ctop"
      },
      {
        "<leader>ftg",
        function() OpenOrCreateTerminal({ instruction = "gitlab-ci-local", name = 'gitlab-local', direction = 'float' }) end,
        desc = "gitlab local"
      },
      {
        "<leader>fts",
        "<cmd>Telescope termfinder<cr>",
        desc = "Search terms"
      },
      {
        "<leader>ftta",
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
        "<leader>ftt",
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
        "<leader>ftn",
        function()
          ExecuteFunctionFromInput({
            prompt = "Terminal Name",
            fun = function(name) OpenOrCreateTerminal({ instruction = vim.o.shell, name = name }) end
          })
        end,
        desc = "open new terminal"
      },
      {
        "<leader>ftfh",
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
        "<leader>ftff",
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
        "<leader>ftf1",
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

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
  local splited_buf_name = split(buf_name, "(")
  if splited_buf_name[2] == nil then
    return nil
  end
  local term_name = "(" .. splited_buf_name[2]
  return GetTerminalByName(term_name)
end

function GetCurrentOrPreviousTerminal()
  local buf_name = vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf())
  local splited_buf_name = split(buf_name, "(")

  if splited_buf_name[2] == nil then
    if vim.g.previous_terminal then
      return vim.g.previous_terminal
    end
    return nil
  end

  local term_name = "(" .. splited_buf_name[2]

  local term = GetTerminalByName(term_name)

  if term then
    return term
  end

  return nil
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
    float_opts = {
      border = "double",
      width = function() return vim.o.columns end,
      height = function() return vim.o.lines end
    },
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
        "<leader>ftl",
        function()
          local lg_cmd = "lazygit -w $PWD"
          if vim.v.servername ~= nil then
            lg_cmd = string.format(
              "NVIM_SERVER=%s lazygit -ucf ~/.config/nvim/lazygit.toml -w $PWD",
              vim.v.servername)
          end

          -- TODO: https://github.com/mhinz/neovim-remote
          -- vim.env.GIT_EDITOR = "nvr -cc split --remote-wait +'set bufhidden=wipe'"

          OpenOrCreateTerminal({ instruction = lg_cmd, name = 'lazygit', direction = 'tab' })
        end,
        desc = "lazygit"
      },
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
    },
    version = "*",
    config = true,
  },
}

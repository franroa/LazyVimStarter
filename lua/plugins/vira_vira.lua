vim.g.vira_config_file_servers = "/home/francisco/.config/vira/vira_servers.json"
vim.g.vira_config_file_projects = "/home/francisco/.config/vira/vira_projects.json"


return {
  -- add symbols-outline
  {
    "n0v1c3/vira",
    lazy = false,
    dependencies = {
      -- which key integration
      {
        "folke/which-key.nvim",
        opts = function(_, opts)
          if require("lazyvim.util").has("noice.nvim") then
            opts.defaults["<leader>v"] = { name = "+vira" }
          end
        end,
      },
    },
    keys = {
      {
        "<leader>vj",
        function()
          vim.g.vira_active_issue =
              vim.fn.system("echo -n $(cut -d '_' -f1 <<< $(cut -d '/' -f2 <<<$(git branch --show-current)))")
          vim.notify(vim.g.vira_active_issue)
        end,
        desc = "Set the jira issue from branch"
      },
      {
        "<leader>vb",
        function() vim.cmd("terminal ~/.config/nvim/update_git_branch.sh " .. vim.g.vira_active_issue) end,
        desc = "Create a branch from Jira issue"
      },
    },
  },
}

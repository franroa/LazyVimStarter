vim.g.vira_config_file_servers = "/home/francisco/.config/vira/vira_servers.json"
vim.g.vira_config_file_projects = "/home/francisco/.config/vira/vira_projects.json"


-- vim.api.nvim_create_autocmd("VimEnter", {
--   callback = function()
--     local timer = vim.loop.new_timer()
--     timer:start(50, 0, vim.schedule_wrap(function()
--       vim.api.nvim_command('ViraLoadProject')
--       vim.g.vira_active_issue = vim.g.VIRA_ISSUE
--       vim.notify("Jira issue: " .. vim.g.VIRA_ISSUE)
--     end))
--   end,
-- })


function viraCmd(command)
  vim.cmd("ViraLoadProject")
  setViraIssueGlobal()
  vim.cmd(command)
end

function setViraIssueGlobal()
  vim.notify("Vira issue: " .. vim.g.VIRA_ISSUE)
  vim.g.vira_active_issue = vim.g.VIRA_ISSUE
end

vim.api.nvim_create_autocmd("BufLeave", {
  pattern = "vira_menu",
  callback = function()
    vim.g.VIRA_ISSUE = vim.g.vira_active_issue
    vim.notify("Set vira issue: " .. vim.g.VIRA_ISSUE)
  end,
})

return {
  -- add symbols-outline
  {
    lazy = true,
    cmd = "ViraLoadProject",
    "n0v1c3/vira",
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
        "<leader>ve", function() viraCmd("ViraEditComment") end, desc = "Edit comment"
      },
      {
        "<leader>vr", function() viraCmd("ViraReport") end, desc = "Issue Report"
      },
      {
        "<leader>vc", function() viraCmd("ViraComment") end, desc = "Add comment to issue"
      },
      {
        "<leader>vi", function() viraCmd("ViraIssues") end, desc = "All issues"
      },
      {
        "<leader>vn", function() viraCmd("ViraIssue") end, desc = "New issue"
      },
      {
        "<leader>vj",
        function()
          vim.g.vira_active_issue =
              vim.fn.system("echo -n $(cut -d '_' -f1 <<< $(cut -d '/' -f2 <<<$(git branch --show-current)))")
          setViraIssueGlobal()
        end,
        desc = "Set the jira issue from branch"
      },
      {
        "<leader>vb",
        function()
          setViraIssueGlobal()
          vim.cmd("terminal ~/.config/nvim/update_git_branch.sh " .. vim.g.vira_active_issue)
        end,
        desc = "Create a branch from Jira issue"
      },
    },
  },
}

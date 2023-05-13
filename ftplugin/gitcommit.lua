-- Git commit Jira Ticket
if vim.g.vira_active_issue == "None" then
  vim.notify("No Jira Ticket defined", "ERROR")
end

local context = {
  COMMIT_TITLE = vim.g.vira_active_issue,
  BRANCH_NAME = vim.fn.system("echo -n $(git branch --show-current)"),
  AUTHOR = "Francisco Roa Prieto",
  JIRA_TICKET = vim.g.vira_active_issue,
}
local lnum = vim.fn.nextnonblank(1)

while lnum and lnum < vim.fn.line("$") do
  -- vim.fn.setline(lnum, vim.fn.substitute(vim.fn.getline(lnum), "${\\w*}", context["\\=vim.fn.submatch(0)"], "g"))
  vim.fn.setline(lnum, vim.fn.substitute(vim.fn.getline(lnum), "${COMMIT_TITLE}", context["COMMIT_TITLE"], "g"))
  vim.fn.setline(lnum, vim.fn.substitute(vim.fn.getline(lnum), "${BRANCH_NAME}", context["BRANCH_NAME"], "g"))
  vim.fn.setline(lnum, vim.fn.substitute(vim.fn.getline(lnum), "${AUTHOR}", context["AUTHOR"], "g"))
  vim.fn.setline(lnum, vim.fn.substitute(vim.fn.getline(lnum), "${JIRA_TICKET}", context["JIRA_TICKET"], "g"))
  lnum = vim.fn.nextnonblank(lnum + 1)
end

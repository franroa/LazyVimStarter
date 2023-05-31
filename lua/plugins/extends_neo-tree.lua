return {
  -- file explorer
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      commands = {
        execute_bash = function(state)
          -- state.path # this points to the root dir of the tree
          local node = state.tree:get_node() -- node in focus when keybind is pressed
          local abs_path = node.path
          -- local rel_path = vim.fn.fnamemodify(abs_path, ":~:.")
          -- local file_name = node.name
          -- local is_file = node.type == "file" -- or `node.type` could be a "directory"
          local file_ext = node.ext
          -- local file_type = vim.filetype.match({ filename = abs_path })

          if file_ext ~= "sh" then
            vim.notify("Not a sh script")
            return
          end

          OpenOrCreateTerminal({
            non_k8s = true,
            name = abs_path,
            instruction = vim.o.shell .. " " .. abs_path
          })
        end,
      },
      window = {
        mappings = {
          ["B"] = "execute_bash",
        },
      },
    },
  },
}

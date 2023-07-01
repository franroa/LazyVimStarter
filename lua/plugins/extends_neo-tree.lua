return {
  -- file explorer
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      event_handlers = {

        {
          event = "neo_tree_window_after_open",
          handler = function()
            if vim.g.should_track_neotree_window then
              vim.g.was_neotree_manually_opened = true
            end
          end
        },
        {
          event = "neo_tree_window_after_close",
          handler = function()
            if vim.g.should_track_neotree_window then
              vim.g.was_neotree_manually_opened = false
            end
          end
        },

      },
      filesystem = {
        bind_to_cwd = false,
        follow_current_file = true,
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = false,
          -- hide_by_name = {
          --   ".DS_Store",
          --   "thumbs.db",
          --   "node_modules",
          -- },
        },
      },
      commands = {
        open_terminal = function(state)
          local node = state.tree:get_node() -- node in focus when keybind is pressed
          local abs_path = node.path

          local cwd = vim.fn.fnamemodify(abs_path, ":h")

          OpenOrCreateTerminal({
            non_k8s = true,
            name = cwd,
            dir = cwd,
            instruction = vim.o.shell
          })
        end,
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
          ["o"] = "open_terminal",
        },
      },
    },
  },
}

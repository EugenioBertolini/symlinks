return {
  "stevearc/oil.nvim",
  dependencies = {
    "nvim-mini/mini.icons",
    {
      "malewicz1337/oil-git.nvim",
      opts = {
        show_file_highlights = true,
        show_directory_highlights = true, -- Highlights parent folders if contained files are modified
        show_file_symbols = true,
        show_directory_symbols = true, -- Shows git status icons next to directory names
      },
    },
  },
  config = function()
    require("oil").setup({
      default_file_explorer = true,
      delete_to_trash = true,
      skip_confirm_for_simple_edits = true,
      git = {
        add = function(path)
          return true
        end,
        mv = function(src_path, dest_path)
          return true
        end,
        rm = function(path)
          return true
        end,
      },
      view_options = {
        show_hidden = true,
        natural_order = true,
        is_always_hidden = function(name, _)
          return name == ".." or name == ".git"
        end,
      },
      float = {
        padding = 2,
        max_width = 90,
        max_height = 0,
      },
      win_options = {
        wrap = true,
        winblend = 0,
      },
      keymaps = {
        ["<C-c>"] = "actions.close",
        ["<C-h>"] = false,
        ["<M-h>"] = "actions.select_split",
        ["<C-s>"] = false,
        ["<M-v>"] = "actions.select_vsplit",
        ["<C-l>"] = false,
        ["gr"] = "actions.refresh",
        ["<C-t>"] = false,
      },
    })

    require("oil-git").setup()
  end,
}

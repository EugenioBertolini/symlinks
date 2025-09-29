return {
  "stevearc/oil.nvim",
  opts = {},
  dependencies = { "nvim-mini/mini.icons" },
  config = function()
    require("oil").setup({
      default_file_explorer = true,
      delete_to_trash = true,
      skip_confirm_for_simple_edits = true,
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
  end,
}

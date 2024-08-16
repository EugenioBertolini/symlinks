return {
  "folke/noice.nvim",
  opts = {
    presets = {
      bottom_search = false,
    },
  },
  -- stylua: ignore
  keys = {
    { "<leader>n", "", desc = "noice"},
    { "<leader>nl", function() require("noice").cmd("last") end, desc = "Noice Last Message" },
    { "<leader>nh", function() require("noice").cmd("history") end, desc = "Noice History" },
    { "<leader>na", function() require("noice").cmd("all") end, desc = "Noice All" },
    { "<leader>nd", function() require("noice").cmd("dismiss") end, desc = "Dismiss All" },
    { "<leader>nt", function() require("noice").cmd("pick") end, desc = "Noice Picker (Telescope/FzfLua)" },
  },
}

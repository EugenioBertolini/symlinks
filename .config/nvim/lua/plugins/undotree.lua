return {
  "jiaoshijie/undotree",
  dependencies = "nvim-lua/plenary.nvim",
  config = true,
  -- stylua: ignore
  keys = {{ "<leader>U", "<cmd>lua require('undotree').toggle()<cr>", desc = "Toggle Undotree" }},
}

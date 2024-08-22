return {
  "gbprod/yanky.nvim",
  dependencies = "kkharji/sqlite.lua",
  opts = {
    ring = {
      storage = "sqlite",
      storage_path = "/home/fuge/.local/state/nvim/databases/yanky.db",
    },
  },
}

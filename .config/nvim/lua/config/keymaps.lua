-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local wk = require("which-key")
wk.add({ "<leader>K", desc = "which_key_ignore" })

-- Enter normal mode
vim.keymap.set("i", "jk", "<Esc>", { desc = "Enter Normal Mode" })

-- Split window right
vim.keymap.del("n", "<leader>|")
vim.keymap.set("n", "<leader>\\", "<C-w>v", { desc = "Split Window Right" })
vim.keymap.set("n", "<leader>^", "<C-w>v", { desc = "Split Window Right" })

-- Copy buffer path
vim.keymap.set("n", "<leader>bc", function()
  vim.fn.setreg("+", vim.fn.expand("%:p"))
end, { desc = "Copy Buffer Path" })

-- Toggle scrolloff
vim.keymap.set("n", "<leader>uS", function()
  vim.opt.scrolloff = 999 - vim.o.scrolloff
end, { desc = "Toggle Scrolloff" })

-- Oil keymaps and icon
wk.add({
  {
    "<leader>o",
    "<cmd>Oil<CR>",
    desc = "Oil",
    icon = { icon = "󰙅", color = "purple" },
  },
})
vim.keymap.set("n", "-", "<cmd>Oil<CR>")

-- UndoTree icon
wk.add({ "<leader>U", desc = "UndoTree", icon = { icon = "󰁯", color = "orange" } })

-- Refactor icon (that was missing)
wk.add({
  mode = { "n", "v" },
  {
    "<leader>r",
    group = "refactor",
    icon = { icon = "󰌇", color = "orange" },
  },
})

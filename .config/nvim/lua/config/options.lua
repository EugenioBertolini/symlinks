-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.scrolloff = 8
vim.opt.listchars = { tab = "» ", multispace = " ", trail = "", extends = "⟩", precedes = "⟨" }
vim.opt.colorcolumn = "89,90"
vim.opt.clipboard = "unnamedplus"
if vim.env.SSH_TTY then
  local osc52 = require("vim.ui.clipboard.osc52")

  vim.g.clipboard = {
    name = "OSC 52 with register sync",
    copy = {
      ["+"] = osc52.copy("+"),
      ["*"] = osc52.copy("*"),
    },
    -- Use Neovim's internal registers for paste to avoid the Kitty read prompt
    paste = {
      ["+"] = function()
        return { vim.fn.split(vim.fn.getreg(""), "\n"), vim.fn.getregtype("") }
      end,
      ["*"] = function()
        return { vim.fn.split(vim.fn.getreg(""), "\n"), vim.fn.getregtype("") }
      end,
    },
  }

  vim.opt.clipboard = "unnamedplus"
end

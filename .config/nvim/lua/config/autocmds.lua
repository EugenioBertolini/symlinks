-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    local highlights = {
      "Normal",
      "LineNr",
      "Folded",
      "NonText",
      "SpecialKey",
      "VertSplit",
      "SignColumn",
      "EndOfBuffer",
      "TablineFill", -- this is specific to how I like my tabline to look like
    }
    for _, name in pairs(highlights) do
      vim.cmd.highlight(name .. " guibg=none ctermbg=none")
    end
  end,
})

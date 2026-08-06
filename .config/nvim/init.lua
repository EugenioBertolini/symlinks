-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- Save the original apply_workspace_edit function
local original_apply_workspace_edit = vim.lsp.util.apply_workspace_edit

-- Override it to sanitize the payload before ANY plugin can apply it
vim.lsp.util.apply_workspace_edit = function(workspace_edit, client_offset_encoding)
  if workspace_edit then
    -- 1. Sanitize documentChanges (modern LSP format)
    if workspace_edit.documentChanges then
      for _, change in ipairs(workspace_edit.documentChanges) do
        if change.edits then
          for _, edit in ipairs(change.edits) do
            edit.annotationId = nil -- Strip the problematic ID
          end
        end
      end
    end

    -- 2. Sanitize standard changes (older LSP format)
    if workspace_edit.changes then
      for _, edits in pairs(workspace_edit.changes) do
        for _, edit in ipairs(edits) do
          edit.annotationId = nil -- Strip the problematic ID
        end
      end
    end
  end

  -- Pass the cleaned workspace_edit to the original Neovim function
  return original_apply_workspace_edit(workspace_edit, client_offset_encoding)
end

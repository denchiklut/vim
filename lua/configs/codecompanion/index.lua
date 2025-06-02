local M = {}

M.setup = function()
  vim.api.nvim_create_autocmd("User", {
    pattern = "CodeCompanionRequest*",
    callback = function(args)
      local data = args.data or {}
      local context = data.context or {}

      if vim.tbl_isempty(context) then
        return
      end

      local ns = vim.api.nvim_create_namespace("CodeCompanionInline_" .. data.id)
      local extmarks = require("configs.codecompanion.extmarks").new(context, ns)
      local block_spinner = require("configs.codecompanion.block_spinner").new(context, ns)

      if args.match:find "StartedInline" then
        extmarks:create_extmarks()
        block_spinner:start()
      elseif args.match:find "FinishedInline" then
        extmarks:clear_extmarks()
        block_spinner:stop()
      end
    end,
  })
end

return M

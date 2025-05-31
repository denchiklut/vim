local extmarks = require "configs.codecompanion.extmarks"
local loader = require "configs.codecompanion.loader"

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

      if args.match:find "StartedInline" then
        extmarks.create_extmarks(context, ns)
        loader.start_spinners(context, ns)
      elseif args.match:find "FinishedInline" then
        extmarks.clear_extmarks(context, ns)
        loader.stop_spinner(ns)
      end
    end,
  })
end

return M

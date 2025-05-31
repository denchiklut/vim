local M = {}

M.set_extmark = function(buff, ns, line_num, sign_text)
  vim.api.nvim_buf_set_extmark(buff, ns, line_num - 1, 0, {
    sign_hl_group = "DiagnosticVirtualTextWarn",
    sign_text = sign_text,
    priority = 2048,
  })
end

M.create_extmarks = function(context, ns)
  if context.start_line == context.end_line then
    return M.set_extmark(context.bufnr, ns, context.start_line, "")
  end

  M.set_extmark(context.bufnr, ns, context.start_line, "┌")

  for i = context.start_line + 1, context.end_line - 1 do
    M.set_extmark(context.bufnr, ns, i, "│")
  end

  if context.end_line > context.start_line then
    M.set_extmark(context.bufnr, ns, context.end_line, "└")
  end
end

M.clear_extmarks = function(context, ns)
  vim.api.nvim_buf_clear_namespace(context.bufnr, ns, 0, -1)
end

return M

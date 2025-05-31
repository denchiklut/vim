local spinner_opts = {
  hl_group = "Comment",
  repeat_interval = 100,
  extmark = {
    virt_text_pos = "inline",
    priority = 1000,
    virt_text_repeat_linebreak = true,
  },
}

local M = {
  bufnr = 0,
  ns_id = 0,
  start_line = 0,
  end_line = 0,
  ids = {},
  patterns = {},
  current_index = 1,
  timer = nil,
  opts = spinner_opts,
  width = 0,
  height = 0,
  border_top = "",
  border_bottom = "",
}

function M.new(opts)
  local lines = vim.api.nvim_buf_get_lines(opts.bufnr, opts.start_line - 1, opts.end_line, false)
  local width = vim.fn.max(vim
    .iter(lines)
    :map(function(line)
      return vim.fn.strdisplaywidth(line)
    end)
    :totable())

  local merged_opts = vim.tbl_deep_extend("force", spinner_opts, opts.opts or {})
  local patterns = {}

  local raw_patterns = {
    "╲  ",
    " ╲ ",
    "  ╲",
  }

  if merged_opts.patterns and #merged_opts.patterns > 0 then
    raw_patterns = merged_opts.patterns
  end

  local pattern_width = vim.fn.strdisplaywidth(raw_patterns[1])
  local repetitions = pattern_width > 0 and math.ceil(width / pattern_width) or width
  local horizontal_line = string.rep("─", repetitions * pattern_width)

  for _, pattern in ipairs(raw_patterns) do
    table.insert(patterns, string.rep(pattern, repetitions))
  end

  return setmetatable({
    bufnr = opts.bufnr,
    ns_id = opts.ns_id,
    start_line = opts.start_line - 1,
    end_line = opts.end_line - 1,
    ids = {},
    patterns = patterns,
    current_index = 1,
    timer = vim.uv.new_timer(),
    opts = merged_opts,
    width = width,
    height = #lines,
    border_top = "╭" .. horizontal_line .. "╮",
    border_bottom = "╰" .. horizontal_line .. "╯",
  }, { __index = M })
end

function M:get_virtual_text(i)
  local pattern_index = ((i + self.current_index - 1) % #self.patterns) + 1
  local pattern = self.patterns[pattern_index]

  if self.height <= 2 then
    return { { pattern, "Comment" } }
  end

  if i == self.start_line then
    return { { self.border_top, "Comment" } }
  end

  if i == self.end_line then
    return { { self.border_bottom, "Comment" } }
  end

  return { { "│" .. pattern .. "│", "Comment" } }
end

function M:set_new_extmarks()
  self.ids = {}
  for i = self.start_line, self.end_line do
    self.ids[i] = vim.api.nvim_buf_set_extmark(
      self.bufnr,
      self.ns_id,
      i,
      0,
      vim.tbl_deep_extend("force", self.opts.extmark, { virt_text = self:get_virtual_text(i) })
    )
  end
end

function M:set_extmarks()
  for i, id in pairs(self.ids) do
    local current_pos = vim.api.nvim_buf_get_extmark_by_id(self.bufnr, self.ns_id, id, {})
    pcall(function()
      vim.api.nvim_buf_set_extmark(
        self.bufnr,
        self.ns_id,
        current_pos[1],
        0,
        vim.tbl_deep_extend("force", self.opts.extmark, { virt_text = self:get_virtual_text(i), id = id })
      )
    end)
  end
end

function M:start()
  self:set_new_extmarks()
  self.timer:start(
    0,
    self.opts.repeat_interval,
    vim.schedule_wrap(function()
      self.current_index = (self.current_index % #self.patterns) + 1
      self:set_extmarks()
    end)
  )
end

function M:stop()
  if self.timer then
    self.timer:stop()
    self.timer:close()
    self.timer = nil
  end
  if self.opts.extmark then
    for _, id in pairs(self.ids) do
      vim.schedule(function()
        vim.api.nvim_buf_del_extmark(self.bufnr, self.ns_id, id)
      end)
    end
  end
end

return M

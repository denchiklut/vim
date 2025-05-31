local spinner_opts = {
  spinner_text = "  Processing",
  spinner_frames = { "⣷", "⣯", "⣟", "⡿", "⢿", "⣻", "⣽", "⣾" },
  hl_group = "DiagnosticVirtualTextWarn",
  repeat_interval = 100,
  extmark = {
    virt_text_pos = "inline",
    priority = 1000,
  },
}

local VirtualTextSpinner = {
  bufnr = 0,
  ns_id = 0,
  line_num = 0,
  current_index = 1,
  timer = nil,
  opts = spinner_opts,
}

function VirtualTextSpinner.new(opts)
  local width = opts.width or 0
  local spinner_opts = vim.tbl_deep_extend("force", spinner_opts, opts.opts or {})
  local width_center = width - spinner_opts.spinner_text:len()
  local col = width_center > 0 and math.floor(width_center / 2) or 0
  return setmetatable({
    bufnr = opts.bufnr,
    ns_id = opts.ns_id,
    line_num = opts.line_num - 1,
    current_index = 1,
    timer = vim.uv.new_timer(),
    opts = vim.tbl_deep_extend("force", spinner_opts, { extmark = { virt_text_win_col = col } }),
  }, { __index = VirtualTextSpinner })
end

function VirtualTextSpinner:get_virtual_text()
  return { { self.opts.spinner_text .. " " .. self.opts.spinner_frames[self.current_index] .. " ", self.opts.hl_group } }
end

function VirtualTextSpinner:set_extmark()
  return vim.api.nvim_buf_set_extmark(self.bufnr, self.ns_id, self.line_num, 0, self.opts.extmark)
end

function VirtualTextSpinner:start()
  self.opts.extmark.virt_text = self:get_virtual_text()
  self.opts.extmark.id = self:set_extmark()
  self.timer:start(
    0,
    self.opts.repeat_interval,
    vim.schedule_wrap(function()
      self.current_index = self.current_index % #self.opts.spinner_frames + 1
      self.opts.extmark.virt_text = self:get_virtual_text()
      self:set_extmark()
    end)
  )
end

function VirtualTextSpinner:stop()
  if self.timer then
    self.timer:stop()
    self.timer:close()
    self.timer = nil
  end
  if self.opts.extmark then
    vim.schedule(function()
      vim.api.nvim_buf_del_extmark(self.bufnr, self.ns_id, self.opts.extmark.id)
    end)
  end
end

return VirtualTextSpinner

local M = {}
M.__index = M

local virtual_text_spinners = {}

function M.new(context, ns)
  return setmetatable({ context = context, ns = ns }, M)
end

function M:start_spinners()
  local block_spinner = require("configs.codecompanion.block_spinner").new(self.context, self.ns)
  local spinner = require("configs.codecompanion.spinner").new {
    ns_id = self.ns,
    bufnr = self.context.bufnr,
    line_num = self.context.start_line + math.floor((self.context.end_line - self.context.start_line) / 2),
    width = block_spinner.width,
    opts = {
      repeat_interval = 100,
      extmark = { virt_text_pos = "overlay", priority = 2049 },
    },
  }

  spinner:start()
  block_spinner:start()
  virtual_text_spinners[self.ns] = { spinner, block_spinner }
end

function M:stop_spinner()
  local block_spinner, spinner = unpack(virtual_text_spinners[self.ns])

  if spinner then
    spinner:stop()
  end

  if block_spinner then
    block_spinner:stop()
  end

  virtual_text_spinners[self.ns] = nil
end

return M

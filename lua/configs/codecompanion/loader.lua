local M = {}

local virtual_text_spinners = {}

M.start_spinners = function(context, ns)
  local block_spinner = require("configs.codecompanion.block_spinner").new {
    bufnr = context.bufnr,
    ns_id = ns,
    start_line = context.start_line,
    end_line = context.end_line,
    opts = {
      hl_group = "Comment",
      repeat_interval = 100,
      extmark = {
        virt_text_pos = "overlay",
        priority = 2048,
      },
    },
  }

  local spinner = require("configs.codecompanion.spinner").new {
    bufnr = context.bufnr,
    ns_id = ns,
    line_num = context.start_line + math.floor((context.end_line - context.start_line) / 2),
    width = block_spinner.width,
    opts = {
      repeat_interval = 100,
      extmark = { virt_text_pos = "overlay", priority = 2049 },
    },
  }

  spinner:start()
  block_spinner:start()
  virtual_text_spinners[ns] = { spinner, block_spinner }
end

M.stop_spinner = function(ns_id)
  local block_spinner, spinner = unpack(virtual_text_spinners[ns_id])
  if spinner then
    spinner:stop()
  end
  if block_spinner then
    block_spinner:stop()
  end
  virtual_text_spinners[ns_id] = nil
end

return M

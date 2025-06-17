local venv = os.getenv('VIRTUAL_ENV')
command = string.format('%s/bin/python', venv)
local dap = require('dap')
local dap_python = require('dap-python').setup(command)

-- キーバインド（必要に応じて）
vim.keymap.set('n', '<F5>', dap.continue)
vim.keymap.set('n', '<F10>', dap.step_over)
vim.keymap.set('n', '<F11>', dap.step_into)
vim.keymap.set('n', '<F12>', dap.step_out)
vim.keymap.set('n', '<Leader>b', dap.toggle_breakpoint)
vim.keymap.set('n', '<Leader>lp', function()
  dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))
end)
vim.keymap.set('n', '<Leader>dr', dap.repl.open)
vim.keymap.set('n', '<Leader>dl', dap.run_last)

